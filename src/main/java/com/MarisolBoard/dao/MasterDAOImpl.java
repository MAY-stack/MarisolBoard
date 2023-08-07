package com.MarisolBoard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.MarisolBoard.dto.FileVO;

@Repository
public class MasterDAOImpl implements MasterDAO {

	//의존성 주입으로 Spring bean 가져와서 사용
	@Autowired	//mybatis의 sqlSession
	private SqlSession sql;
	
	private static String namespace="com.MarisolBoard.mappers.Master";
	
	//삭제할 파일 갯수 계산
	@Override
	public int fileDeleteCount() {
		return sql.selectOne(namespace + ".fileDeleteCount");
	}

	//삭제할 파일 정보 목록
	@Override
	public List<FileVO> fileDeleteList() {
		return sql.selectList(namespace + ".fileDeleteList");
	}

	//파일 삭제
	@Override
	public void deleteFile(int fileseqno) {
		sql.delete(namespace + ".deleteFile", fileseqno);
	}

}
