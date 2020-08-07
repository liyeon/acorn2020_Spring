package test.auto;

public class Car{
	//필드
	private Engine engine;
	//생성자
	public Car(Engine engine) {
		this.engine=engine;
	}
	
	public void drive() {
		if(engine==null) {
			System.out.println("engine없음ㅡㅡ");
		}else {
			System.out.println("부릉부릉");
		}
	}

}
