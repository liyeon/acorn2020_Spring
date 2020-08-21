package test.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class MessengerAspect {
	//return type은 void이고 send로 시작하는 모든 메소드가 point cut이다.
	@Around("execution(void send*(..))")
	public void checkGreeting(ProceedingJoinPoint joinPoint) throws Throwable{
		//aop가 적용된 메소드 수행하기 이전에 해야할 적업
		//around에 한해서 joinpoint를 전달 받을 수 있다.
		//proceed를 호출해야만 joinpoint를 사용 할 수 있다. 호출하지 않으면 메소드가 수행되지 않는거나 마찬가지다.
		joinPoint.proceed(); //aop가 적용된 메소드 수행하기
		
		//aop가 적용된 메소드 수행 된 이후에 해야 할 작업
	}
}