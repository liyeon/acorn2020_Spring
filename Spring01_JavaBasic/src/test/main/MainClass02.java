package test.main;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import test.mypac.Weapon;

public class MainClass02 {
	public static void main(String[] args) {
		//init.xml 문서를 로딩해서 Spring이 생성할 객체는 생성해서 관리하도록 한다.
		//context를 container라고 생각해도 된다.
		ApplicationContext context= new ClassPathXmlApplicationContext("test/main/init.xml");
		//관리하고 있는 객체 중에서 id가 myWeapon인 객체의 참조값을 얻어와서
		//인터페이스 type으로 casting 한다.
		Weapon w =(Weapon)context.getBean("myWeapon");
		//필요한 기능 사용ㅇ하기
		w.attack();
	}//main
}//MainClass