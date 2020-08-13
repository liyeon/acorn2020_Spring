<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>/file/private/upload.do</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container">
	<h1>알림</h1>
		<p class="alert alert-success">
			<strong>${id }</strong>님이 업로드한 파일 <br />
			<strong>${dto.orgFileName }</strong>이 성공적으로 저장 되었습니다. <br />
			파일의 크기는 <strong>${dto.fileSize }</strong>byte입니다. <br />
			<a href="../list.do" class="alter-link">확인</a>
		</p>
	</div>
</body>
</html>