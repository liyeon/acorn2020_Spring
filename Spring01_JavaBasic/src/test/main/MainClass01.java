package test.main;

import test.mypac.Weapon;
import test.mypac.WeaponImpl;

public class MainClass01 {
	public static void main(String[] args) {
		//Application의 목적이 무언가를 공격하는게 목적이라면
		
		//1. 목적을 달성하기 위해 필요한 핵심의존 객체를 직접 생성해서
		Weapon w = new WeaponImpl();//<-핵심의존객체
		//2. 메소드를 호출해서 목적을 달성한다.
		w.attack();

		//MainClass01은 WeaponImpl를 의존한다.
		//의존관계를 느슨하게 한다. 1.인터페이스 타입을 적극 활용한다.
		//2. 필요한 핵심 의존 객체를 직접 NEW하지 않는다.
		
		
		
		
		
		
	}//main
}//MainClass