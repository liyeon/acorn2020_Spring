package test.aspect;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

/*
 * Aspect : 공통관심사(황단관심사)
 * 	메소드를 횡단하는 관심사
 * - 핵심 비즈니스 로직과는 상관 없는 공통 관심사를 따로 작성한다.
 * 
 */
@Aspect //aspect 역할을 할 수 있도록 필요한 어노테이션
@Component //component scan을 통해서 bean이 되기 위한 어노테이션
public class WritingAspect {
	//바로 직전에 수행되게 하고 싶으면
	//메소드가 수행되기 바로 이전에 적용 될 수 있도록 설정하는 어노테이션
	//스프링이 관리하는 횡단관심사가 어떤 메소드에 적용 할 지
	//write로 시작하는 모든 메소드 인자도 지정할수있다.
	@Before("execution(void write*())") //""안에 작성하는 문법 (aspectJ expression)
	public void prepare() {
		System.out.println("pen을 준비해요");
	}
	
	//메소드가 수행 한 바로 직후에 수행ㄷ
	@After("execution(void write*())")
	public void end() {
		System.out.println("다 사용한 pen를 마무리 해요");
	}
}
/*
 * 	-Aspectj Expression
 * 
 * 	1. execution(* *(..)) => 접근 가능한 모든 메소드가  //..은 인자가 있어도되고 없어도 되고 
 * (*)는 인자가 반드시 하나여만 하고
 * (*,*)인자가 두개여야만 하고
 * (*,*,*)인자가 세개여야만
 * (java.lang.String) 인자의 데이터 타입이 반드시 스트링이어야함
 * (java.lang.String, *)첫번째 인자는 스트링 두번째 인자는 뭐든 상관없음
 * (리턴타입 *(..))
 * (* *(..)) - 관여치않겠다
 * (* test.service.*.*(..)) 서비스 패키지의 모든 클래스(객체).모든 메소드
 * 	   point cut -- aop가 적용되는 바로 그 지점
 * 
 * 	2. execution(* test.service.*.*(..)) 
 * 		=> test.service 패키지의 모든 메소드 point cut
 *
 * 	3. execution(void insert*(..))
 * 		=>리턴 type 은 void 이고 메소드명이 
 * 		insert 로 시작하는 모든 메소드가 point cut
 * 
 * 	4. execution(* delete*(*))
 * 		=> 메소드 명이 delete 로 시작하고 인자로 1개 전달받는 
 *      메소드가 point cut (aop 가 적용되는 위치)
 *          
 * 	5. execution(* delete*(*,*))
 * 		=> 메소드 명이 delete 로 시작하고 인자로 2개 전달받는 
 *      메소드가 point cut (aop 가 적용되는 위치)
 *      
 *  6. execution(String update*(Integer,*))
 *     => 메소드 명이 update로 시작하고 리턴 type은 String
 *     메소드의 첫번째 인자는 Integer type, 두번째 인자는 아무 type 다 되는
 *     메소드가 point cut(aop가 적용 되는 위치)
 */