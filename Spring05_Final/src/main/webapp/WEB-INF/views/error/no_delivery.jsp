<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/error/data_access.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container">
		<h1>배송관련오류가발생했습니다.</h1>
		<p class="alert alert-danger">
			<strong>${exception.message }</strong>
			배송이 가능해지면 다시 연락 하겠습니다.
			<a href="${pageContext.request.contextPath }/home.do" class="alter-link">인덱스로 이동</a>
		</p>
	</div>
</body>
</html>