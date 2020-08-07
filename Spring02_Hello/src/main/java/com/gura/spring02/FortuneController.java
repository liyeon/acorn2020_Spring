package com.gura.spring02;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller //컨트롤러 파일을 만들 때 있어야함 //서버가 스타트 되는 시점에 스프링 프레임워크가 바꿔서 사용한다.
public class FortuneController {
	
	/*
	 * HttpServletRequest or HttpServletResponse or HttpSession
	 * 객체가 필요하면 메소드의 인자에 선언해 놓으면 자동으로 실행 시점에 참조값이 전달된다.
	 */
	@RequestMapping("/fortune") //서버가 스타트 되는 시점에 스프링 프레임 워크가 바꿔서 사용한다.
	public String fortune(HttpServletRequest request) {
		//1 오늘의 운세를 얻어오는 비즈니스 로직을 처리한다.
		String fortuneToday = "동쪽으로 가면 귀인을 만나요";
		//2. 로직 처리결과 데이타ㅓ(model)를 request영역에 담는다.
		request.setAttribute("fortuneToday", fortuneToday); 
		//3. view 페이지(jsp)페이지로 forward 이동해서 응답한다.
		return "fortune"; //"/Web-INF/views/fortune.jsp"
	}
}