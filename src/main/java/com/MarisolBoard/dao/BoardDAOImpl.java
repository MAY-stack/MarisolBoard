package com.MarisolBoard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.MarisolBoard.dto.BoardVO;
import com.MarisolBoard.dto.FileVO;
import com.MarisolBoard.dto.LikeVO;
import com.MarisolBoard.dto.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	//의존성 주입으로 Spring bean 가져와서 사용
	@Autowired	//mybatis의 sqlSession
	private SqlSession sql;
	
	private static String namespace="com.MarisolBoard.mappers.Board";
	
	//게시물 목록 보기
	@Override
	public List<BoardVO> list(int startNum, int postNum, String keyword) {
		Map<String,Object> data = new HashMap<>();
		data.put("startNum", startNum);
		data.put("postNum", postNum);
		data.put("keyword", keyword);
		return sql.selectList(namespace + ".list", data);	//selectList() : 여러개의 값을 뽑는 메소드 // sql의 return이 com.SFTest.mappers.Board.list 가 됨
	}
	//selectOne() 하나의 값만 뽑은 메소드
	
	//전체 게시물 개수 확인
	@Override
	public int getTotalCount(String keyword) throws Exception {
		return sql.selectOne(namespace + ".getTotalCount", keyword);
	}
	
	//글쓰기
	@Override
	public void write(BoardVO board) {
		sql.insert(namespace + ".write", board);
	}
	
	////////////////////////////////////////////////////////////////////////////////
	//파일 업로드 정보 등록
	@Override
	public void fileInfoRegistry(Map<String,Object> fileInfo) throws Exception{
		sql.insert(namespace + ".fileInfoRegistry", fileInfo);
	};
	
	//게시글 내에서 업로드된 파일 목록 보기
	@Override
	public List<FileVO> fileListView(int seqno) throws Exception{
	return sql.selectList(namespace + ".fileListView", seqno);
	};
	
	//게시물 수정에서 게시물의 첨부파일 정보 삭제
	@Override
	public void deleteFileList(Map<String,Object> data) throws Exception{
		sql.delete(namespace + ".deleteFileList", data);
	};
	
	//게시물 삭제에서 파일 삭제를 위한 파일 목록 가져 오기
	@Override
	public List<FileVO> deleteFileOnBoard(int seqno) throws Exception{
	return sql.selectList(namespace + ".deleteFileOnBoard", seqno);
	};
	
	//회원 탈퇴 시 회원이 업로드한 파일 정보 가져 오기
	@Override
	public List<FileVO> fileInfoByUserid(String userid) throws Exception{
	return sql.selectList(namespace + ".fileInfoByUserid", userid);
	}; 
	
	//다운로드를 위한 파일 정보 보기
	@Override
	public FileVO fileInfo(int fileseqno) throws Exception{
	return sql.selectOne(namespace + ".fileInfo", fileseqno);
	};
	////////////////////////////////////////////////////////////////////////////////
	
	//게시물 상세 보기
	@Override
	public BoardVO view(int seqno) {

		return sql.selectOne(namespace + ".view", seqno);	
	}
	
	//조회수 업데이트
	@Override
	public void hitno(int seqno) {
		sql.update(namespace + ".hitno", seqno);
	}

	//게시물 수정하기
	@Override
	public void modify(BoardVO board) {
		sql.update(namespace + ".modify", board);		
	}
	
	//게시물 삭제
	@Override
	public void delete(int seqno) {
		sql.delete(namespace + ".delete", seqno);		
	}
	
	//좋아요/싫어요 확인 가져 오기
	@Override
	public LikeVO likeCheckView(int seqno,String userid) throws Exception {
		
		Map<String,Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("userid", userid);
		return sql.selectOne(namespace + ".likeCheckView", data);
	}
	
	//좋아요/싫어요 갯수 수정하기
	@Override
	public void boardLikeUpdate(int seqno, int likecnt, int dislikecnt) throws Exception {
		Map<String,Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("likecnt", likecnt);
		data.put("dislikecnt", dislikecnt);
		sql.update(namespace + ".boardLikeUpdate", data);
	}
	
	//좋아요/싫어요 확인 등록하기
	@Override
	public void likeCheckRegistry(Map<String,Object> map) throws Exception {
		sql.insert(namespace + ".likeCheckRegistry", map);
	}
	
	//좋아요/싫어요 확인 수정하기
	@Override
	public void likeCheckUpdate(Map<String,Object> map) throws Exception {
		sql.update(namespace + ".likeCheckUpdate", map);
	}
	
	//댓글 보기
	@Override
	public List<ReplyVO> replyView(ReplyVO reply) throws Exception{
		return sql.selectList(namespace + ".replyView", reply);
	}
	
	//댓글 수정
	@Override
	public void replyUpdate(ReplyVO reply) throws Exception{
		sql.update(namespace + ".replyUpdate", reply);
	}
	
	//댓글 등록
	@Override
	public void replyRegistry(ReplyVO reply) throws Exception{
		sql.insert(namespace + ".replyRegistry", reply);
	}
	
	//댓글 삭제
	@Override
	public void replyDelete(ReplyVO reply) throws Exception{
		sql.delete(namespace + ".replyDelete", reply);
	}

	//이전 게시물 번호
	@Override
	public int pre_seq(int seqno, String keyword) {
		Map<String, Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("keyword", keyword);
		return sql.selectOne(namespace + ".pre_seq", data);
	}

	//다음 게시물 번호
	@Override
	public int next_seq(int seqno, String keyword) {
		Map<String, Object> data = new HashMap<>();
		data.put("seqno", seqno);
		data.put("keyword", keyword);
		return sql.selectOne(namespace + ".next_seq", data);
	}

}
