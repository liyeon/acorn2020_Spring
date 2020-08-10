<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/todo/list.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container mt-4">
	<a href="insertform.do" class="btn btn-danger mb-4">할 일 추가폼</a>
		<h1>TODOList</h1>
		<table class="table table-hover">
				<tr>
					<th>번호</th>
					<th>할 일</th>
					<th>날짜</th>
					<th></th>
					<th></th>
				</tr>
				<c:forEach var="tmp" items="${list }">
				<tr>
					<td>${tmp.num }</td>
					<td>${tmp.work }</td>
					<td>${tmp.regdate }</td>
					<td><a href="updateform.do?num=${tmp.num }">수정</a></td>
					<td><a href="delete.do?num=${tmp.num }">삭제</a></td>
				</tr>
				</c:forEach>
		</table>
	</div> <!-- container -->
</body>
</html>