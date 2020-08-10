<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/todo/insertform;</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
<div class="container">
	<h1>Todo 작성 폼 입니다.</h1>
	<form action="insert.do" method="post">
		<div class="form-group">
			<input type="text" class="form-control" name="work" placeholder="오늘 할 일을 입력해주세요" />
		</div>
		<button type="submit" class="btn btn-info">추가</button>
	</form>
</div>

</body>
</html>