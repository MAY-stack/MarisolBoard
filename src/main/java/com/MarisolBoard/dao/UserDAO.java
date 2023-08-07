package com.MarisolBoard.dao;

import java.util.List;

import com.MarisolBoard.dto.AddressVO;
import com.MarisolBoard.dto.UserVO;

public interface UserDAO {
	
	//회원 등록 	
	public void userReg(UserVO user);	
	
	//아이디 중복 체크 
	public int idCheck(String userid);
	
	//아이디에 따른 비밀번호 확인 
	public String pwCheck(String userid);
	
	//이름, 연락처로 정보 찾기
	public UserVO findUserInfoByNameTelno(String username, String telno);
	
	//비밀번호 변경
	public void modifyPw(UserVO user);
	
	//회원 정보 보기  
	public UserVO userInfo(String userid);
	
	//사용자 정보 수정
	public void modifyUserInfo(UserVO user);
	
	//authkey 생성
	public void authKeyUpdate(UserVO loginData);
	
	//userInfoByAuthkey
	public UserVO userInfoByAuthkey(String authkey);
	
	//주소 전체 갯수 계산
	public int addrTotalCount(String addrSearch);

	//주소 검색
	public List<AddressVO> addrSearch(int startPoint, int postNum, String addrSearch);

}