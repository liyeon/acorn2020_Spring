package com.gura.spring05.exception;

import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

//얘도 bean이 됨 ControllerAdvice 때문에
//어디든 동작을 할 때 NotDeleteException 타입의 exception이 발생을 하면 실행순서가 여기로 온다.

//예외 컨트롤러를 bean으로 만들기 위한 어노테이션
@ControllerAdvice
public class ExceptionController {
	
	//Spring Framework가 동작하는 중에 NotDeleteException type의 예외가 발생하면 호출되는 메소드
	@ExceptionHandler(NotDeleteException.class)
	public ModelAndView notDelete(NotDeleteException nde) {//exception객체의 참조값이 여기로 들어옴
		//해당 오류가 발생 했을 때 원하는 작업을 한 후
		
		//view페이지로 forward이동해서 예외 정보를 응답한다.
		ModelAndView mView = new ModelAndView();
		
		//exception이라는 키값으로 예외 객체를 담고
		mView.addObject("exception", nde);//exception이라는 key값으로 exception의 객체를 넣어줌 
		// WEB-INF/view/error/info.jsp 페이지로 forward 이동
		mView.setViewName("error/info"); //views/error/info.jsp
		return mView;
	}
	/* @Repository 어노테이션이 붙은 
	 * dao에서 DB 관련 작업을 하다가 예외가 발생하면 실행 순서가 여기로 들어온다.
	 */
	@ExceptionHandler(NoDeliveryException.class)
	public ModelAndView noDelivery(NoDeliveryException nde) {
		ModelAndView mView=new ModelAndView();
		mView.addObject("exception", nde);
		mView.setViewName("error/no_delivery");
		return mView;
	}
	
	
	@ExceptionHandler(DataAccessException.class)
	public ModelAndView dataAccess(DataAccessException dae) {
		ModelAndView mView=new ModelAndView();
		mView.addObject("exception", dae);
		mView.setViewName("error/data_access");
		return mView;
	}
	//buy.do->
}
