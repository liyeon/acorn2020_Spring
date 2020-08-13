package com.gura.spring05.users.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gura.spring05.users.dao.UsersDao;
import com.gura.spring05.users.dto.UsersDto;

@Service
public class UsersServiceImpl implements UsersService{
	@Autowired
	private UsersDao dao;

	@Override
	public Map<String, Object> isExistId(String inputId) {
		//dao를 이용해서 아이디 존재 여부를 알아내서
		boolean isExist = dao.isExist(inputId);
		//아이디가 존재하는지 여부를 Map에 담아서 리턴해준다.
		Map<String, Object> map = new HashMap<>();
		map.put("isExist", isExist);
		return map;
	}//isExistId

	@Override
	public void addUser(UsersDto dto) {
		//dto 객체에 비밀번호를 암호화 해서 넣어준다.
		String inputPwd = dto.getPwd();
		BCryptPasswordEncoder encoder=new BCryptPasswordEncoder(); //회원가입 form에 입력한 비밀번호
		String encodedPwd = encoder.encode(inputPwd);//암호화된 비밀번호
		//암호화된 비밀번호를 dto객체에 다시 넣어준다.
		dto.setPwd(encodedPwd);
		
		//dao객체를 이용해서 새로운 사용자 정보를 Db에 저장하기
		dao.insert(dto);
	}//addUser
	
	@Override
	public void loginProcess(UsersDto dto, ModelAndView mView, HttpSession session) {
		//dao객체를 이용해서 id, pwd가 유효한 정보인지 여부를 얻어낸다.
		//입력한 정보가 유효한 정보인지 여부를 저장할 지역변수
		boolean isValid = false; //초기값 false
		
		//로그인 폼에 입력한 아이디를 이용해서 DB에서 select 해본다.
		//존재하지 않는 아이디면 null이 리턴된다.
		UsersDto resultDto = dao.getData(dto.getId());
		 //아이디 값으로 가져온 데이터의 null 가능성
		if(resultDto != null) {//아이디가 존재하는 경우(아이디 일치)
			//DB에 저장된 암호화된 비밀번호를 읽어온다.
			String encodedPwd=resultDto.getPwd();
			//로그인 폼에 입력한 비밀번호
			String inputPwd = dto.getPwd();
			//BCrypt 클래스의 static메소드를 이용해서 일치 여부를 얻어낸다.
			isValid = BCrypt.checkpw(inputPwd, encodedPwd);
		}
		
		if(isValid) {//만일 유효한 정보면
			//로그인 처리를 한다.
			session.setAttribute("id", dto.getId());
			//view페이지에서 사용할 정보
			mView.addObject("isSuccess", true);
		}else {//아니면
			mView.addObject("isSuccess", false);
		}
		
	}//loginProcess
	
	@Override
	public void getInfo(HttpSession session, ModelAndView mView) {
		//로그인 된 아이디를 session 객체를 이용해서 얻어온다.
		String id = (String)session.getAttribute("id");
		//dao를 이용해서 사용자 정보를 얻어와서
		UsersDto dto = dao.getData(id);
		//mView 객체에 담아준다.
		mView.addObject("dto", dto);
	}//getInfo

	@Override
	public void deleteUser(HttpSession session) {
		//세션에 저장된 아이디를 읽어와서
		String id = (String)session.getAttribute("id");
		//삭제
		dao.delete(id);
		//로그아웃 처리
		session.invalidate();
	}//deleteUser

	@Override
	public Map<String, Object> saveProfileImage(HttpServletRequest request, MultipartFile mFile) {
		//name과 이름이 같아야한다. 업로드된 파일이 저장이 되어있고 업로드 파일 저장 정보가 여기로 들어옴
		//원본 파일명, 저장된 파일 명
		
		//원본 파일 명
		String orgFileName = mFile.getOriginalFilename();

		//webapp/upload폴더 까지의 실제 경로(서버의 파일 시스템 상에서의 경로)
		//운영체제가 다르기 때문에 하드코딩을 할 수 없어서 메소드를 통해 경로를 얻어온다.
		String realPath = request.getServletContext().getRealPath("/upload");
		
		//저장할 파일의 상세 경로//upload 뒤에 붙을 파일 명을 위해 필요 \ 를 만들기 위해 필요함
		String filePath = realPath+File.separator;
		//전체 경로를 가지고 있는 파일 객체를 생성해야함. saveFileName
		
		//디렉토리를 만들 파일 객체 생성
		File upload = new File(filePath);
		if(!upload.exists()) {//만일 디렉토리가 존재하지 않으면 
			upload.mkdir();//만들어준다.
		}
		
		//저장할 파일 명을 구성한다.
		String saveFileName=
			System.currentTimeMillis()+orgFileName;
		try {
			//upload폴더에 파일을 저장한다.
			mFile.transferTo(new File(filePath+saveFileName)); //전체 경로
			System.out.println(filePath+saveFileName);
		} catch (Exception e) {
			e.printStackTrace();}
		//Map에 업로드 된 이미지 파일의 경로를 담아서 리턴한다.
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("imageSrc", "/upload/"+saveFileName);
		
		return map;
	}//profile

	@Override
	public void updateUser(HttpSession session, UsersDto dto) {
		//로그인 된 아이디를 읽어와서
		String id = (String)session.getAttribute("id");
		//UsersDto에 담고
		dto.setId(id);
		//만일 프로필 이미지를  수정하지 않았다면 null을 다시 넣어준다.
//		if(dto.getProfile().equals("")) {
//			dto.setProfile(null);
//		}
		//dao를 이용해서 수정 반영하기
		dao.update(dto);
	}//updateuser

	@Override
	public void updateUserPwd(HttpSession session, UsersDto dto, ModelAndView mView) {
		
		String id = (String)session.getAttribute("id");
		//세션 영역에 저장 된 아이디를 dto에 넣어준다.
		dto.setId(id);
		//작업 성공 여부
		boolean isSuccess = false;
		//1. 기존 비밀번호와 암호화된 비밀번호가 일치하는지 확인
		UsersDto resultDto = dao.getData(id);//아이디가 null일 가능성은 없다.
		//DB에 저장된 암호화된 비밀번호를 읽어온다.
		String encodedPwd=resultDto.getPwd();
		//로그인 폼에 입력한 비밀번호
		String inputPwd = dto.getPwd();
		
		boolean isValid = BCrypt.checkpw(inputPwd, encodedPwd);
		//2. 만일 일치한다면 새로운 비밀번호를 암호화 해서 저장한다.
		if(isValid) {
			//새로운 비밀번호를 암호화 한다.
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String encodedNewPwd = encoder.encode(dto.getNewPwd());
			//암호화된 새 비밀번호를 dto에 다시 넣어준다.
			dto.setNewPwd(encodedNewPwd);
			//dao를 이용해서 DB에반영한다.
			dao.updatePwd(dto);
			//성공
			isSuccess = true;
		}
		//mView 객체에 성공 여부를 담느다.
		mView.addObject("isSuccess",isSuccess);
	}//updateuserPwd
	
}//UsersService