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
		//aop가 적용된 메소드 수행하기 이전에 해야할 작업
		//around에 한해서 joinpoint를 전달 받을 수 있다.
		//proceed를 호출해야만 joinpoint를 사용 할 수 있다. 호출하지 않으면 메소드가 수행되지 않는거나 마찬가지다.
		
		
		//메소드에 전달된 인자들 목록 얻어내기
		Object[] args=joinPoint.getArgs();
		for(Object tmp:args) {
			//타읍을 확인해서 반복문을 돌면서 원하는 타입을 찾아야 한다.
			//타입을 확인하는 방법은 instanceof라는 메소드를 이용한다. 어떤 타입인지 판정을 해줌
				//만일 인자가 String type이면
			if(tmp instanceof String) {
				//원래 type으로 Casting
				String msg=(String)tmp;
				System.out.println("aspect에서 읽어낸 내용:"+msg);
				if(msg.contains("바보")) {
					System.out.println("바보는 금지된 단어입니다.");
					return;//메소드를 여기서 끝내기(proceed()가 호출이 안된다)//메소드가 수행 할지 말지를 결정할수있다.
				}
			}
		}
		
		joinPoint.proceed(); //aop가 적용된 메소드 수행하기 정상수행 할지말지 결정
		
		//aop가 적용된 메소드 수행 된 이후에 해야 할 작업
	}
	//리턴타입 String get으로 시작하는 메소드, 인자는 없음
	@Around("execution(String get*())")
	public Object checkReturn(ProceedingJoinPoint joinPoint) throws Throwable {
		//aop가 적용된 메소드가 리턴하는 데이터 얻어내기
		Object obj=joinPoint.proceed();
		//aop가 적용된 메소드가 리턴하는 데이터
		return "놀자놀자 놀꺼야"; //조사를 해보고 다른걸 리턴해줄수도있다.//리턴값도 조작 가능함.
		//메소드가 리턴한걸 리턴하지 않고 직접 글을 입력하여 리턴값을 바꿀 수 있다.ㄷ
		
	}
}