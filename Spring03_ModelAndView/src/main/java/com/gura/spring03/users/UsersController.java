package com.gura.spring03.users;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UsersController {
	//회원 가입 폼 요청 처리
	@RequestMapping(value = "/users/signup_form") // /usres/signup_form.do  //여기는 슬러시 붙여야함
	public String singupForm() { 
		//수행할 비즈니스 로직은 현재 없다.
		
		//view페이지의 정보만 리턴해준다.
		return "users/signup_form"; // /Web-INF/views/users/signup_form.jsp 여기는 앞에 슬러시 붙이면 안됨
	}
	@RequestMapping("/users/signup")
	public String signup(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		System.out.println(id+"|"+pwd);
		return "users/signup";
	}
	
	@RequestMapping("/users/signup2")
	public String signup2(@RequestParam String id,@RequestParam String pwd) {
		/*
		 * @RequestParam 어노테이션과 함께 메소드의 인자를 선언하면
		 * 요청 파라미터가 자동 추출되서 전달된다.
		 * @RequestParam은 생략 가능하다.
		 * form 요소의 name 속성의 value와 지역 변수의 이름이 같아야한다.
		 * 
		 * name="id" : String id
		 * name="pwd" : String pwd
		 * 
		 * Get 방식 파라미터라면
		 * ?name=xxx : String name
		 * ?addr = xxx : String addr
		 * ?pageNum=xxx : String pageNum
		 * ?pageNum=xxx : int pageNum
		 * 
		 */
		System.out.println(id+"|"+pwd);
		return "users/signup";
	}
	
	@RequestMapping("/users/signup3")
	public String signup2(@ModelAttribute UsersDto dto) {
		/*
		 * @ModelAttribute 어노테이션과 함께 dto를 선언해 놓으면
		 * 전송되는 파라미터가 추출되고 dto에 담겨서 전달된다.
		 * @ModelAttribute 는 생략 가능하다.
		 * form 요소의 name 속성의 value와 Dto의 필드명이 같아야한다.
		 * GET방식 전송이라면 파라미터 명과 dto의 필드명이 같아야한다.
		 */
		System.out.println(dto.getId()+"|"+dto.getPwd());
		return "users/signup";
	}
}
