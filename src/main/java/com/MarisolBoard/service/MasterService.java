package com.MarisolBoard.service;

import java.util.List;

import com.MarisolBoard.dto.FileVO;

public interface MasterService {

	//삭제 파일 목록 갯수
	public int fileDeleteCount();
	
	//삭제 파일 목록 정보
	public List<FileVO> fileDeleteList();
	
	//파일 삭제
	public void deleteFile(int fileseqno);	
	
}
