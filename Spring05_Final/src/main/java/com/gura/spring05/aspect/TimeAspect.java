package com.gura.spring05.aspect;


import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

@Aspect
@Component
public class TimeAspect {
	//모든 리턴값 모든클래스의 모든 메소드
	@Around("execution(* com.gura.spring05.file.controller.*.*(..))")
	public Object checkTime(ProceedingJoinPoint joinPoint) throws Throwable {
		//로그를 출력할 객체의 참조값얻어오기
		//joinPoint.getTarget().getClass() -> aop가 적용된 클래스의 type (controller) logger의 참조값을 얻어올때 클래스도 얻어오려고?
		Logger logger=
				LoggerFactory.getLogger(joinPoint.getTarget().getClass());//FileController.class
		logger.info("요청처리시작");
		//System.out.println("요청 처리 시작2!!!");
		//시작시간(ms)
		long startTime=System.currentTimeMillis();
		
		Object obj=joinPoint.proceed();//aop가 적용된 메소드 수행하기
		//끝시간(ms)
		long endTime=System.currentTimeMillis();
		//시작과 끝의 차이를 얻어낸다.
		long time=endTime-startTime;
		//System.out.println("요청 처리에 소요된 시간 :"+time);
		//System.out.println("요청처리 끝!!!");
		logger.info("time:"+time);
		logger.info("요청처리끝!");
		
//		ModelAndView mView=null;
//		if(obj instanceof ModelAndView) {
//			mView=(ModelAndView)obj;
//			mView.setViewName("redirect:/home.do");//controller가 리턴해주는 ModelAndView를 조작 할 수 있다.
//		}
//		
		return obj;//viewname을 조작한다음에 스프링이 조작한 걸 받는다.
	}
}//TimeAspect