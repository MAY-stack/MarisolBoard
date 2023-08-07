package com.MarisolBoard.dao;

import java.util.List;

import com.MarisolBoard.dto.FileVO;

public interface MasterDAO {
	
	//삭제할 파일 갯수 계산
	public int fileDeleteCount();
	
	//삭제할 파일 정보 목록
	public List<FileVO> fileDeleteList();
	
	//파일 삭제
	public void deleteFile(int fileseqno);
	
}
