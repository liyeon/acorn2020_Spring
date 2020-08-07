package test.mypac;
/*
 * Weapon 인터페이스를 구현하한 클래스
 */
public class WeaponImpl implements Weapon{

	@Override
	public void attack() {
		System.out.println("무언가를 공격해요!");
	}//attack
}//WeaponImpl
