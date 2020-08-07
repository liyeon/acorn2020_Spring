package test.mypac;

public class RemoconImpl implements Remocon{

	@Override
	public void up() {
		System.out.println("볼륨올라간당");
		
	}

	@Override
	public void down() {
		
		System.out.println("볼륨내려간당");	
	}

}
