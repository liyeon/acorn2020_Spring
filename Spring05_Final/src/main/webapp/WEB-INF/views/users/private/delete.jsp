<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/users/private/delete.jsp</title>
</head>
<body>
<div class="container">
		<p><strong>${param.id }</strong>님 탈퇴처리되었습니다.</p>
		<a href="${pageContext.request.contextPath }/home.do">확인</a>
</div>
</body>
</html>