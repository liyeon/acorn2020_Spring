<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/home.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container">
		<h1>인덱스 페이지입니다.</h1>
		<p>spring framework 작동중입니다.</p>
		<ul>
			<li><a href="test/play.html">spring 컨트롤러를 거치지 않는 요청</a></li>
			<li><a href="test/game.jsp">spring 컨트롤러를 거치지 않는 요청2</a></li>
			<!-- !!!.do 로끝나는것만 컨트롤러로 요청하기 때문에 위의 것들은 컨트롤러를 거치지 않는다. -->
			<li><a href="friends.do">친구목록보기</a></li>
			<li><a href="friends2.do">친구목록보기2</a></li>
			<li><a href="friends3.do">친구목록보기3</a></li>
			<li><a href="delete.do">친구정보삭제(리다이렉트 이동)</a></li>
			<li><a href="delete2.do">친구정보삭제2(리다이렉트 이동)</a></li>
			<li><a href="users/signup_form.do">회원가입폼</a></li>
		</ul>
		<h2>오늘의 공지사항</h2>
		<ul>
			<c:forEach var="tmp" items="${noticeList }">
			<li>${tmp }</li>
			</c:forEach>
		</ul>
	</div>
</body>
</html>