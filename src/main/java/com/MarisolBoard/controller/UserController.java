package com.MarisolBoard.controller;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
//import java.time.LocalDateTime;
import java.text.DateFormat;
import java.text.FieldPosition;
import java.text.ParsePosition;
import java.util.Date;
//import java.time.format.DateTimeFormatter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.MarisolBoard.dto.AddressVO;
import com.MarisolBoard.dto.UserVO;
import com.MarisolBoard.service.UserService;
import com.MarisolBoard.util.Page;

@Controller
public class UserController {

	
	@Autowired	//비밀번호 의존성 주입
	private BCryptPasswordEncoder pwdEncoder;

	@Autowired
	UserService service;
	
	@Autowired
	private JavaMailSenderImpl mailSender;
    
	
	
	//비밀번호 확인 화면 보여주기
	@GetMapping("/user/pwCheck")
	public void getPwCheck(@RequestParam("userid") String userid, Model model) {
		
		model.addAttribute("userid", userid);
		
	}
	
	//비밀번호 확인
	@ResponseBody
	@PostMapping("/user/pwCheck")
	public String postPwCheck(@RequestBody UserVO user) throws Exception {
		
		System.out.println(user.getPassword());		//입력 받은 id의 pw 정보와 일치하면
		String regdPassword = service.pwCheck(user.getUserid());	
		if(!pwdEncoder.matches(user.getPassword(), regdPassword)) {	
			System.out.println("다르다고?");//비밀번호가 일치하지 않으면
			return "{\"message\":\"bad\"}";
		} else {				
				return "{\"message\":\"good\"}";
			}
	}
	
	//비밀번호 수정 화면 보여주기
	@GetMapping("/user/setpw")
	public void getSetpw(@RequestParam("userid") String userid, Model model) {
		
		model.addAttribute("userid", userid);
		
	}
	

	//비밀번호 수정 처리
	@ResponseBody
	@PostMapping("/user/setpw")
	public String postSetpw(@RequestBody UserVO user) {
		
		String password = user.getPassword();
		
		user.setPassword(pwdEncoder.encode(password)); // 비밀번호 암호화 처리
		System.out.println(pwdEncoder.encode(password));

		Date date = new Date();
		//user.setPw_set_date(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		user.setPw_set_date(date.toString());

		service.modifyPw(user);		
		
		return "{\"message\":\"good\"}";

	}
	
	
	//비밀번호 초기화(임시비밀번호 생성 및 발송)
	@ResponseBody
	@PostMapping("/user/resetpw")
	public String postResetpw(@RequestBody UserVO user) throws Exception {
		String username = user.getUsername();
		String telno = user.getTelno();
		System.out.println("resetpw");
		if(service.findUserInfoByNameTelno(username, telno) != null) {
			String userid = service.findUserInfoByNameTelno(username, telno).getUserid();
			UserVO member = service.userInfo(userid);
			String email = member.getEmail();
			
			//임시 비밀번호 생성
			String tempPW = createRandomString(8);
			//메일 발송
			sendMail(email, tempPW);		
			//DB의 비밀번호 정보 반영
			String endcodedAuthcode = pwdEncoder.encode(tempPW);
			member.setPassword(endcodedAuthcode); // 임시 비밀번호 암호화 처리
			member.setAuthcode(endcodedAuthcode);
			//member.setPw_set_date(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

			Date date = new Date();
			member.setPw_set_date(date.toString());
			
			service.modifyPw(member);
			
			//메일주소 마스킹 처리
			String maskingEmail = emailSpliter(email);
			return "{\"message\":\"good\", \"email\":\"" + maskingEmail + "\"}";
			} else {
				return "{\"message\":\"bad\"}";
			}
		
	}
	//이메일 스플릿 & 마스킹
	public String emailSpliter(String email){
        try{
        String[] emailSplited = email.split("@");
            if(emailSplited.length != 2){
                return email;
            }
    
            if(emailSplited[0].length() <= 2){  // 2자리 보다 작은 경우
                return email.charAt(0) + "*****@" + emailSplited[1];
            }else{
                return email.substring(0, 2) + "*****@" + emailSplited[1];
            }
        }catch (Exception e){
            System.out.println(e.toString());
            return null;
        }
    }
	
	// //이메일 인증
	// @GetMapping("/user/mailCheck")
	// public void getMailCheck(@RequestParam("email") String email) throws Exception {
		
	// 	String authCode = createRandomString(8);		
	// 	sendMail(email, authCode, "authMail");
		
	// }
	
    //메일 전송 메소드
    public void sendMail(String email, String authCode) throws Exception{
		
		//메일 작성
        String subject = "게시판| 임시 비밀번호입니다.";
        String content = "임시 비밀번호는 <br><span style='color:red;'>"+ authCode +"</span>입니다.";
        String from = "kyeong0521@naver.com";
        String to = email;	//받는 메일 주소
        
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail, "utf-8");
            
            mailHelper.setFrom(from);
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            
            //첨부파일
        //    FileSystemResource file = new FileSystemResource(new File("/resources/imges/welcome.jpg")); 
        //    mailHelper.addAttachment("/resources/imges/welcome.jpg", file);            
            
            mailSender.send(mail);
            
        } catch(Exception e) {
            e.printStackTrace();
        }
        
    }
	
	//마이페이지 보여주기
	@GetMapping("/user/mypage")
	public void getUserInfo(@RequestParam("userid") String userid, Model model) throws Exception {
    	model.addAttribute("user", service.userInfo(userid));	
	}

	//사용자 정보 수정
	@ResponseBody
	@PostMapping("/user/infomodify")
	public String postInfomodify(UserVO user, @RequestParam("fileUpload") List<MultipartFile> multipartFile,
									@RequestParam("profileImageChange") String profileImageChange) throws Exception {		
		
		System.out.println("저장이름 "+user.getStored_filename());
		if(profileImageChange.equals("Y")) {

			System.out.println(ProfileUpload(user, multipartFile));

		}
		service.modifyUserInfo(user);
		return "{\"msg\":\"good\"}";
	}
    
    //사용자 정보 등록(가입)화면 보기
	@GetMapping("/user/signup")
	public void getSignup() throws Exception {
	}
	
    //사용자 아이디 찾기 화면 보기
	@GetMapping("/user/find")
	public void getFind() throws Exception {
	}
	
    //사용자 아이디 찾기	
	@ResponseBody
	@PostMapping("/user/find")
	public String postFind(@RequestBody UserVO user) throws Exception {
		
		String username = user.getUsername();
		String telno = user.getTelno();
		
		if(service.findUserInfoByNameTelno(username, telno) != null) {
			String userid = service.findUserInfoByNameTelno(username, telno).getUserid();
			//String maskingId = maskingString(userid, 5);
			return "{\"message\":\"good\", \"userid\":\"" + userid + "\"}";
			} else {
				return "{\"message\":\"bad\"}";
			}
		
	}
	
	//회원 가입
	@ResponseBody
	@PostMapping("/user/signup")	//formData로 받으면 RequestBody로 받을 필요 없음,
	public String postSignup(UserVO user, @RequestParam("fileUpload") List<MultipartFile> multipartFile) throws Exception {		
		ProfileUpload(user,multipartFile);		
		user.setPassword(pwdEncoder.encode(user.getPassword())); // 비밀번호 암호화 처리
		service.userReg(user);
		return "{\"username\": \" "+ URLEncoder.encode(user.getUsername(), "UTF-8") + "\", \"status\":\"good\"}";
	}
	
	//아이디 존재 여부 확인 - DB에서 userid와 일치하는 행의 갯수 return
	@ResponseBody
	@PostMapping("/user/idCheck")
	public int postIdCheck(@RequestBody String userid) throws Exception {
		System.out.println("idcheck");
		System.out.println(service.idCheck(userid));
		return service.idCheck(userid);	//DB에서 userid와 일치하는 행의 갯수
	}
	
	//우편번호 (주소) 검색
	@GetMapping("/user/addrSearch")
	public void getSearchAddr(@RequestParam("addrSearch") String addrSearch,
			@RequestParam("page") int pageNum, Model model) throws Exception {
		
		int postNum = 5;
		int startPoint = (pageNum -1)*postNum; //테이블에서 읽어 올 행의 위치
		int listCount = 10;
		
		Page page = new Page();
		
		int totalCount = service.addrTotalCount(addrSearch);
		List<AddressVO> list = new ArrayList<AddressVO>();
		list = service.addrSearch(startPoint, postNum, addrSearch);

		model.addAttribute("list", list);
		model.addAttribute("pageListView", page.getPageAddress(pageNum, postNum, listCount, totalCount, addrSearch));
		
	}
	
	//로그인 화면 보기
	@GetMapping("/user/login")
		public void getLogin() throws Exception {}

	//로그인 처리	
	@ResponseBody
	@PostMapping("/user/login")
	public String postLogin(UserVO loginData, @RequestParam("autologin") String autoLogin,
							HttpSession session, RedirectAttributes rd) throws Exception {
		String authkey="";		
		
//		로그인 시 자동 로그인 체크할 경우 authkey 생성
		if(autoLogin.equals("NEW")) {
			authkey=UUID.randomUUID().toString().replaceAll("-", "");//서버 저장용 이름 생성
			loginData.setAuthkey(authkey);
			service.authKeyUpdate(loginData);
		}
		
		if(autoLogin.equals("PASS")) {
			authkey=loginData.getAuthkey();
			UserVO userInfoByAK = service.userInfoByAuthkey(authkey);
			if(userInfoByAK != null) {
				session.setAttribute("userid", userInfoByAK.getUserid());		//세션에 userid set
				session.setAttribute("username", userInfoByAK.getUsername());	//세션에 username set
				session.setAttribute("role", userInfoByAK.getRole());
				
				//비밀번호 변경 기간 확인
				String pwc = "N";

//				LocalDateTime pwSetDateTime = LocalDateTime.parse(userInfoByAK.getPw_set_date(),
//			        	DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//				if(LocalDateTime.now().isAfter(pwSetDateTime.plusDays(30))) pwc = "Y";


				//----//
//				Date pwSetDateTime = new Date();
//
//				LocalDateTime pwSetDateTime = LocalDateTime.parse(userInfoByAK.getPw_set_date(),
//						DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//				if(LocalDateTime.now().isAfter(pwSetDateTime.plusDays(30))) pwc = "Y";
				
				session.setAttribute("pwc", pwc);
				
				
				return "{\"message\":\"good\",\"authkey\":\"" + loginData.getAuthkey() + "\"}";		//게시물 목록 페이지로 보냄
			} else return "{\"message\":\"bad\"}";
		}
		
		//아이디 존재 여부 확인
		if(service.idCheck(loginData.getUserid())==0) {
			return "{\"message\":\"ID_NOT_FOUND\"}";
		} else {
			
			UserVO member = service.userInfo(loginData.getUserid());
			
			//id 존재하면 pw 확인 처리
			//id의 pw 정보 가져옴
			String regdPassword = service.pwCheck(loginData.getUserid());	
			if(!pwdEncoder.matches(loginData.getPassword(), regdPassword)) {	//비밀번호가 일치하지 않으면
				return "{\"message\":\"PASSWORD_NOT_FOUND\"}";
			} else {	//비밀번호 일치하면 세션 생성
					session.setAttribute("userid", member.getUserid());		//세션에 userid set
					session.setAttribute("username", member.getUsername());	//세션에 username set
					session.setAttribute("role", member.getRole());
					
					//비밀번호 변경 기간 확인
					String pwc = "N";
//					LocalDateTime pwSetDateTime = LocalDateTime.parse(member.getPw_set_date(),
//				        	DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
//					if(LocalDateTime.now().isAfter(pwSetDateTime.plusDays(30))) pwc = "Y";
					
					session.setAttribute("pwc", pwc);
					
					//임시비밀번호여부 확인
					String authcode = service.userInfo(member.getUserid()).getAuthcode();
					if(pwdEncoder.matches(loginData.getPassword(), authcode)) {
						session.setAttribute("tmepPw", "Y");
					};
					return "{\"message\":\"good\",\"authkey\":\"" + member.getAuthkey() + "\"}";		//게시물 목록 페이지로 보냄
				} 
			}
		
	}
		
	//로그아웃
	@GetMapping("/user/logout")
	public String getLogout(HttpSession session, Model model, RedirectAttributes rd ) throws Exception {
		//세션에서 userid, username  제거
		session.removeAttribute("userid");
		session.removeAttribute("username");
		
		
		rd.addFlashAttribute("msg", "정상적으로 로그아웃 되었습니다.");
        rd.addFlashAttribute("url","/");
        return "redirect:/alert"; // alert 후, 전달된 url 파라미터로 이동시키는 페이지
	}
	
	//비밀번호 사용기간 30일 연장
	@GetMapping("/user/pwextend")
	public String getPwextend(HttpSession session, Model model, RedirectAttributes rd ) throws Exception {
		String userid = (String)session.getAttribute("userid");
		UserVO user = service.userInfo(userid);
//		user.setPw_set_date(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
				
		service.modifyUserInfo(user);
		session.setAttribute("pwex", "N");
		
		rd.addFlashAttribute("msg", "처리 되었습니다.");
        rd.addFlashAttribute("url","/");
        return "redirect:/alert";
	}
	
	//로그인 성공 페이지
	@GetMapping("/user/notice")
	public void getNotice() {}
	
	//Alert & Redirect
	@GetMapping("/alert")
	public void getAlert() {}

    
    //문자열 마스킹 메서드 (targetString : 마스킹할 문자열, i : 앞쪽에 남길 글자 수)
    public static String maskingString(String targetString, int i) {
        return targetString.replaceAll("(?<=.{" + i + "}).", "*");
    }
    
    //임시 비밀번호 생성 메서드(생성할 문자열의 길이)
    public static String createRandomString(int length) {
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = length;
        Random random = new Random();
		String randomString = "tempPassword";
//        String randomString = random.ints(leftLimit, rightLimit + 1)
//                                    .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
//                                    .limit(targetStringLength)
//                                    .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
//                                    .toString();
        return randomString;
    }

	//프로필 사진 업로드 메서드
	public String ProfileUpload(UserVO user, List<MultipartFile> multipartFile) throws IllegalStateException, IOException{

		//String WebPath = "c:\\Repository\\profile\\";
		String WebPath = "/home/ec2-user/Repository/profile/";
		String realPath = WebPath;//ctx.getRealPath(webPath);	//서버 내 실제 경로

		if(!multipartFile.isEmpty()) {
			for(MultipartFile mpr:multipartFile) {		
				String org_filename = mpr.getOriginalFilename();	//kkk.txt	
				String org_fileExtension = org_filename.substring(org_filename.lastIndexOf(".")); //. 부터 뒷부분(확장자명)을 가져오라는 것	
				String stored_filename = UUID.randomUUID().toString().replaceAll("-", "") + org_fileExtension;//서버 저장용 이름 생성	
				
				long filesize = mpr.getSize() ;	//파일 사이즈
				
				File savePath = new File(realPath);	
					if (!savePath.exists()) //서버 내에 경로가 없으면 경로에 맞게 디렉토리 생성
						savePath.mkdirs();
				
				realPath += File.separator + stored_filename;
				File saveFile = new File(realPath);	//realPath(경로+파일명)라는 savefile객체 생성 
				
				mpr.transferTo(saveFile);	//첨부한 파일을 saveFile로 저장
				System.out.println(org_filename);
				System.out.println(stored_filename);
				System.out.println(filesize);
				
				user.setOrg_filename(org_filename);
				user.setStored_filename(stored_filename);
				user.setFilesize(filesize);

				System.out.println(user.getOrg_filename());
				System.out.println(user.getStored_filename());
				System.out.println(user.getFilesize());
				
				System.out.println("서버 저장경로 = " + realPath);
			}
			return "good";
		} else return "bad";

	}

}