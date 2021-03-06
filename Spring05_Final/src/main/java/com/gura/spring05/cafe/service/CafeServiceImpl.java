package com.gura.spring05.cafe.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gura.spring05.cafe.dao.CafeCommentDao;
import com.gura.spring05.cafe.dao.CafeDao;
import com.gura.spring05.cafe.dto.CafeCommentDto;
import com.gura.spring05.cafe.dto.CafeDto;
import com.gura.spring05.exception.NotDeleteException;
import com.gura.spring05.file.dto.FileDto;


@Service
public class CafeServiceImpl implements CafeService{
	@Autowired
	private CafeDao cafeDao;
	@Autowired
	private CafeCommentDao cafeCommentDao;
	
	//한 페이지에 나타낼 row 의 갯수
  	final int PAGE_ROW_COUNT=5;
  	//하단 디스플레이 페이지 갯수
  	final int PAGE_DISPLAY_COUNT=5;
	
	@Override
	public void getList(HttpServletRequest request) {
		//보여줄 페이지의 번호
	  	int pageNum=1;
	  	//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
	  	String strPageNum=request.getParameter("pageNum");
	  	if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면       
	  		//페이지 번호를 설정한다.
	  		pageNum=Integer.parseInt(strPageNum);
	  	}
	  	//보여줄 페이지 데이터의 시작 ResultSet row 번호 (등차수열 an = a1 + (n-1)d ) ///공차수열
	  	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	  	//보여줄 페이지 데이터의 끝 ResultSet row 번호
	  	int endRowNum=pageNum*PAGE_ROW_COUNT;
	  	
	  	/*
			검색 키워드에 돤련된 처리
		*/
		String keyword=request.getParameter("keyword"); //검색키워드
		String condition=request.getParameter("condition"); //검색조건
		
	  	if(keyword==null){
	  		//전달된 키워드가 없다면
	  		keyword="";//빈문자열을 ㅇ넣어준다.
	  		condition="";
	  	}
		//인코딩된 키워드를 미리 만들어 둔다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//검색 키워드와 startRowNum, endRowNum 을 담을 CafeDto 객체 생성
		CafeDto dto=new CafeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면 
			if(condition.equals("title_content")){
				//검색 키워드를 CafeDto 객체의 필드에 담는다.
				dto.setContent(keyword);
				dto.setTitle(keyword);
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
				
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
				
			}
		}
		
		//파일 목록 얻어오기
		List<CafeDto> list = cafeDao.getList(dto);
		
		//전체 row 의 갯수
		int totalRow=cafeDao.getCount(dto);
		
		//전체 페이지의 갯수 구하기
		//전체 글의  개수 나누기 한페이지 마다 뜰 개수 실수로 캐스팅 하여 나눈 실수값을 정수값으로 올림 = meth.ceil(올림연산)천장 함수
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호 
		//0.몇은 다 영임
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면  보정을 해주지 않으면 PAGE_DISPLAY COUNT 의 갯수에 맞춰서 빈 페이지가 들어간다.
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}
		
		//EL에서 사용할 값을 미리 request에 담아두기
		request.setAttribute("list", list);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		
	}

	@Override
	public void getDetail(HttpServletRequest request) {
		/*
		 * List<CafeCommentDto>
		 * commentList
		 * startPageNm
		 * endPageNum
		 * pageNum
		 * totalPageCount
		 * 각각의 값을 구해서 리퀘스트에 담는다. 
		 */
		
		//파라미터로 전달되는 글 번호
		int num = Integer.parseInt(request.getParameter("num")); //ref_group 번호
		/*
		검색 키워드에 돤련된 처리
		*/
		String keyword=request.getParameter("keyword"); //검색키워드
		String condition=request.getParameter("condition"); //검색조건
		
	  	if(keyword==null){
	  		//전달된 키워드가 없다면
	  		keyword="";//빈문자열을 ㅇ넣어준다.
	  		condition="";
	  	}
		//인코딩된 키워드를 미리 만들어 둔다. 
		String encodedK=URLEncoder.encode(keyword);
		
		//글 번호와 검색 키워드를 담을 CafeDto 객체 생성 CafeDto 객체 생성
		CafeDto dto=new CafeDto();
		dto.setNum(num);//글번호 담기
		
		if(!keyword.equals("")){ //만일 키워드가 넘어온다면 
			if(condition.equals("title_content")){
				//검색 키워드를 CafeDto 객체의 필드에 담는다.
				dto.setContent(keyword);
				dto.setTitle(keyword);
			}else if(condition.equals("title")){
				dto.setTitle(keyword);
				
			}else if(condition.equals("writer")){
				dto.setWriter(keyword);
			}
		}//if 종료
		//자세히 보여줄 글 정보
		CafeDto resultDto = cafeDao.getData(dto);
		//view 페이지 에서 필요한 내용 HttpServletRequest에 담기
		request.setAttribute("dto", resultDto);
		request.setAttribute("condition", condition);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		
		//글 조회수 올리기
		cafeDao.addViewCount(num);
		/* 아래는 댓글 페이징 처리 관련 비즈니스 로직 입니다.*/
		final int PAGE_ROW_COUNT=5;
		final int PAGE_DISPLAY_COUNT=5;
		
		
		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=cafeCommentDao.getCount(num);

		//보여줄 페이지의 번호(만일 pageNum 이 넘어오지 않으면 가장 마지막 페이지)
		String strPageNum=request.getParameter("pageNum");
		//전체 페이지의 갯수 구하기
		int totalPageCount=
						(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//일단 마지막 페이지의 댓글 목록을 보여주기로 하고
		int pageNum=totalPageCount;
		//만일 페이지 번호가 넘어온다면
		if(strPageNum!=null) {
			//넘어온 페이지에 해당하는 댓글 목록을 보여주도록 한다.
			pageNum=Integer.parseInt(strPageNum);
		}
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		
		//시작 페이지 번호
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면 
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}
		
		// CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		CafeCommentDto commentDto=new CafeCommentDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(num);
		
		//DB 에서 댓글 목록을 얻어온다.
		List<CafeCommentDto> commentList=cafeCommentDao.getList(commentDto);
		//request 에 담아준다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		
	} //getDetail

	@Override
	public void saveContent(CafeDto dto) {
		cafeDao.insert(dto);
	}

	@Override
	public void updateContent(CafeDto dto) {
		cafeDao.update(dto);
	}
	@Override
	public void deleteContent(int num, HttpServletRequest request) {
		//1. 삭제할 글의 정보를 읽어온다.
//		CafeDto dto=cafeDao.getData(num);
//		//2. 본인이 작성한 글이 아닌경우 에러 처리를한다 (예외를 발생시킨다)
//		String id=(String)request.getSession().getAttribute("id");
//		//만일 로그인된 아이디와 글 작성자가 다르면
//		if(!id.equals(dto.getWriter())) {
//			throw new NotDeleteException("남의 글 지우기 없기!");
//		}
		cafeDao.delete(num);
	}
	
	//======댓글=======
	@Override
	public void saveCommnet(HttpServletRequest request) {
		//댓글 작성자
		String writer=(String)request.getSession().getAttribute("id");
		//폼 전송 되는 댓글의 정보 얻어내기
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		String target_id=request.getParameter("target_id");
		String content=request.getParameter("content");
		/*
		 *  원글의 댓글은 comment_group 번호가 전송이 안되고
		 *  댓글의 댓글은 comment_group 번호가 전송이 된다.
		 *  따라서 null여부를 조사하면 원글의 댓글인지 댓글의 댓글인지 판단 할 수 있다.
		 */
		String comment_group=request.getParameter("comment_group");
		//새 댓글의 글번호는 dao를 이용해서 미리 얻어낸다.
		int seq=cafeCommentDao.getSequence();
		
		//저장할 댓글 정보를 dto에 담기
		CafeCommentDto dto = new CafeCommentDto();
		dto.setNum(seq);
		dto.setWriter(writer);
		dto.setTarget_id(target_id);
		dto.setContent(content);
		dto.setRef_group(ref_group);
		
		if(comment_group==null) {//원글의 댓글인 경우 자기자신의 글번호와 동일하게 넣어야하기 때문에 null임
			//댓글의 글번호가 comment_group 번호가 된다.
			dto.setComment_group(seq);
		}else {//댓글의 댓글인 경우
			//폼 전송 된 comment_group 번호를 숫자로 바꿔서 dto에 넣어준다.
			dto.setComment_group(Integer.parseInt(comment_group));
		}
		//댓글 정보를 DB에 저장한다.
		cafeCommentDao.insert(dto);
	}
	//댓글 삭제
	@Override
	public void deleteComment(HttpServletRequest request) {
		//GET 방식 파라미터로 전달되는 삭제할 댓글 번호
		int num=Integer.parseInt(request.getParameter("num"));
		//세션에 저장된 로그인 된 아이디
		String id=(String)request.getSession().getAttribute("id");
		//댓글의 정보를 얻어와서 댓글의 작성자와 같은지 비교한다.
//		String writer=cafeCommentDao.getData(num).getWriter();
//		if(!writer.equals(id)) {
//			throw new NotDeleteException("다른 사람이 입력한 댓글은 삭제 할 수 없습니다.");
//		}
		cafeCommentDao.delete(num);
		
	}
	
	//댓글 수정
	@Override
	public void updateComment(CafeCommentDto dto) {
		cafeCommentDao.update(dto);
	}
	
	//댓글 스크롤
	@Override
	public void moreCommentList(HttpServletRequest request) {
		//파라미터로 전달된 pageNum과 ref_group 번호를 읽어온다
		int pageNum=Integer.parseInt(request.getParameter("pageNum"));
		int ref_group=Integer.parseInt(request.getParameter("ref_group"));
		
		//해당 페이지에 맞는 댓글 목록만 가져오는 것.
		CafeDto dto=cafeDao.getData(ref_group);
		request.setAttribute("dto", dto);
		
		/*
		 * 아래는 댓글 페이징 처리 관련 비즈니스 로직입니다.
		 */
		
		//보여줄 페이지 데이터의 시작 ResultSet row 번호
		int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
		//보여줄 페이지 데이터의 끝 ResultSet row 번호
		int endRowNum=pageNum*PAGE_ROW_COUNT;
		
		//전체 row 의 갯수를 읽어온다.
		//자세히 보여줄 글의 번호가 ref_group  번호 이다. 
		int totalRow=cafeCommentDao.getCount(ref_group);
		
		//전체 페이지의 갯수 구하기
		int totalPageCount=
		(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		
		// CafeCommentDto 객체에 위에서 계산된 startRowNum 과 endRowNum 을 담는다.
		
		CafeCommentDto commentDto=new CafeCommentDto();
		commentDto.setStartRowNum(startRowNum);
		commentDto.setEndRowNum(endRowNum);
		//ref_group 번호도 담는다.
		commentDto.setRef_group(ref_group);
		
		//DB에서 댓글 목록을 얻어온다.
		List<CafeCommentDto> commentList=cafeCommentDao.getList(commentDto);
		//request에 담아준다.
		request.setAttribute("commentList", commentList);
		request.setAttribute("totalPageCount", totalPageCount);
	}
	
	//angular ajax list
	@Override
	public Map<String, Object> getList2(HttpServletRequest request) {
		//보여줄 페이지의 번호
	  	int pageNum=1;
	  	//보여줄 페이지의 번호가 파라미터로 전달되는지 읽어와 본다.	
	  	String strPageNum=request.getParameter("pageNum");
	  	if(strPageNum != null){//페이지 번호가 파라미터로 넘어온다면       
	  		//페이지 번호를 설정한다.
	  		pageNum=Integer.parseInt(strPageNum);
	  	}
	  	//보여줄 페이지 데이터의 시작 ResultSet row 번호 (등차수열 an = a1 + (n-1)d ) ///공차수열
	  	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	  	//보여줄 페이지 데이터의 끝 ResultSet row 번호
	  	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
		//startRowNum, endRowNum 을 담을 CafeDto 객체 생성
		CafeDto dto=new CafeDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		
		//파일 목록 얻어오기
		List<CafeDto> list = cafeDao.getList(dto);
		
		//전체 row 의 갯수
		int totalRow=cafeDao.getCount(dto);
		
		//전체 페이지의 갯수 구하기
		//전체 글의  개수 나누기 한페이지 마다 뜰 개수 실수로 캐스팅 하여 나눈 실수값을 정수값으로 올림 = meth.ceil(올림연산)천장 함수
		int totalPageCount=
				(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
		//시작 페이지 번호 
		//0.몇은 다 영임, 소수점을 측정하지 않기 때문에 다 0이 나온다.
		int startPageNum=
			1+((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
		//끝 페이지 번호
		int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		//끝 페이지 번호가 잘못된 값이라면  보정을 해주지 않으면 PAGE_DISPLAY COUNT 의 갯수에 맞춰서 빈 페이지가 들어간다.
		if(totalPageCount < endPageNum){
			endPageNum=totalPageCount; //보정해준다. 
		}
		
		//EL에서 사용할 값을 미리 request에 담아두기
		request.setAttribute("list", list);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPageCount", totalPageCount);
	
		//글 목록과 페이징 처리에 관련된 값을 담은 MAP객체 생성
		Map<String, Object> map=new HashMap<String, Object>();
		//글 목록을 전체 Map 에 담아준다.
		map.put("list", list);
		
		//페이징 처리에 필요한 값을 Map 에 담아서
		Map<String, Integer> paging=new HashMap<String, Integer>();
		paging.put("startPageNum", startPageNum);
		paging.put("endPageNum", endPageNum);
		paging.put("pageNum", pageNum);
		paging.put("totalPageCount", totalPageCount);
		//전체 Map에 담아준다.
		map.put("paging", paging);
		return map;
	}

}//끝