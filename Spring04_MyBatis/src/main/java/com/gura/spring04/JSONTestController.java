package com.gura.spring04;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gura.spring04.member.dto.MemberDto;

@Controller
public class JSONTestController {
/*
 * 스프링에서 json 사용하기
 */
	@RequestMapping("/json01")
	public String json01() {
		return "json01";
	}
	
	@RequestMapping(value = "/json02", method = RequestMethod.GET,
			produces = "application/json;charset=utf-8")
	@ResponseBody //리턴하는 문자열을 클라이언트에게 출력하겠다는 의미
	public String json02() {
		return "{\"num\":2, \"name\":\"kimgura2\"}";
	}
	
	/*
	 * 1. jackson-databind 라이브러리가 dependency에 명시가 되어 있고
	 * 2. Servlet-context.xml에 <mvc:annotation-driven /> 에 명시되어있고
	 * 3. 컨트롤러의 메소드에 @ResponseBody 어노테이션이 붙어있으면
	 * Map 객체에 담긴 내용이 Json 문자열로 변환되어 응답된다.
	 */
	@RequestMapping("/json03")
	@ResponseBody
	public Map<String, Object> json03(){
		Map<String, Object> map = new HashMap<>();
		map.put("num", 1);
		map.put("name", "구라구라3");
		map.put("isMan", true);
		return map;
		//맵에 저장된 형식이 json형식으로 자동 변환이 돼서 출력이 된다.
		//맵 혹은 list를 리턴하게 되면 json 문자열로 변환되어 출력된다.
		//MAP-> {}, List-> []
	}
	
	@RequestMapping("/json04")
	@ResponseBody
	public List<String> json04(){
		List<String> list = new ArrayList<String>();
		list.add("구라구라4");
		list.add("해골해골");
		list.add("원숭원숭");
		return list;
	}
	
	@RequestMapping("/json05")
	@ResponseBody
	public Map<String, Object> json05(){
		Map<String, Object> map = new HashMap<>();
		map.put("email", "aaa@kakao.com");
		
		List<String> hobby = new ArrayList<String>();
		hobby.add("java");
		hobby.add("jsp");
		hobby.add("Spring");
		
		map.put("hobby", hobby);
		return map;
	}
	
	@RequestMapping("/json06")
	@ResponseBody
	public List<Map<String, Object>> json06(){
		Map<String, Object> map1 = new HashMap<>();
		map1.put("num", 1);
		map1.put("name", "김구라");
		
		Map<String, Object> map2 = new HashMap<>();
		map2.put("num", 2);
		map2.put("name", "해골쓰");
		
		List<Map<String, Object>> list = new ArrayList<>();
	
		list.add(map1);
		list.add(map2);
		
		return list;
	}
	
	@RequestMapping("/json07")
	@ResponseBody
	public MemberDto json07() {
		MemberDto dto = new MemberDto(1, "구라구라07", "량진량진");
		
		return dto;
	}
	
	@RequestMapping("/json08")
	@ResponseBody
	public List<MemberDto> json08() {
		List<MemberDto> list = new ArrayList<MemberDto>();
		list.add(new MemberDto(1, "김구라", "노량진"));
		list.add(new MemberDto(2, "해골", "행신동"));
		return list;
	}
	
}//JSONTestController
