package com.gura.spring04.member.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring04.member.dao.MemberDao;
import com.gura.spring04.member.dto.MemberDto;


@Controller
public class MemberController {
	 @Autowired
	 private MemberDao dao;
	@RequestMapping("/member/list")
	public ModelAndView list(ModelAndView mView){
		//회원 목록을 얻어온다.
		List<MemberDto> list = dao.getList();
		//model을 담는다.
		mView.addObject("list", list);
		//view 페이지 정보를 담고
		mView.setViewName("member/list");
		//ModelAndView 객체를 리턴해준다.
		return mView;
	}
}





