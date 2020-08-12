<%@page import="test.users.dto.UsersDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    	//세션에 저장된 아이디
    	String id = (String)session.getAttribute("id");
    	//수정할 회원의 정보를 읽어온다.
    	UsersDto dto = UsersDao.getInstance().getData(id);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/updateform.jsp</title>
<!-- jquery 로딩 -->
	<script src="${pageContext.request.contextPath }/js/jquery-3.5.1.js"></script>
<!-- jquery 플러그인 로딩 -->
    <script src="${pageContext.request.contextPath }/js/jquery.form.min.js"></script>
    <style>
    #profileImage {cursor : pointer; height : 100px; height : 100px; border : 1px solid : #f0f0f0;border-radius : 50%;object-fit: cover}
    /*프로필 업로드 폼을 화면에서 숨긴다.*/
    #profileForm{display : none; }
    </style>
</head>
<body>
	<div class="container">
		<h1>회원정보 수정 폼 입니다.</h1>
		<%if(dto.getProfile()==null){ %>
			<a id="profileLink" href="javascript:"><img id="profileImage" src="${pageContext.request.contextPath }/images/yellowbird.png" /></a>
		<%}else{ %>
			<a id="profileLink" href="javascript:"><img id="profileImage" src="${pageContext.request.contextPath }<%=dto.getProfile() %>" /></a>
		<%} %>
		<form action="update.jsp" method="post">
		<input type="hidden" name="profile" id="profile" value="<%=dto.getProfile() %>" />
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" id="id" value="<%=dto.getId()%>" disabled/>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" id="email" name="email" value="<%=dto.getEmail()%>" />
			</div>
			<button type="submit">수정확인</button>
			<button type="reset">취소</button>
		</form>
		
		<form id="profileForm" action="profile_upload.jsp" method="post" enctype="multipart/form-data">
			<input type="file" name="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif, .GIF" id="image"/>
		</form>
		
	</div>
	
	<script>
	//프로필 이미지를 클릭 했을 때 실행할 함수 등록
		$("#profileLink").on("click", function(){
			//input type="file" 을 강제 클릭한다.
			$("#image").click();
			
			
		});	
	
	
		//이미지를 선택 했을 때 실행할 함수 등록
		$("#image").on("change", function(){
			//폼을 강제 제출한다.
			$("#profileForm").submit();
			
		});
		//폼이 Ajax로 제출 될 수 있도록 플러그인을 동작 시킨다.
		//data는 결과를 서버로 부터 받음
		$("#profileForm").ajaxForm(function(data){
			//프로필 이미지를 업데이트한다. data=> {imageSrc:"/upload/xx.jpg"}
			$("#profileImage").attr("src", "${pageContext.request.contextPath }"+data.imageSrc);
			//회원 정보 수정폼이 전송 될 때 같이 전송 되도록 한다.
			$("#profile").val(data.imageSrc);//input type="hidden"의 value값
		});
	</script>
	
</body>
</html>