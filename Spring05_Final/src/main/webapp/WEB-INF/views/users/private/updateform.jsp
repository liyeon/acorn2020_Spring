<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/updateform.do</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<!-- jquery 로딩 -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<!-- jquery 플러그인 로딩 -->
    <script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
    <style>
	.profile {width : 200px; height : 200px; text-align : center;display : block;border-radius : 50%; border : 1px solid #000;}
	#profileImage {cursor : pointer;width : 100%; height : 100%;object-fit : cover;}
	img#profileImage{border-radius: 50%;}
	svg#profileImage{width : 80%; height : 94%; color : #868686;	}
    /*프로필 업로드 폼을 화면에서 숨긴다.*/
    #profileForm{display : none; }
    </style>
</head>
<body>
	<div class="container center">
		<h1>회원정보 수정 폼 입니다.</h1>
		<div class="profile">
			<a id="profileLink" href="javascript:">
		<c:choose>
			<c:when test="${empty dto.profile}">
				<svg id="profileImage" width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  					<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
				</svg>
			</c:when>
			<c:otherwise>
				<img id="profileImage" src="${pageContext.request.contextPath }${dto.getProfile() }" />
			</c:otherwise>
		</c:choose>
			</a>
		</div>
		
		<form action="update.do" method="post">
		<input type="hidden" name="profile" id="profile" value="${dto.profile }" />
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" id="id" class="form-control" value="${dto.id }" disabled/>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" id="email" name="email" class="form-control" value="${dto.email }" />
			</div>
			<button type="submit" class="btn btn-outline-primary">수정확인</button>
			<button type="reset" class="btn btn-outline-warning">취소</button>
		</form>
		
		<form id="profileForm" action="profile_upload.do" method="post" enctype="multipart/form-data">
			<input type="file" id="image" name="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif, .GIF" />
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
			//기존 프로필 이미지 요소를 제거한다.
			$("#profileImage").remove();
			//새로 img요소를 만들어서  #profileLink에 추가한다.
			$("<img/>").attr("id", "profileImage")
			.attr("src", "${pageContext.request.contextPath }"+data.imageSrc)
			.appendTo("#profileLink");
			
			//회원 정보 수정폼이 전송 될 때 같이 전송 되도록 한다.
			$("#profile").val(data.imageSrc);//input type="hidden"의 value값
		});
	</script>
	
</body>
</html>