package com.gura.spring05.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

//얘도 bean이 됨 ControllerAdvice 때문에
//어디든 동작을 할 때 NotDeleteException 타입의 exception이 발생을 하면 실행순서가 여기로 온다.
@ControllerAdvice
public class ExceptionController {
	
	@ExceptionHandler(NotDeleteException.class)
	public ModelAndView notDelete(NotDeleteException nde) {//exception객체의 참조값이 여기로 들어옴
		ModelAndView mView = new ModelAndView();
		mView.addObject("exception", nde);//exception이라는 key값으로 exception의 객체를 넣어줌 
		
		mView.setViewName("error/info"); //views/error/info.jsp
		return mView;
	}
	
	@ExceptionHandler(NullPointerException.class)
	public ModelAndView nullPointer(NullPointerException npe) {//exception객체의 참조값이 여기로 들어옴
		ModelAndView mView = new ModelAndView();
		mView.addObject("exception", npe);//exception이라는 key값으로 exception의 객체를 넣어줌 
		
		mView.setViewName("error/info"); //views/error/info.jsp
		return mView;
	}
}
