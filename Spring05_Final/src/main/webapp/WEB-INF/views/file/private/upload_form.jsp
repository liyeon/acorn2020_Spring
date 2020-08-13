<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/file/private/upload_form.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />

</head>
<body>
	<div class="container">
		<h1>파일 업로드 폼입니다.</h1>
		<%--
			[파일 업로드 폼 작성법]
			1. method="post"
			2. 폼에 enctype="multipart/form-data" 속성추가
			3. <input type="file" /> 을 이용한다.
			commons-fileupload-1.3.2, commons-io 파일을 lib폴더에 붙여 넣은 후 사용
			웹콘텐트에 upload라는폴더 생성
		 --%>
		<form action="upload.do" method="post" enctype="multipart/form-data" >
		<div class="form-group">
			<label for="title">제목(설명)</label>
			<input type="text" name="title" id="title" class="form-control" placeholder="파일 업로드 테스트"/>
		</div>
		<div>
			<label for="myFile">첨부파일</label>
			<input type="file" name="myFile" id="myFile" class="form-control" />
		</div>
			<button type="submit" class="btn btn-outline-primary mt-4">업로드</button>
		</form>
	</div>
</body>
</html>