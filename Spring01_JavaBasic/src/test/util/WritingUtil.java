package test.util;

import org.springframework.stereotype.Component;

//Component scan을 했을 때 bean이 될 수 있도록
@Component
public class WritingUtil {//이 메소드가 호출되기 바로 직전
	//메소드를 횡단하면서 관심사가 있는것 <- 횡단 관심사(crosscutting concerns) init.xml에 무언가 설정만으로 작업을 할 수 있다. 
	//횡단관심사를 따로 클래스를 만들어두고 적용 시킬 수 있다.
	public void write1() {
		System.out.println("편지를 씁니다.");
	}//메소드가 리턴된 바로 직후에 무언갈 하고 싶다?
	
	public void write2() {
		System.out.println("보고서를 씁니다.");
	}

	public void write3() {
		System.out.println("일기를 씁니다.");
	}
}