package com.gura.spring03;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FriendsController {
	@RequestMapping
	public String friends(HttpServletRequest request) {
		//비즈니스 로직 수행 결과 모델
		List<String> list = new ArrayList<String>();
		list.add("구라야..");
		list.add("해골골");
		list.add("원숭이");
		//view 페이지에 전달할 모델을 request영역에 담고
		request.setAttribute("list", list);
		//view 페이지로 forward 이동해서 응답한다.
		return "friends";
	}
	
	@RequestMapping("/friends2")
	public ModelAndView friends2() {
		//비즈니스 로직 수행 결과 모델
		List<String> list = new ArrayList<String>();
		list.add("구라야..2");
		list.add("해골골2");
		list.add("원숭이2");
		//Model과 View페이지 정보를 함께 담을 수 있는 ModelAndView 객체 생성
		ModelAndView mView = new ModelAndView();
		//request 영역에 담을 내용을 .addObject()메소드를 이용해서 담는다.
		mView.addObject("list", list);
		//view페이지 정보
		mView.setViewName("friends");
		//Model과 view 페이지 정보를 모두 가지고 있는 ModelAndView 객체를 리턴한다.
		//두개의 정보를 같이 담을 수 있다고 해서 modelAndView addObject는 여러개 담을 수 있다.
		return mView;
	}
	//ModelAndView 객체가 필요하면 메소드의 인자로 선언하면 객체의 참조값이 전달된다.
	@RequestMapping("/friends3")
	public ModelAndView friends3(ModelAndView mView) {//Model과 View페이지 정보를 함께 담을 수 있는 ModelAndView 객체는 직접 생성하지 않고 
		//비즈니스 로직 수행 결과 모델
		List<String> list = new ArrayList<String>();
		list.add("구라야..3");
		list.add("해골골3");
		list.add("원숭이3");
		//request 영역에 담을 내용을 .addObject()메소드를 이용해서 담는다.
		mView.addObject("list", list);
		//view페이지 정보
		mView.setViewName("friends");
		//두개의 정보를 같이 담을 수 있다고 해서 modelAndView addObject는 여러개 담을 수 있다.
		//Model과 view 페이지 정보를 모두 가지고 있는 ModelAndView 객체를 리턴한다.
		return mView;
	}
	
	@RequestMapping("/delete")
	public String delete() {
		//가상의 비즈니스 로직 수행
		System.out.println("친구 정보를 삭제합니다.");
		
		//삭제 후 친구 목록 보기로 리다이렉트 이동 context 경로 입력할 필요없음 "redirect:을 붙이지 않으면 forward 이동이다.
		return "redirect:/friends.do";
	}
	
	@RequestMapping("/delete2")
	public ModelAndView delete2(ModelAndView mView) {
		//가상의 비즈니스 로직 수행
		System.out.println("친구 정보를 삭제합니다.2");
		
		//ModelAndView 객체에 리다이렉트 이동 정보를 담아서
		mView.setViewName("redirect:/friends.do");
		//리턴해준다.
		return mView;
	}
	
}
