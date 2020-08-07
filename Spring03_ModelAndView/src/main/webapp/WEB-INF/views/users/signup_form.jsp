<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/signup_form.jsp</title>
</head>
<body>
	<div class="container">
		<h1>회원가입폼</h1>
		<form action="signup.do" method="post">
			<input type="text" name="id" placeholder="아이디를 입력하세요" />
			<input type="text" name="pwd" placeholder="비밀번호를 입력하세요!" />
			<button type="submit">가입</button>
		</form>
		<h1>회원가입폼2</h1>
		<form action="signup2.do" method="post">
			<input type="text" name="id" placeholder="아이디를 입력하세요" />
			<input type="text" name="pwd" placeholder="비밀번호를 입력하세요!" />
			<button type="submit">가입</button>
		</form>
		<h1>회원가입폼3</h1>
		<form action="signup3.do" method="post">
			<input type="text" name="id" placeholder="아이디를 입력하세요" />
			<input type="text" name="pwd" placeholder="비밀번호를 입력하세요!" />
			<button type="submit">가입</button>
		</form>
	</div>
</body>
</html>