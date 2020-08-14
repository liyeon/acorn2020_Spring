<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/private/update.jsp</title>
</head>
<body>
<div class="container">
		<script>
			alert("글을 수정했습니다.");
			location.href="${pageContext.request.contextPath }/cafe/detail.do?num=${param.num}";
		</script>
</div>
</body>
</html>



