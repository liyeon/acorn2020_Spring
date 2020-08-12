package com.gura.spring05.users.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring05.users.dao.UsersDao;
import com.gura.spring05.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService{
	@Autowired
	private UsersDao dao;

	@Override
	public Map<String, Object> isExistId(String inputId) {
		//dao를 이용해서 아이디 존재 여부를 알아내서
		boolean isExist = dao.isExist(inputId);
		//아이디가 존재하는지 여부를 Map에 담아서 리턴해준다.
		Map<String, Object> map = new HashMap<>();
		map.put("isExist", isExist);
		return map;
	}//isExistId

	@Override
	public void addUser(UsersDto dto) {
		//dao객체를 이용해서 새로운 사용자 정보를 Db에 저장하기
		dao.insert(dto);
	}//addUser
	
	@Override
	public void loginProcess(UsersDto dto, ModelAndView mView, HttpSession session) {
		//dao객체를 이용해서 id, pwd가 유효한 정보인지 여부를 얻어낸다.
		boolean isValid = dao.isValid(dto);
		
		if(isValid) {//만일 유효한 정보면
			//로그인 처리를 한다.
			session.setAttribute("id", dto.getId());
			//view페이지에서 사용할 정보
			mView.addObject("isSuccess", true);
		}else {//아니면
			mView.addObject("isSuccess", false);
		}
		
	}//loginProcess

	@Override
	public void updateUser(UsersDto dto) {
		
	}//updateUser

	@Override
	public void updatePwdUser(UsersDto dto) {
		
		
	}//updatePwdUser

	@Override
	public void getInfo(HttpSession session, ModelAndView mView) {
		//로그인 된 아이디를 session 객체를 이용해서 얻어온다.
		String id = (String)session.getAttribute("id");
		//dao를 이용해서 사용자 정보를 얻어와서
		UsersDto dto = dao.getData(id);
		//mView 객체에 담아준다.
		mView.addObject("dto", dto);
	}//getInfo

	@Override
	public void deleteUser(HttpSession session) {
		//세션에 저장된 아이디를 읽어와서
		String id = (String)session.getAttribute("id");
		//삭제
		dao.delete(id);
		//로그아웃 처리
		session.invalidate();
	}//deleteUser
	
}//UsersService