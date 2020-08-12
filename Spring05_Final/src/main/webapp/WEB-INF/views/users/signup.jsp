<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/signup.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container center">
		<p>
			<strong>${param.id }</strong>님 가입 되었습니다
		</p>
		<a href="loginform.do" class="btn btn-dark">로그인하러가기</a>
	</div>
</body>
</html>