package test.main5;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import test.util.Messenger;

public class MainClass02 {
	public static void main(String[] args) {
		//run 했을 때 순간적으로 Spring bean context 의 개념이 생긴다.
		ApplicationContext context=
						new ClassPathXmlApplicationContext("test/main5/init.xml");
		
		//Spring bean 컨테이너로 부터 Messenger type의 참조값얻어오기
		Messenger m=context.getBean(Messenger.class);
		m.sendGreeting("good afternoon!");
		String msg=m.getMessage();
		//bean이 리턴한데이터확인해보기
		System.out.println("Messenger 객체가 리턴한 msg : "+msg);
	}
}