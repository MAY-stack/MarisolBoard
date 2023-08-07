package com.MarisolBoard.controller;

import java.io.File;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.MarisolBoard.dto.BoardVO;
import com.MarisolBoard.dto.FileVO;
import com.MarisolBoard.dto.LikeVO;
import com.MarisolBoard.dto.ReplyVO;
import com.MarisolBoard.service.BoardService;
import com.MarisolBoard.util.Page_;

@Controller
public class BoardController {
	
	@Autowired
	BoardService service;
	
	@Autowired
	private ServletContext ctx;

	//첫 접속 시 홈페이지
	@GetMapping("/")
	public String getHome() {
		return "home";
	}
	
	//첫 접속 시 홈페이지
	@GetMapping("/test")
	public void getTest() {}
	
	//전역 변수
	static int postNum = 10;	//한 페이지 당 출력 게시물 수
	
	/*******************************************************************************************************/
	//게시물 목록 보기
	@GetMapping("/board/list")
	public void getList(Model model, @RequestParam(name="page", defaultValue="1") int pageNum, 
				@RequestParam(name="keyword", defaultValue="", required=false) String keyword) throws Exception {
		
		/*페이징 및 페이지 리스트 생성*/
		int pageListCount = 10;	//화면 하단에 보여지는 페이지 리스트 내의 페이지 갯수
		int startNum = ((pageNum-1)*postNum);
		
		/*페이징 및 pageList 정보 생성해서 넘기기*/
		Page_ page = new Page_();
		model.addAttribute("pageList", page.getPageList(pageNum, postNum, pageListCount, service.getTotalCount(keyword), keyword));
		/****************************/
		
		/*list, pageNum, keyword 정보 넘기기*/
		model.addAttribute("list", service.list(startNum, postNum, keyword));
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);
		model.addAttribute("totalCount", service.getTotalCount(keyword));
	}
	
	//게시물 등록(화면 보기)
	@GetMapping("/board/write")
	public void getWrite() throws Exception {};
	
	//첨부 파일 없는 게시물 등록
	@ResponseBody
	@PostMapping("/board/write")
	public String PostWrite(BoardVO board) throws Exception{
		System.out.println(board);
		service.write(board);
		
		return "{\"message\":\"good\"}";
	}
	//첨부 파일이 있는 글등록, 수정
	@ResponseBody
	@PostMapping("/board/fileUpload")
	public String postFileUpload(BoardVO board,@RequestParam("SendToFileList") List<MultipartFile> multipartFile, 
			@RequestParam("kind") String kind,@RequestParam(name="deleteFileList", required=false) int[] deleteFileList) throws Exception{

		int seqno =0;
		
		if(kind.equals("U")) {
			System.out.println("kind.equals U");
			seqno = board.getSeqno();
			service.modify(board);
			
			if(deleteFileList != null) {
				for(int i=0; i<deleteFileList.length; i++) {

					//파일 삭제 리스트 생성
					FileVO fileInfo = new FileVO();
					fileInfo = service.fileInfo(deleteFileList[i]);
					
					//실제 삭제는 추후 관리자 일괄로
					//File file = new File(path + fileInfo.getStored_filename());
					//file.delete();
					
					//파일 테이블에서 파일 정보 삭제 //게시물 수정에서 삭제할 파일 목록 전송 되면 이 값을 받아서 파일 정보(in tbl_file)를 하나씩 삭제하는 deleteFileList 실행
					Map<String,Object> data = new HashMap<>();
					data.put("kind", "F");	 
					data.put("fileseqno", deleteFileList[i]);
					service.deleteFileList(data);
					
				}
			}
		}
		
		if(!multipartFile.isEmpty()) {

			String webPath = "c:\\Repository\\upload\\";
			
			File targetFile = null; 
			Map<String,Object> fileInfo = null;		
			
			for(MultipartFile mpr:multipartFile) {
				
				String realPath = ctx.getRealPath(webPath);	//서버 내 실제 경로
				
				String org_filename = mpr.getOriginalFilename();	
				String org_fileExtension = org_filename.substring(org_filename.lastIndexOf("."));	
				String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;	
				long filesize = mpr.getSize() ;

				realPath += File.separator + stored_filename;
				
				targetFile = new File(realPath);
				if (!targetFile.exists()) //서버 내에 경로가 없으면 경로에 맞게 디렉토리 생성
					targetFile.mkdirs();
				mpr.transferTo(targetFile);
				
				fileInfo = new HashMap<>();
				fileInfo.put("org_filename",org_filename);
				fileInfo.put("stored_filename", stored_filename);
				fileInfo.put("filesize", filesize);
				fileInfo.put("seqno", seqno);
				fileInfo.put("userid", board.getUserid());
				fileInfo.put("kind", kind);
				service.fileInfoRegistry(fileInfo);
	
			}
		}	

		if(kind.equals("I")) { 
			service.write(board);
		}
		return "{\"message\":\"good\"}";
}

	//게시물 내용 상세보기
	@GetMapping("/board/view")
	public void getView(Model model, HttpSession session,
				@RequestParam("seqno") int seqno, @RequestParam("page") int pageNum,
				@RequestParam(name="keyword", defaultValue="", required=false) String keyword) throws Exception {
		
		//-- 작성자와 세션의 userid 비교 --//
		String userid = (String)session.getAttribute("userid");	
		String writerId = service.view(seqno).getUserid();
		if(!userid.equals(writerId)) {//작성자와 접속자의 userid 다르면
			//조회수 증가
			service.hitno(seqno);
			session.setAttribute("modify_authority", false);	//수정권한 false
		} else if(userid.equals(writerId)) {
			session.setAttribute("modify_authority", true);	//수정권한 true
			}
		
		//게시글에 대한 사용자의 좋아요 싫어요 데이터 가져오기
		LikeVO likeCheckView = service.likeCheckView(seqno, userid);
		
		//초기에 좋아요/싫어요 등록이 안되어져 있을 경우 "N"으로 초기화 
		if(likeCheckView == null) {
			model.addAttribute("myLikeCheck", "N");
			model.addAttribute("myDislikeCheck", "N");
		} else if(likeCheckView != null) {
			model.addAttribute("myLikeCheck", likeCheckView.getMylikecheck());
			model.addAttribute("myDislikeCheck", likeCheckView.getMydislikecheck());
		}
		
		//이전글, 다음글 페이지 카운트
//		int startNum = ((pageNum-1)*postNum);
//		int seq = 0;
//		System.out.println(seq);
//		for(int i = 0; i < postNum; i++) {
//			if(service.list(startNum, postNum, keyword).get(i).getSeqno()==(seqno)) {
//				seq = service.list(startNum, postNum, keyword).get(i).getSeq();
//			}
//		}
//		System.out.println("seq ="+seq);
//		int totalCount = service.getTotalCount(keyword);
//		int preV_PageNum = (int)Math.ceil((totalCount - seq)/(double)postNum);
////		int current_PageNum = (int)Math.ceil((totalCount - seq)/(double)postNum);
//		int nextV_PageNum = (int)Math.ceil((totalCount - seq + 1 )/(double)postNum);
//		System.out.println("이전글의 seq"+ (seq+1) + " 페이지" + preV_PageNum);
//		//System.out.println("현재글의 seq"+ (seq) + " 페이지" + current_PageNum);		
//		System.out.println("다음글의 seq"+ (seq-1) + " 페이지" + nextV_PageNum);
//		/*****************seq로 페이지 카운트 끝*******************/
//		//model.addAttribute("current_PageNum", current_PageNum);

//		model.addAttribute("pre_seq", service.pre_seq(seqno, keyword));
//		model.addAttribute("next_seq", service.next_seq(seqno, keyword));
//		model.addAttribute("preV_PageNum", preV_PageNum);
//		model.addAttribute("nextV_PageNum", nextV_PageNum);

		//seqno이 일치하는 게시글에 대한 데이터 전달
		model.addAttribute("page", pageNum);
		model.addAttribute("keyword", keyword);	//검색어 전달
		model.addAttribute("pre_seq", service.pre_seq(seqno, keyword));
		model.addAttribute("next_seq", service.next_seq(seqno, keyword));
		//model.addAttribute("nextV_PageNum", service.next_seq(seqno, keyword));
		model.addAttribute("view", service.view(seqno));
		model.addAttribute("fileListView", service.fileListView(seqno));
	}
	
	//좋아요/싫어요 관리
	@ResponseBody
	@PostMapping(value = "/board/likeCheck")
	public String postLikeCheck(@RequestBody Map<String, Object> likeCheckData) throws Exception {
		
		int seqno = Integer.valueOf((String) likeCheckData.get("seqno"));
		System.out.println(seqno);
		String userid = String.valueOf(likeCheckData.get("userid"));
		System.out.println(userid);
		int checkCnt = (int) likeCheckData.get("checkCnt");
		System.out.println(checkCnt);

		//현재 날짜, 시간 구해서 좋아요/싫어요 한 날짜/시간 입력 및 수정
		String likeDate = "";
		String dislikeDate = "";
		if(likeCheckData.get("mylikecheck").equals("Y")) 
			likeDate = LocalDateTime.now().toString();
		else if(likeCheckData.get("mydislikecheck").equals("Y")) 
			dislikeDate = LocalDateTime.now().toString();

		likeCheckData.put("likedate", likeDate);
		likeCheckData.put("dislikedate", dislikeDate);

		//TBL_LIKE 테이블 입력/수정
		LikeVO likeCheckView = service.likeCheckView(seqno,userid);
		if(likeCheckView == null) service.likeCheckRegistry(likeCheckData);
			else service.likeCheckUpdate(likeCheckData);

		//TBL_BOARD 내의 likecnt,dislikecnt 입력/수정 
		BoardVO board = service.view(seqno);
		
		int likeCnt = board.getLikecnt();
		int dislikeCnt = board.getDislikecnt();
			
		switch(checkCnt){
	    	case 1 : likeCnt --; break;
	    	case 2 : likeCnt ++; dislikeCnt --; break;
	    	case 3 : likeCnt ++; break;
	    	case 4 : dislikeCnt --; break;
	    	case 5 : likeCnt --; dislikeCnt ++; break;
	    	case 6 : dislikeCnt ++; break;
		}
		
		service.boardLikeUpdate(seqno,likeCnt,dislikeCnt);

		return "{\"likeCnt\":\"" + likeCnt + "\",\"dislikeCnt\":\"" + dislikeCnt + "\"}";
	}
	//******************좋아요/싫어요 관리 끝***************//
	
	//댓글 처리
	@ResponseBody
	@PostMapping("/board/reply")
	public List<ReplyVO> postReply(@RequestBody ReplyVO reply, @RequestParam("option") String option)throws Exception{
		switch(option) {
		case "L" : service.replyView(reply); //댓글 보기
					break;
		case "I" : service.replyRegistry(reply); //댓글 등록
					break;
		case "U" : service.replyUpdate(reply); //댓글 수정
					break;
		case "D" : service.replyDelete(reply); //댓글 삭제
					break;
		}
		return service.replyView(reply);
	}


	
	//첨부파일 다운로드(href 생성)
	@GetMapping("/board/filedownload")
	public void fileDownload(@RequestParam("fileseqno") int fileseqno, Model model, HttpServletResponse rs) throws Exception {
		System.out.println("fdcontroller");
		String webPath = "c:\\Repository\\upload\\";
		String realPath = ctx.getRealPath(webPath);	//서버 내 실제 경로
		String org_filename = service.fileInfo(fileseqno).getOrg_filename(); 
		String stored_filename = service.fileInfo(fileseqno).getStored_filename();	//seqno로 스토어드 파일네임 찾기
		
		realPath += File.separator + stored_filename;	//realPath를 파일명 포함한 실경로로 변경
		System.out.println(realPath);
		byte fileByte[] = FileUtils.readFileToByteArray(new File(realPath));
		
		//헤더값을 Content-Disposition로 주게 되면 Response Body로 오는 값을 filename으로 다운받으라는 것임
		//예) Content-Disposition: attachment; filename="hello.jpg"
		rs.setContentType("application/octet-stream");
		rs.setContentLength(fileByte.length);
		rs.setHeader("Content-Disposition", "attachment; filename=\""+URLEncoder.encode(org_filename, "UTF-8")+"\";");
		rs.getOutputStream().write(fileByte);
		rs.getOutputStream().flush();	// 버퍼에 있는 내용을 write함 위에까지로는 write 안 됨. 
		rs.getOutputStream().close();
		
	}//파일 다운로드 끝

	//게시물 삭제
	@GetMapping("/board/delete")
	public String getDelete(@RequestParam("seqno") int seqno) throws Exception {

		Map<String,Object> data = new HashMap<>();
		data.put("kind", "B");
		data.put("seqno", seqno);
		service.delete(seqno);	//글삭제
		service.deleteFileList(data);	//첨부파일들 checkfile='N'처리
		
		return "redirect:/board/list?page=1";
		
	}
	
//	//게시물 수정 화면 보기
//	@GetMapping("/board/modify")	//내용 상세보기와 데이터는 같고 화면에 뿌려주는 jsp가 다름
//	public void getModify (Model model, HttpSession session, @RequestParam("seqno") int seqno, @RequestParam("page") int pageNum,
//				@RequestParam(name="keyword", defaultValue="", required=false) String keyword) throws Exception {
//		
//		model.addAttribute("keyword", keyword);
//		model.addAttribute("view", service.view(seqno));
//		model.addAttribute("page", pageNum);		
//	}
//	
	
	//게시물 수정 화면 보기
	@GetMapping("/board/modify")
	public void GetModify(BoardVO board, Model model, 
			@RequestParam("page") int pageNum, @RequestParam("seqno") int seqno,
			@RequestParam(name="keyword", required=false) String keyword) 
			throws Exception {
		
		model.addAttribute("view", service.view(seqno));
		model.addAttribute("page",pageNum);
		model.addAttribute("keyword",keyword);
		model.addAttribute("fileListView", service.fileListView(seqno));
	}
		
	//게시물 수정 처리
	@ResponseBody
	@PostMapping("/board/modify")
	public String postModify(BoardVO board,@RequestParam("page") int pageNum,
			@RequestParam(name="keyword", required=false) String keyword,
			@RequestParam(name="deleteFileList", required=false) int[] deleteFileList) throws Exception {
		
		service.modify(board);
		
		if(deleteFileList != null) {
			
			for(int i=0; i<deleteFileList.length; i++) {

				//파일 정보 삭제
				FileVO fileInfo = new FileVO();
				fileInfo = service.fileInfo(deleteFileList[i]);
				//File file = new File(path + fileInfo.getStored_filename());
				//file.delete();
				
				//파일 테이블에서 파일 정보 삭제
				Map<String,Object> data = new HashMap<>();
				data.put("kind", "F");
				data.put("fileseqno", deleteFileList[i]);
				service.deleteFileList(data);
				
			}
		}
		
		return "{\"message\":\"good\"}";
	}

}
