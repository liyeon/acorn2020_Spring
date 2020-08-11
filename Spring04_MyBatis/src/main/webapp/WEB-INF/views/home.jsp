<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/home.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />

</head>
<body>
<div class="container">
	<h1>인덱스 페이지 입니다.</h1>
	<ul>
		<li><a href="member/list.do">회원 목록 보기</a></li>
		<li><a href="todo/list.do">할 일 목록 보기</a></li>
		<li><a href="json01.do">json 응답1</a></li>
		<%--스프링에서의 json --%>
		<li><a href="json02.do">json 응답2</a></li>
		<li><a href="json03.do">json 응답3</a></li>
		<li><a href="json04.do">json 응답4</a></li>
		<li><a href="json05.do">json 응답5</a></li>
		<li><a href="json06.do">json 응답6</a></li>
		<li><a href="json07.do">json 응답7</a></li>
		<li><a href="json08.do">json 응답8</a></li>
		<li><a href="xml01.do">XML 응답 01</a></li>
		<li><a href="xml02.do">XML 응답 02</a></li>
		<li><a href="xml03.do">XML 응답 03</a></li>
	</ul>
	
	<button id="testBtn" class="btn btn-danger">ajax 테스트(콘솔확인)</button>
	
	<h2>파일 업로드 테스트</h2>
	<form action="upload.do" method="post" enctype="multipart/form-data">
		<div class="form-group">
			제목 <input type="text" name="title" class="form-control-lg"/>
		</div>
		<div class="form-group">
		첨부파일<input type="file" name="myFile" class="form-control-lg" />
		<button type="submit" class="btn btn-info">업로드 </button>
		</div>
	</form>
	<h2>파일 업로드 테스트2</h2>
	<form action="upload2.do" method="post" enctype="multipart/form-data">
		<div class="form-group">
			제목 <input type="text" name="title" class="form-control-lg"/>
		</div>
		<div class="form-group">
		첨부파일<input type="file" name="myFile" class="form-control-lg" />
		<button type="submit" class="btn btn-info">업로드 </button>
		</div>
		
	</form>
</div>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<script>
//jsoncontroller를 jquery가 받아서 출력해줌 
	$("#testBtn").on("click", function(){
		$.ajax({
			url:"json07.do",
			method:"GET",
			success:function(data){
				//data는 plain object or array 이다.
				console.log(data);
			}
		});
	});
</script>
</body>
</html>