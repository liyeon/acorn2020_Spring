package test.main4;

import java.util.Scanner;

import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class MainClass02 {

	public static void main(String[] args) {
		//회원 가입 할 때 입력 했던 비밀번호라고 가정
		String pwd = "abcd1234";
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		//비밀번호 인코더를 통해서 인코딩 한 후에 DB에 저장된 비밀번호라고 가정
		String savedPwd = encoder.encode(pwd);
		
		System.out.println("비밀번호 입력 : ");
		//로그인 폼에 입력한 비밀번호라고 가정
		String inputPwd = new Scanner(System.in).nextLine();

		//DB에 저장된 비밀번호와 입력한 비밀번호가 일치하는지 여부
		//boolean isEqual = inputPwd.equals(savePwd); //불가능
		
		boolean isEqual = BCrypt.checkpw(inputPwd, savedPwd);
		if(isEqual) {
			System.out.println("비밀번호가 일치합니다.");
		}else {
			System.out.println("비밀번호가 일치하지 않습니다.");
		}
		
	}//
}//
