package com.gura.spring05.shop.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.gura.spring05.shop.dto.ShopDto;

public class ShopDaoImpl implements ShopDao{
	@Autowired
	private SqlSession session;
	
	@Override
	public List<ShopDto> getList() {
		return session.selectList("shop.getList");
	}

	@Override
	public void minusCount(int num) {
		session.update("shop.minusCount", num);
	}

	@Override
	public void minusMoney(ShopDto dto) {
		session.update("shop.minusMoney", dto);
	}

	@Override
	public void plusPoint(ShopDto dto) {
		session.update("shop.plusPoint", dto);
	}

	@Override
	public int getPrice(int num) {
		return session.selectOne("shop.getPrice", num);
	}
}