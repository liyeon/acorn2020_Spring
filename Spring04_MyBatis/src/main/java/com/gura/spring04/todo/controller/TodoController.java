package com.gura.spring04.todo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring04.todo.dto.TodoDto;
import com.gura.spring04.todo.service.TodoService;

@Controller
public class TodoController {
	@Autowired
	private TodoService service;
	
	//회원 삭제 요청 처리
	@RequestMapping("/todo/delete")
	public String delete(@RequestParam int num) {
		service.deleteTodo(num);
		return "redirect:/todo/list.do";
	}
	
	//수정 요청 처리
	@RequestMapping(value = "todo/update", method = RequestMethod.POST)
	public String update(@ModelAttribute TodoDto dto) {
		service.updateTodo(dto);
		return "todo/update";
	}
	
	//수정 폼 요청 처리
	@RequestMapping(value = "/todo/updateform", method = RequestMethod.GET)
	public ModelAndView updateform(@RequestParam int num, ModelAndView mView) {
		service.getTodo(num, mView);
		mView.setViewName("todo/updateform");
		return mView;
	}
	
	//추가 요청 처리
	@RequestMapping("/todo/insert")
	public String insert(@ModelAttribute TodoDto dto) {
		service.addTodo(dto);
		return "todo/insert";
	}
	
	//추가 폼 요청 처리
	@RequestMapping("/todo/insertform")
	public String insertform() {
		return "todo/insertform";
	}
	
	@RequestMapping("/todo/list")
	public ModelAndView list(ModelAndView mView) {
		service.getTodoList(mView);
		mView.setViewName("todo/list");
		return mView;
	}
	
	
}//