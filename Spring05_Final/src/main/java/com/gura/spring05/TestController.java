package com.gura.spring05;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.util.JSONPObject;

@Controller
public class TestController {
	// /api/get_info.do
	@RequestMapping("/api/get_info")
	@ResponseBody
	//혹시 안 넘어오면 defaultValue로 기본 값을 지정해준다. 
	//값이 넘어오지 않으면 callback이라는 함수를 호출해준다.
	// jsonp
	//callback은 안바꾸는게 좋다 묵시적인 약속이기 때문에
	public JSONPObject jsonp(@RequestParam(defaultValue="callback") String callback) {
		//클라이언트에게 응답할 데이터를 Map 에 담는다. 
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("num", 1);
		map.put("name", "김구라");
		//JSONObject 객체를 생성해서 콜백 함수명과 응답할 데이터를 담고
		JSONPObject jp=new JSONPObject(callback, map); //콜백함수명과 응답할 데이터를 전달을 하면
		//콜백 함수명대로 함수가 만들어지고 map에 담긴 내용이 json문자열, object 로 출력이 된다. 
		//JSONObject 를 리턴해준다.
		return jp;
		//jsonp를 api라고도 한다..?
		///spring05/api/get_info.do?callback=gura
		//jsonpobject객체가 html 에서 뷰 페이지로 이동해서 스크립트를 작성하는 것을 대신 해 줄 수 있다
	}
}