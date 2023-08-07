package com.MarisolBoard.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.MarisolBoard.dto.AddressVO;
import com.MarisolBoard.dto.UserVO;
@Repository
public class UserDAOImpl implements UserDAO {

	//의존성 주입으로 Springbean 가져와서 사용
	@Autowired	//mybatis의 sqlSession
	private SqlSession sql;
	
	private static String namespace="com.MarisolBoard.mappers.User";
	
	//사용자 정보 등록(가입)
	@Override
	public void userReg(UserVO user) {
		sql.insert(namespace + ".userReg", user);
	}

	//아이디 존재 여부 확인
	@Override
	public int idCheck(String userid) {
		return sql.selectOne(namespace + ".idCheck", userid);
	}
	
	//아이디에 따른 비밀번호 체크
	@Override
	public String pwCheck(String userid) {
		return sql.selectOne(namespace + ".pwCheck", userid);
	}

	
	//이름, 연락처로 정보 찾기
	@Override
	public UserVO findUserInfoByNameTelno(String username, String telno) {
		
		Map<String, String> data = new HashMap<>();
		data.put("username", username);
		data.put("telno", telno);
		
		return sql.selectOne(namespace + ".findUserInfoByNameTelno", data);
	}
	
	//비밀번호 변경
	@Override
	public void modifyPw(UserVO user) {
		sql.update(namespace + ".modifyPw", user);
	}
	//사용자 정보 보기
	@Override
	public UserVO userInfo(String userid) {
		return sql.selectOne(namespace + ".userInfo", userid);
	}
	
	//사용자 정보 수정
	@Override
	public void modifyUserInfo(UserVO user) {
		sql.update(namespace + ".modifyUserInfo", user);
	}

	//authkey 업데이트
	@Override
	public void authKeyUpdate(UserVO loginData) {
		sql.update(namespace + ".authKeyUpdate", loginData);
	}
	
	//authkey를 가진 사용자 정보
	@Override
	public UserVO userInfoByAuthkey(String authkey) {
		return sql.selectOne(namespace + ".userInfoByAuthkey", authkey);
	}
	
	//우편번호 최대 행수 계산
	@Override
	public int addrTotalCount(String addrSearch) {
		return sql.selectOne(namespace+ ".addrTotalCount",addrSearch);
	}

	//우편번호 검색 
	@Override
	public List<AddressVO> addrSearch(int startPoint, int postNum, String addrSearch) {

		Map<String,Object> data = new HashMap<>();
		data.put("startPoint", startPoint);
		data.put("postNum",postNum);
		data.put("addrSearch", addrSearch);
		
		return sql.selectList(namespace + ".addrSearch", data);
	}

}