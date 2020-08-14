package com.gura.spring05.cafe.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring05.cafe.dto.CafeDto;
import com.gura.spring05.cafe.service.CafeService;

@Controller
public class CafeController {
	@Autowired
	private CafeService cafeService;
	
	//카페 글 목록 보기 요청 처리
	@RequestMapping("/cafe/list")
	public ModelAndView getList(HttpServletRequest request, ModelAndView mView) {
		cafeService.getList(request);
		mView.setViewName("cafe/list");
		return mView;
	}
	
	
	@RequestMapping("/cafe/detail")
	public ModelAndView detail(HttpServletRequest request, ModelAndView mView) {
		cafeService.getDetail(request);
		mView.setViewName("cafe/detail");
		return mView;
	}
	
	@RequestMapping("/cafe/private/insertform")
	public ModelAndView insertform(ModelAndView mView) {
		mView.setViewName("cafe/insertform");
		return mView;
	}
	
	@RequestMapping(value = "/cafe/private/insert", method=RequestMethod.POST)
	public ModelAndView insert(CafeDto dto, ModelAndView mView, HttpSession session) {
		//dto에 글 작성자 담기
		String id = (String)session.getAttribute("id");
		dto.setWriter(id);
		cafeService.saveContent(dto);
		mView.setViewName("cafe/insert");
		return mView;
	}
	
	@RequestMapping("/cafe/private/updateform")
	public ModelAndView updateform(HttpServletRequest request, ModelAndView mView) {
		cafeService.getDetail(request);
		mView.setViewName("cafe/updateform");
		return mView;
	}
	
	@RequestMapping(value = "/cafe/private/update", method=RequestMethod.POST)
	public ModelAndView update(CafeDto dto, ModelAndView mView) {
		cafeService.updateContent(dto);
		mView.setViewName("cafe/update");
		return mView;
	}

	
	//파일 삭제 요청 처리
	@RequestMapping("/cafe/private/delete")
	public ModelAndView delete(@RequestParam int num, HttpServletRequest request, ModelAndView mView) {
		cafeService.deleteContent(num, request);
		mView.setViewName("redirect:/cafe/list.do");
		return mView;
	}
	
}//