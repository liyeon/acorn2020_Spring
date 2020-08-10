<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/member/updateform.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
<div class="container">
	<h1>오늘 할 일 수정 폼입니다.</h1>
	<form action="update.do" method="post">
		<div class="form-grouop">
			<label for="num">번호</label>
			<input type="hidden" name="num"value="${dto.num }"/>
			<input type="text" id="num" class="form-control"  value="${dto.num }"  readonly/>
		</div>
		<div class="form-group">
			<label for="work">할 일</label>
			<input type="text" name="work" class="form-control" placeholder="오늘 할 일을 입력해주세요" value="${dto.work }"/>
		</div>
		<div class="form-grouop mb-4">
			<label for="regdate">날짜</label>
			<input type="text" id="regdate" class="form-control"  value="${dto.regdate }"  readonly/>
		</div>
		<button type="submit" class="btn btn-dark">수정</button>
		<button type="reset" class="btn btn-warning">취소</button>
	</form>
</div>
</body>
</html>