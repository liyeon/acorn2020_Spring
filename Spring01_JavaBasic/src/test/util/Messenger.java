package test.util;

import org.springframework.stereotype.Component;
//component스캔을 통해 bean이 된다. new Messenger() 객체의 참조값이 Spring Bean container 에 들어가서 스프링이 관리함
//관리 객체가 된다. 어떤 패키지에 component스캔을 할지는 xml문서에서 지정을 해준다.
//객체의 생성과 관리를 프레임워크가 직접 해준다. 이를 제어의 역전이라함
//Inversion of Control

//component sacn을 했을 때 bean이 되도록 어노테이션을 붙인다. //별 기능은 없지만 bean이 되라 기본 어노테이션
@Component
public class Messenger {
	
	public void sendGreeting(String msg) {
		System.out.println("전달된 오늘의 인사 : "+msg);
	}
	
	public String getMessage() {
		System.out.println("getMessage() 메소드가 수행됩니다.");
		return "공부하장";
	}
}