package com.MarisolBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MarisolBoard.dao.UserDAO;
import com.MarisolBoard.dto.AddressVO;
import com.MarisolBoard.dto.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO dao;
	
	//사용자 정보 등록(가입)
	@Override
	public void userReg(UserVO user) {
		dao.userReg(user);
	}
	
	//아이디 존재 여부 확인
	@Override
	public int idCheck(String userid) {
		return dao.idCheck(userid);
	}
	
	//해당 아이디의 비밀번호 확인
	@Override
	public String pwCheck(String userid) {
		return dao.pwCheck(userid);
	}
	
	//이름, 연락처로 정보 찾기
	public UserVO findUserInfoByNameTelno(String username, String telno) {
		return dao.findUserInfoByNameTelno(username, telno);
	}
	
	//비밀번호 변경
	public void modifyPw(UserVO user) {
		dao.modifyPw(user);
	}
	
	//회원 정보 보기
	@Override
	public UserVO userInfo(String userid) {
		return dao.userInfo(userid);
	}
	
	//회원 정보 수정
	@Override
	public void modifyUserInfo(UserVO user) {
		dao.modifyUserInfo(user);
	}
	

	//authkey 생성
	@Override
	public void authKeyUpdate(UserVO loginData) {
		dao.authKeyUpdate(loginData);
	}
	
	//authkey를 가진 사용자 정보
	@Override
	public UserVO userInfoByAuthkey(String authkey) {
		return dao.userInfoByAuthkey(authkey);
	}
	
	//우편번호 전체 갯수 가져 오기
	@Override
	public int addrTotalCount(String addrSearch) {
		return dao.addrTotalCount(addrSearch);
	}

	//우편번호 검색
	@Override
	public List<AddressVO> addrSearch(int startPoint, int postNum, String addrSearch) {
		return dao.addrSearch(startPoint, postNum, addrSearch);
	}

}