<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/pwd_updateform.do</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
	<div class="container">
		<h1>비밀번호 수정 폼</h1>
		<form action="pwd_update.do" method="post" id="myForm">
			<div class="form-group">
				<label for="pwd">기존 비밀번호</label>
				<input type="password" name="pwd" id="pwd" class="form-control"/>
			</div>
			<div class="form-group">
				<label for="newPwd">새 비밀번호</label>
				<input type="password" name="newPwd" id="newPwd" class="form-control" />
			</div>
			<div class="form-group">
				<label for="newPwd2">새 비밀번호 확인</label>
				<input type="password" name="newPwd2" id="newPwd2" class="form-control" />
			</div>
			<button type="submit" class="btn btn-outline-dark">수정하기</button>
		</form>
	</div>
	
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
	<script>
	
	
	//id가 myForm인 곳에 submit 이벤트가 일어 났을 때 실행 할 함수 등록
	$("#myForm").on("submit", function(){
		//입력한 새로운 비밀번호2개를 읽어와서
		var pwd1=$("#newPwd").val();
		var pwd2=$("#newPwd2").val();
		//만일 일치하지 않으면
		if(pwd1 != pwd2){
			//알람을 띄우고
			alert("새 비밀번호가 일치하지 않습니다.");
			//비밀번호 입력란을 초기화 하고 포커스도 주고
			$("#newPwd").val("");
			$("#newPwd2").val("");
			//폼 전송을 막는다.
			return false;
		}
	});
	</script>
	
</body>
</html>