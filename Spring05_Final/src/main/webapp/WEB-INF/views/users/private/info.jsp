<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/info.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<style>
	.profile {width : 200px; height : 200px; display : inline-block;border-radius : 50%; border : 1px solid #000;}
	#profileImage {width : 100%; height : 100%;object-fit : cover; border-radius : 50%;}
</style>
</head>
<body>
	<div class="container mt-4">
	<h1>개인정보 페이지</h1>
		<table class="table table-hover">
			<tr>
				<th>아이디</th>
				<td>${dto.id }</td>
			</tr>
			<tr>
				<th>프로필 이미지</th>
				<td>
				<div class="profile">
				<img id="profileImage"
				src="${pageContext.request.contextPath }${dto.profile }" />
				</div>
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><a href="pwd_updateform.do">수정하기</a></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${dto.email }</td>
			</tr>
			<tr>
				<th>가입일</th>
				<td>${dto.regdate }</td>
			</tr>
		</table>
		<a href="updateform.do">개인정보 수정</a>
		<a href="javascript:deleteConfirm()">탈퇴</a>
		
		
	</div>
	
	
	
	<script>
		function deleteConfirm(){
			var isDelete = confirm("${id } 회원님 탈퇴하시겠습니까?");
			if(isDelete){
				location.href="delete.do?id=${id}";
			}
			
		}
	</script>
</body>
</html>