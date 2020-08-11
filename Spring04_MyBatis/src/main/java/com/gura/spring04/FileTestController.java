package com.gura.spring04;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileTestController {
	
	//<input type="file" name="myFile" /> 하나만 전송되는 경우
	@RequestMapping("/upload")
	public String upload(@RequestParam MultipartFile myFile,
			HttpServletRequest request, @RequestParam String title) { 
		//name과 이름이 같아야한다. 업로드된 파일이 저장이 되어있고 업로드 파일 저장 정보가 여기로 들어옴
		//원본 파일명, 저장된 파일 명
		
		//원본 파일 명
		String orgFileName = myFile.getOriginalFilename();
		
		//파일의 크기
		long fileSize = myFile.getSize();
		
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
			myFile.transferTo(new File(filePath+saveFileName)); //전체 경로
			System.out.println(filePath+saveFileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		request.setAttribute("orgFileName", orgFileName);
		request.setAttribute("saveFileName", saveFileName);
		request.setAttribute("fileSize", fileSize);
		request.setAttribute("title", title);
		return "upload";
	}
	
	@RequestMapping("/upload2")
	public String upload2(HttpServletRequest request, FileDto dto) { 
		//FileDto 객체에 있는 MultipartFile 객체의 참조값얻어오기
		MultipartFile myFile = dto.getMyFile();
		//name과 이름이 같아야한다. 업로드된 파일이 저장이 되어있고 업로드 파일 저장 정보가 여기로 들어옴
		//원본 파일명, 저장된 파일 명
		
		//원본 파일 명
		String orgFileName = myFile.getOriginalFilename();
		
		//파일의 크기
		long fileSize = myFile.getSize();
		
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
			myFile.transferTo(new File(filePath+saveFileName)); //전체 경로
			System.out.println(filePath+saveFileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//업로드 된 파일 정보를 FileDto에 담는다.
		dto.setOrgFileName(orgFileName);
		dto.setSaveFileName(saveFileName);
		dto.setFileSize(fileSize);
		
		//request영역에 FileDto 담기
		request.setAttribute("dto", dto);
		
		//Web-inf/views/upload2.jsp페이지로 forward 이동
		return "upload2";
	}
	
}