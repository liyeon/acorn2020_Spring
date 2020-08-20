package test.main5;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import test.util.WritingUtil;

public class MainClass01 {
	public static void main(String[] args) {
		//init.xml 문서를 로딩해서 bean으로 관리할 객체들을 관리한다.
		ApplicationContext context=
				new ClassPathXmlApplicationContext("test/main5/init.xml");
		/*
		 * DisptcherServlet이 servlet-context.xml에서 bean을 관리해준다면
		 * ApplicationContext는 잠깐동안에 bean으로 만들어서 관리해준다.
		 */
		//관리 되는 객체 중에서 WritingUtil type 객체의 참조값을 얻어온다.
		WritingUtil util=context.getBean(WritingUtil.class); //이거보다는 인터페이스로 의존해서 사용하는게 좋음ㅋ
		//메소드를 통해서 이런타입의 클래스를 주세용 하고 요청하면 호출된다.
		//객체의 메소드 호출하기
		util.write1();
		util.write2();
		util.write3();
	}//main
}//끝
