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
		<h1>DB관련 작업을 하다가 에러가 발생했습니다.</h1>
		<p class="alert alert-danger">
			<strong>${exception.message }</strong> <!-- getMasseage로 리턴한것 -->
			<a href="${pageContext.request.contextPath }/home.do" class="alter-link">인덱스로 이동</a>
		</p>
	</div>
</body>
</html>