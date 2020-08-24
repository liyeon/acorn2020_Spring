package com.gura.spring05.aspect;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gura.spring05.cafe.dao.CafeCommentDao;
import com.gura.spring05.cafe.dao.CafeDao;
import com.gura.spring05.cafe.dto.CafeCommentDto;
import com.gura.spring05.cafe.dto.CafeDto;
import com.gura.spring05.exception.NotDeleteException;
import com.gura.spring05.file.dao.FileDao;
import com.gura.spring05.file.dto.FileDto;

@Aspect
@Component
public class DeleteAspect {
	
	@Autowired
	private FileDao fileDao;
	@Autowired
	private CafeDao cafeDao;
	@Autowired
	private CafeCommentDao cafeCommentDao;
	
	@Around("execution(void com.gura.spring05.cafe.service.*.deleteCommentContent(..))")
	public void checkCafeCommentDelete(ProceedingJoinPoint joinPoint) throws Throwable {
		joinPoint.proceed();
	}
	
	@Around("execution(void com.gura.spring05.cafe.service.*.deleteContent(..))")
	public void checkCafeDelete(ProceedingJoinPoint joinPoint) throws Throwable{
		//메소드에 전달된 인자값을 저장할 지역변수
		int num=0;
		HttpServletRequest request=null;
		
		Object[] args=joinPoint.getArgs();
		for(Object tmp:args) {
			if(tmp instanceof Integer) {
				num=(int)tmp;
			}
			if(tmp instanceof HttpServletRequest) {
				request=(HttpServletRequest)tmp;
			}
		}
		//삭제할 글 정보를 얻어온다.
		CafeDto cafeDto=cafeDao.getData(num);
		//세션에 저장된 아이디를 읽어온다.(로그인된아이디
		String id=(String)request.getSession().getAttribute("id");;
		if(!id.equals(cafeDto.getWriter())) {
			throw new NotDeleteException("남의 게시글 지우지 마세요!!!!!!!!!!");
		}
		//메소드 정상 수행하기
		joinPoint.proceed();
	}//checkCafeDelete
	
	
	
	//리턴 타입 void 저 패키지의 모든 클래스, delete로 시작하는 메소드 인자는 있어도 되고 없어도 되고 여러개써도 되고
	@Around("execution(void com.gura.spring05.file.service.*.delete*(..))")
	public void checkFileDelete(ProceedingJoinPoint joinPoint) throws Throwable {
		//메소드에 전달된 인자값을 저장할 지역변수
		int num=0;
		HttpServletRequest request=null;
		Object[] args=joinPoint.getArgs();
		for (Object tmp:args) {
			if(tmp instanceof Integer) {//전달된 인자중에서 정수(int)찾기
				num=(int)tmp;//원한는 타입을 받아서 캐스팅해준다.
			}
			if (tmp instanceof HttpServletRequest) {//HttpServletRequest 찾기
				request=(HttpServletRequest)tmp;
			}
		}
		//삭제할 파일의 정보를 얻어온다.
		FileDto fileDto=fileDao.getData(num);
		//세션에 저장된 아이디를 읽어온다.(로그인된아이디)
		String id=(String)request.getSession().getAttribute("id");
		if(!id.equals(fileDto.getWriter())) {
			throw new NotDeleteException("남의 파일 지우지 마세요!!!!!!!!!!");//실행순서가 NotDeleteException으로 뜀
		}
		//메소드 정상 수행하기
		joinPoint.proceed();//실행순서가 다른 곳으로 뛰게 되면 실행되지 않음
	}//checkFileDelete
}//DeleteAspect