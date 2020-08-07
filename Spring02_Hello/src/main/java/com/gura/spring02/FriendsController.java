package com.gura.spring02;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FriendsController {

	@RequestMapping("/friends") //서버가 스타트 되는 시점에 스프링 프레임 워크가 바꿔서 사용한다.
	public String fortune(HttpServletRequest request) {
		
		//1 오늘의 운세를 얻어오는 비즈니스 로직을 처리한다.
		List<String> friends = new ArrayList<String>();
		friends.add("김구라");
		friends.add("해골");
		friends.add("원숭이");
		//2. 로직 처리결과 데이타ㅓ(model)를 request영역에 담는다.
		request.setAttribute("friends", friends); 
		//3. view 페이지(jsp)페이지로 forward 이동해서 응답한다.
		return "friends"; 
	}
}