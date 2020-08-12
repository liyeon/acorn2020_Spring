package com.gura.spring05.users.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.spring05.users.dto.UsersDto;

@Repository
public class UsersDaoImpl implements UsersDao{
	@Autowired
	private SqlSession session;

	@Override
	public boolean isExist(String inputId) {
		//입력한 아이디가 존재하는지 id를 select 해본다.
		String id = session.selectOne("users.isExist", inputId);
		if(id==null) {//존재하지 않는 아이디
			return false;
		}else {//존재하는 아이디
			return true;}
		
	}//isExist

	@Override
	public void insert(UsersDto dto) {
		session.insert("users.insert", dto);
	}//insert

	@Override
	public boolean isValid(UsersDto dto) {
		String id = session.selectOne("users.isValid", dto);
		if(id==null) {
			return false;
		}else {
			return true;
		}
	}//isValid

	@Override
	public void update(UsersDto dto) {
		session.update("users.update", dto);
	}//update


	//인자로 전달되는 id에 해당되는 사용자 정보를 리턴하는 메소드
	@Override
	public UsersDto getData(String id) {
		UsersDto dto = session.selectOne("users.getData", id);
		return dto;
	}
	
	@Override
	public void delete(String id) {
		 session.delete("users.delete", id);
	}//delete

	@Override
	public boolean updatePwd(UsersDto dto) {
		//update문의 영향을 받은 row의 개수가 리턴된다.
		int result = session.update("users.updatepwd", dto);
		if(result>0) {
			return true;
		}else {
			return false;
		}
		
	}
	
}//UsersDao
