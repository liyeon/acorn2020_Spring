package com.gura.spring04.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gura.spring04.member.dto.MemberDto;

//dao는 데이터의 저장소 라서 repository 
//dao를 bean으로 만들기 위한 어노테이션(Spring이 관리하는 객체를 만들기 위한 어노테이션)Spring Bean container
@Repository
public class MemberDaoImpl implements MemberDao{
	//의존 객체 주입 받기(Dependency Injection)
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(MemberDto dto) {
		/*
		 * mapper namespace : member
		 * sql id : insert
		 * parameterType : MemberDto
		 */
		session.insert("member.insert", dto);
	}

	@Override
	public void update(MemberDto dto) {
		/*
		 * mapper namespace : member
		 * sql id : update
		 * parameterType : MemberDto
		 */
		session.update("member.update", dto);
	}

	@Override
	public void delete(int num) {
		/*
		 * mapper namespace : member
		 * sql id : delete
		 * parameterType : int or java.lang.Integer
		 */
		session.delete("member.delete", num);
	}

	@Override
	public MemberDto getData(int num) {
		/*
		 * mapper namespace : member
		 * sql id : getData
		 * parameterType : int or java.lang.Integer
		 * resultType : MemberDto
		 * -resultType은 select된 row하나를 담을 데이터 type을 의미한다.
		 * selectOne() 메소드는 resultType을 리턴해준다.
		 * resultType이 무엇이냐에 따라서 return type이 달라진다.
		 * 
		 * mybatis가 selectOne이라는 메소드를 만들어서 dto.setNum 등등 을 해준다.
		 * selectOne(){
		 * MemberDto dto = new MemberDto();
		 * dto.setNum(num);
		 * return dto
		 * }
		 * 
		 */
		MemberDto dto = session.selectOne("member.getData", num);
		return dto;
	}

	@Override
	public List<MemberDto> getList() {
		/*
		list타입이 아니고 resultType이 제너릭 타입으로 지정된다.
		파라미터타입 없음
		 * resultType : MemberDto
		 *  -resultType은 select된 row하나를 담을 데이터 type을 의미한다.
		 *  -selectList()메소드는 List type을 리턴하고 List의 generic type이 
		 *   resultType이 된다.
		 */
		List<MemberDto> list = session.selectList("member.getList");
		return list;
	}
}//MemberDaoImpl