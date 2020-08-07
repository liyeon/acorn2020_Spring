package com.gura.spring02;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

//컨트롤러를 만들 때 사용하는 어노테이션
@Controller
public class HomeController {
	
	//해당 메소드가 어떤 요청을 처리할지 결정하는 어노테이션
	@RequestMapping("/home.nhn") //.nhn은 생략 가능하다.
	public String home() {
		//forward 이동 될 페이지의 위치를 리턴해준다.
		//"/WEB-INF/views/" + <---"home"여기만 입력해주면됨---> + ".jsp"
		//자동으로 web-inf, .jsp가 붙는다. 
		//       prefix   suffix 포워드 이동 될 jsp위치를 가리킴
		return "home";
	}
	
}
