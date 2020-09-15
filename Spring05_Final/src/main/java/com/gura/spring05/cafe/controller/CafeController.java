package com.gura.spring05.cafe.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring05.cafe.dao.CafeDao;
import com.gura.spring05.cafe.dto.CafeCommentDto;
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
	
	//댓글 요청 처리
	@RequestMapping(value = "/cafe/private/comment_insert",
							method=RequestMethod.POST)
	public ModelAndView commentInsert(HttpServletRequest request, ModelAndView mView, @RequestParam int ref_group) {
		//새 댓글을 저장하고
		cafeService.saveCommnet(request);
		//보고 있던 글 자세히 보기로 다시 리다이렉트 이동 시킨다.
		mView.setViewName("redirect:/cafe/detail.do?num="+ref_group);
		return mView;
	}
	@RequestMapping(value = "/cafe/private/comment_delete")
	public ModelAndView commentDelete(HttpServletRequest request, ModelAndView mView, @RequestParam int ref_group) {
		cafeService.deleteComment(request);
		mView.setViewName("redirect:/cafe/detail.do?num="+ref_group);
		return mView;
	}
	
	//댓글 수정 ajax 요청에 대한 요청 처리;
	@RequestMapping(value = "/cafe/private/comment_update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> commentUpdate(CafeCommentDto dto){
		
		//댓글을 수정 반영하고
		cafeService.updateComment(dto);
		//Json문자열을 클라이언트에게 응답한다.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", dto.getNum());
		map.put("content", dto.getContent());
		return map;
		
	}
	
	//댓글 무한 스크롤 ajax요청 처리
	@RequestMapping("/cafe/ajax_comment_list")
	public ModelAndView ajaxCommentList(HttpServletRequest request,
			ModelAndView mView) {
		cafeService.moreCommentList(request);
		mView.setViewName("cafe/ajax_comment_list");
		return mView;
	}
	
	@RequestMapping("/cafe/ajax_list")
	@ResponseBody
	public Map<String, Object> ajaxList(HttpServletRequest request){
		return cafeService.getList2(request);
	}
	
	//angular js test용
	@Autowired
	private CafeDao cafeDao;
	
	//$http success 라는 곳에 json문자열이 object 형식으로  변환이 돼서 들어다.
	//param으로 번호를 읽어오고 responseBody 로 변환을 해서
	@RequestMapping("/cafe/ajax_detail")
	@ResponseBody
	public CafeDto ajaxDetail(@RequestParam int num){
		return cafeDao.getData(num);
	}

}//