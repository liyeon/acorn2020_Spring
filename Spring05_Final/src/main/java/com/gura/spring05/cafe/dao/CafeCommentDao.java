package com.gura.spring05.cafe.dao;

import java.util.List;

import com.gura.spring05.cafe.dto.CafeCommentDto;
import com.gura.spring05.file.dto.FileDto;

public interface CafeCommentDao {
	//댓글 목록 얻어오기
	public List<CafeCommentDto> getList(CafeCommentDto dto);
	//public List<CafeCommentDto> getList(int ref_group);
	//댓글 삭제
	public void delete(int num);
	//댓글 추가
	public void insert(CafeCommentDto dto);
	//추가할 댓글의 글번호를 리턴하는 메소드
	public int getSequence();
	//댓글 수정
	public void update(CafeCommentDto dto);
	//댓글 하나의 정보를 리턴하는 메소드
	public CafeCommentDto getData(int num);
	//댓글의 갯수를 리턴하는 메소드
	public int getCount(int ref_group);
}