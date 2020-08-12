<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/users/login.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
<div class="container mt-4 center">
	<c:choose>
	<%--requestScope. --%>
		<c:when test="${isSuccess }">
		<%--sessionScope / requestScope.url, encodedUrl // ModelAndView--%>
		<p><strong>${id }</strong>님이 로그인 되었습니다. <a href="${url }" class="btn btn-dark">확인</a></p>
		</c:when>
		<c:otherwise>
		<p>아이디 혹은 비밀번호가 틀립니다ㅠㅜ <a href="loginform.do?url=${encodedUrl }" class="btn btn-dark">다시시도</a></p>
		</c:otherwise>
	</c:choose>
</div>
</body>
</html>