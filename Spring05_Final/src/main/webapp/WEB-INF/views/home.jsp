<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8"><!--  -->
<title>/views/home.jsp</title>
<link rel="stylesheet" href="resources/css/bootstrap.css" />
</head>
<body>
<div class="container mt-4">
<c:choose>
	<%-- 로그인 안된 상태 sessionScope.id --%>
	<c:when test="${empty id }">
		<a href="${pageContext.request.contextPath }/users/loginform.do">로그인</a>
		<a href="${pageContext.request.contextPath }/users/signup_form.do">회원가입</a>
	</c:when>
	
	<c:otherwise>
		<a href="${pageContext.request.contextPath }/users/private/info.do" class="btn btn-success"><strong>${id }</strong>님 로그인 중입니다!</a>
		<a href="${pageContext.request.contextPath }/users/logout.do" class="btn btn-danger">로그아웃</a>
	</c:otherwise>
</c:choose>
	<h1>인덱스페이지입니다.</h1>
	<p>Spring Framework 동작중</p>
	<ul>
		<li><a href="file/list.do">자료실 목록 보기</a></li>
		<li><a href="cafe/list.do">카페 글 목록 보기</a></li>
		<li><a href="shop/list.do">상품 목록 보기</a></li>
		<li><a href="angularjs/test01.jsp">AngularJs 테스트</a></li>
		<li><a href="css3/Step01_BorderRadius.html">css3테스트</a></li>
		<li><a href="index.html">ReactJs 테스트</a></li><%! /* 싱글페이지 기반이면 index.html만 있는거다. */ %>
		<!-- 구별하는 방법은 톰캣 서버에 쿠키를 심어 둔 뒤에 구별한다. -->
	</ul>
</div>
</body>
</html>