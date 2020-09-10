package com.gura.spring05.users.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring05.users.dto.UsersDto;
import com.gura.spring05.users.service.UsersService;

@Controller
public class UsersController {
	@Autowired
	private UsersService service;
	
	//회원가입 폼 요청 처리
	@RequestMapping("/users/signup_form")
	public String signupForm() {
		// /WEB-INF/views/users/signup_form.jsp 페이지로 forward 이동해서 응답
		return "users/signup_form";//요청처리 경로와 같을 필요는 없다
	}//signupForm
	
	//아이디가 존재하는지 여부를 처리하느 요청처리
	@RequestMapping("/users/checkid")
	@ResponseBody
	public Map<String, Object> checkid(@RequestParam String inputId){
		//service가 리턴해주는 Map객체를 리턴한다.
		return service.isExistId(inputId);
	}//checkid
	
	//회원가입 요청 처리
	@RequestMapping("/users/signup")
	public ModelAndView signup(UsersDto dto, ModelAndView mView) {
		//service객체를 이용해서 사용자 정보를 추가한다.
		service.addUser(dto);
		//view 페이지로 forward 이동해서 응답하기
		mView.setViewName("users/signup");
		return mView;
	}//signup
	
	@RequestMapping("/users/loginform")
	public String loginform(HttpServletRequest request) {
		//url파라미터가 넘어오는지 읽어와보기
    	String url = request.getParameter("url");
    	if(url==null){//목적지 정보가 없다면
    		String cPath=request.getContextPath();
    		url = cPath+"/home.do"; //로그인 후 인덱스 페이지로 가도록하기 위해서
    	}
    	//request에 담는다.
    	request.setAttribute("url", url);
		return "users/loginform";
	}//loginform
	
	@RequestMapping("/users/login")
	public ModelAndView login(UsersDto dto, ModelAndView mView,
			HttpSession session, HttpServletRequest request) {
		//로그인 후 가야하는 목적지 정보
    	String url = request.getParameter("url");
    	//목적지 정보도 미리 인코딩 해 놓는다.
    	String encodedUrl=URLEncoder.encode(url);
    	//view 페이지에 전달하기 위해 ModelAndView 객체에 담아준다.
    	mView.addObject("url", url);
		mView.addObject("encodedUrl", encodedUrl);
		
		//service 객체를 이용해서 로그인 관련 처리를 한다.
		service.loginProcess(dto, mView, session);;
		mView.setViewName("users/login");
		return mView;
	}//login
	
	@RequestMapping("/users/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.do";
		//return "users/logout";
	}//logout
	
	//개인정보보기 요청 처리
	@RequestMapping("/users/private/info")
	public ModelAndView info(HttpServletRequest request, ModelAndView mView) {
		service.getInfo(request.getSession(), mView);
		mView.setViewName("users/private/info");
		//web-inf/views/users/private/info.jsp
		return mView;
	}//getData
	
	//회원정보 삭제
	@RequestMapping("/users/private/delete")
	public ModelAndView delete(HttpServletRequest request, ModelAndView mView) {
		//서비스를 이용해서 사용자 정보를 삭제하고
		service.deleteUser(request.getSession());
		//view페이지로 froward 이동해서 응답
		mView.setViewName("users/private/delete");
		//인덱스 페이지로 리다이렉트 이동
		//mView.setViewName("redirect:/home.do");
		return mView;
	}//delete
	
	//회원정보 수정 폼 요청처리
	@RequestMapping("/users/private/updateform")
	public ModelAndView updateForm(HttpServletRequest request, ModelAndView mView) {
		service.getInfo(request.getSession(), mView);
		mView.setViewName("users/private/updateform");
		return mView;
	}
	
	//ajax 프로필 사진 업로드 요청 처리
	@RequestMapping("/users/private/profile_upload")
	@ResponseBody
	public Map<String, Object> profile_upload(HttpServletRequest request,
			@RequestParam MultipartFile image){
		//service 객체를 이용해서 이미지를 upload 폴더에 저장하고 Map을 리턴받는다.
		Map<String, Object> map = service.saveProfileImage(request, image);
		//{"imageSrc", "/upload/xxx.jpg"} 형식의 JSON 문자열을 출력하기 위해
		//Map을 @ResponseBody로 리턴해준다.
		return map;
	}//
	
	//개인 정보 수정 반영 요청 처리
	@RequestMapping("/users/private/update")
	public ModelAndView update(HttpServletRequest request, UsersDto dto, ModelAndView mView) {
		System.out.println("profile:"+dto.getProfile());
		//service 객체를 이용해서 개인 정보를 수정한다.
		service.updateUser(request.getSession(), dto);
		mView.setViewName("redirect:/users/private/info.do");
		return mView;
	}
	
	//비밀번호 수정 폼
	@RequestMapping("/users/private/pwd_updateform")
	public ModelAndView pwdUpdateform(ModelAndView mView) {
		mView.setViewName("users/private/pwd_updateform");
		return mView;
	}
	
	//비밀번호 수정 반영 요청 처리
	@RequestMapping("/users/private/pwd_update")
	public ModelAndView pwdUpdate(ModelAndView mView, UsersDto dto, HttpServletRequest request) {
		//service객체를 이용해서 새로운 비밀번호로 수정한다.
		service.updateUserPwd(request.getSession(), dto, mView);
		//view페이지로 forward 이동해서 응답한다. 
		mView.setViewName("users/private/pwd_update");
		return mView;
	}

	//html 페이지에서 로그인 여부를 확인하기 위한 ajax 요청 처리
	@RequestMapping("/users/ajax_login_check")
	@ResponseBody
	public Map<String, Object> ajaxLoginCheck(HttpSession session){
		//세션에서 id라는 키값으로 저장된 문자열을 읽어온다. 없으면null
		String id=(String) session.getAttribute("id");
		//결과를 Map에 담고
		Map<String, Object> map=new HashMap<>();
		map.put("id", id);
		return map;
	}
	
	//무조건 html을 템플렛으로 가진다. 
	//ajax요청으로 로그인폼 요청처리
	@RequestMapping(value="/users/ajax_login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object>  ajaxLogin(UsersDto dto, HttpSession session){
		//service가 리턴해주는 Map 객체를 리턴하면 json문자열이 응답된다.
		//로그인 성공인 경우 {"isSuccess":true, "id":"gura1"}
		//로그인 실패인 경우 {"isSuccess":false}
		return service.ajaxLoginProcess(dto, session);
	}
	
	//ajax로 로그아웃처리
	@RequestMapping("/users/ajax_logout")
	@ResponseBody
	public Map<String, Object> logoutAjax(HttpSession session) {
		session.invalidate();
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("isSuccess", true);
		return map;
	}//logout
}//UsersController