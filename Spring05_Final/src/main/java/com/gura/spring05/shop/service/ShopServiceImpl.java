package com.gura.spring05.shop.service;

import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring05.exception.NoDeliveryException;
import com.gura.spring05.shop.dao.OrderDao;
import com.gura.spring05.shop.dao.ShopDao;
import com.gura.spring05.shop.dto.OrderDto;
import com.gura.spring05.shop.dto.ShopDto;

@Service
public class ShopServiceImpl implements ShopService{
	@Autowired
	private ShopDao shopDao;
	@Autowired
	private OrderDao orderDao;
	
	@Override
	public void getList(ModelAndView mView) {
		//상품 목록
		List<ShopDto> list=shopDao.getList();
		//ModelAndView 객체에 list라는 키값으로 담는다.
		mView.addObject("list",list);
	}
	/*
	 * - Spring 트렌젝션 설정 방법
	 * 1. pom.xml에 spring-tx dependency 추가
	 * 2. servlet-context.xml에 transaction설정추가
	 * 3. 트랜젝션을 관리할 서비스의 메소드에 @Transactional어노테이션 붙이기
	 * 
	 * - 프로그래머의 의도 하에서 트랜젝션에 영향을 주는 Exception을 발생시키는 방법
	 * DataAccessException 클래스를 상속받은 클래스를 정의하고
	 * 예) class MyException extends DataAccessException{}
	 *	   throw new MyException("예외 메세지")
	 * 예외를 발생 시킬 조건이라면 위와 같이 예외를 발생시켜서 트랜젝션이 관리되도록한다.
	 */
	
	/*
	 * 여러개의 동작을 한번에 처리 할 때 <-트랜젝션이라함
	 * 하나라도 오류가 난다면 모두 처리되면 안되기 때문에 @Transactional어노테이션을 붙이면
	 * 하나라도 오류가 나면 처리되지않는다 모두 무사히 처리 되면 지가 알아서 커밋해준다.
	 * 트랜젝션의 오류는 DataAccessException이다.
	 */
	@Transactional
	@Override
	public void buy(HttpServletRequest request, ModelAndView mView) {
		//구입자의 아이디
		String id=(String)request.getSession().getAttribute("id");
		//1. 파라미터로 전달되는 구입할 상품의 번호를 읽어온다.
		int num=Integer.parseInt(request.getParameter("num"));
		//2. 상품의 가격을 얻어온다.
		int price=shopDao.getPrice(num);
		//3. 상품의 가격만큼 계좌 잔액을 줄인다.
		ShopDto dto=new ShopDto();
		dto.setId(id);
		dto.setPrice(price);
		shopDao.minusMoney(dto);
		//4. 가격의 10%를 포인트로 적립한다.
		shopDao.plusPoint(dto);
		//5. 재고의 갯수를 1 줄인다.
		shopDao.minusCount(num);
		//6. 주문 테이블(배송) 에 정보를 추가한다.
		OrderDto dto2=new OrderDto();
		dto2.setId(id);//누가
		dto2.setCode(num);//어떤 상품을
		dto2.setAddr("강남구 삼원빌딩 5층");//어디로 배송할지
		
		//테스트로 예외를 발생시켜 보기
		Random ran=new Random();
		int ranNum=ran.nextInt(2);//0 or 1 or 2 랜덤한 정수 발생 시키기 //랜덤한 확률로 exception을 발생 시킬 수 있다.
		if(ranNum==0) {
			throw new NoDeliveryException("배송이 불가합니다.");
		}
		
		orderDao.addOrder(dto2);
	}//buy
}//service