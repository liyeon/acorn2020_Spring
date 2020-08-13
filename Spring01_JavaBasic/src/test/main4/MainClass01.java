package test.main4;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class MainClass01 {
	public static void main(String[] args) {
		//비밀번호라고 가정
		String pwd = "abcd1234";
		//비밀번호 인코딩할 객체 생성
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder();
		
		for(int i = 0; i<10; i++) {
			//비밀번호를 암호화한 문자열 얻어내기
			String result = encoder.encode(pwd);
			//결과 출력해보기 - 수행 할 때마다 다른 결과가 나온다.
			//역으로는 알지 못하지만 어디에서 파생됐는지는 알아야한다.
			System.out.println(result);
		}
		

	}
}
