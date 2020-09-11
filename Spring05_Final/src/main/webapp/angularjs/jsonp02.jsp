<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//callback 이라는 파라미터 명으로 전달되는 문자열 읽어오기
	String callback=request.getParameter("callback"); //묵시적으로 서버에서 약속된 이름이 callback이다 .
	//msg 라는 파라미터 명으로 전달되는 문자열 읽어오기
	String msg=request.getParameter("msg");
	System.out.println("msg : "+msg);
%>
<% if(callback != null){//objet 전달 %>
	<%=callback %>({isSuccess:true});
<%}else {%>
	{"isSuccess":true}
<%} %>
