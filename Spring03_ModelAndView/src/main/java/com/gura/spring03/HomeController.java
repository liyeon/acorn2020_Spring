package com.gura.spring03;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/*
 * Component scan을 했을 때 HomeController 객체가 생성되고 Spring이 관리한다.
 * Spring이 관리한다는 의미는 Spring bean 컨테이너에서 관리되는 객체가 된다는 의미이다.
 */
@Controller
public class HomeController {
	// "/home.do"요청이 왔을 때 이 메소드로 요청을 처리하게 된다.
	@RequestMapping("/home")
	public String home(HttpServletRequest request) {
		
		//공지사항 목록이라고 가정하자 //데이터를 모델(model)이라고함
		List<String> noticeList=new ArrayList<String>();
		noticeList.add("장마철이에요ㅕ!!!");
		noticeList.add("차가 너무 막혀요!!");
		noticeList.add("지하철에 사람 짱많아!!!짱싫음!!!");
		
		//view page에 전달할 데이터를 request 영역에 담는다.
		request.setAttribute("noticeList", noticeList);
		
		//view Page로 forward 이동해서 응답하기
		//redirect 이동하면 request 영역에 담은 내용이 삭제된다.
		//리턴하는 문자열은 view페이지의 위치를 알려주는 것이다.
		//"/Web-INF/views/" + "home" + ".jsp"
		return "home";
	}
	
}
