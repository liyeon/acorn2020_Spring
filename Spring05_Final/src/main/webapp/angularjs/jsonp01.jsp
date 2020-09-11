<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//callback 이라는 파라미터 명으로 전달되는 문자열 읽어오기
	String callback=request.getParameter("callback"); //묵시적으로 서버에서 약속된 이름이 callback이다 .
	//클라이언트에게 응답할 데이터라고 가정
	//원하는 이름의 함수를 만들어 놓고 함수를 호출하는 구조로 갈 수 있다.
	//클라이언트가 callback이라는 파라미터 명으로 함수명을 만들어서 전달해주면 함수를 만들어 준다.
	//함수를 동적으로 만들어준다. 
	int num=1;
	String name="김구라";
	//자바스크립트로 평가가 되었을 때 오브젝트를 만들어준다.
	System.out.println("callback 함수명 : " + callback);
%>
<% if(callback != null){%>
	<%=callback %>({num:<%=num %>, name:"<%=name %>"});
<%}else {%>
	{"num":<%=num %>, "name":"<%=name %>"}
<%} %>
