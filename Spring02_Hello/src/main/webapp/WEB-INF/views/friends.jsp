<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/fortune.jsp</title>
</head>
<body>
<h1>오늘의 운세 페이지</h1>
<ul>
<c:forEach var="i" items="${friends }">
	<li>${i}</li>
</c:forEach>
</ul>
</body>
</html>