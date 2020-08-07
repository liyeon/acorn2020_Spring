<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/member/insertform;</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
<div class="container">
	<h1>회원정보추가폼입니다.</h1>
	<form action="insert.do" method="post">
		<div class="form-group">
			<input type="text" class="form-control" name="name" placeholder="이름을 입력해주세요" />
		</div>
		<div class="form-group">
			<input type="text" class="form-control" name="addr" placeholder="주소를 입력해주세요" />
		</div>
		<button type="submit" class="btn btn-info">추가</button>
	</form>
</div>

</body>
</html>