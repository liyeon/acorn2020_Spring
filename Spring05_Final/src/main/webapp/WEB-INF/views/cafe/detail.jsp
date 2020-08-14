<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/cafe/detail.do</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<style>
	/* 글 내용을 출력할 div 에 적용할 css */
	.contents{
		width: 100%;
		padding : 20px;
		border: 1px dotted #cecece;
	}
	.contents img{max-width : 100%;}
	.contents * {font-family : auto;}
</style>
</head>
<body>
<div class="container mt-4">
	<c:if test="${not empty keyword }">
		<p class="alert alert-success">
			<strong>${keyword }</strong>라는 키워드로 검색한 결과에 대한 자세히 보기 입니다.
		</p>
	</c:if>
	<c:if test="${dto.prevNum ne 0 }">
	<a class="" href="detail.do?num=${dto.prevNum }&condition=${condition }&keyword=${encodedK }">
		<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-up-square-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	  		<path fill-rule="evenodd" d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm4 9a.5.5 0 0 1-.374-.832l4-4.5a.5.5 0 0 1 .748 0l4 4.5A.5.5 0 0 1 12 11H4z"/>
		</svg>
		이전글
	</a>
	</c:if>
	<c:if test="${dto.nextNum ne 0 }">
		<a class="" href="detail.do?num=${dto.nextNum }&condition=${condition }&keyword=${encodedK }">
			<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-caret-down-square-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	  			<path fill-rule="evenodd" d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2zm4 4a.5.5 0 0 0-.374.832l4 4.5a.5.5 0 0 0 .748 0l4-4.5A.5.5 0 0 0 12 6H4z"/>
			</svg>
			다음글
		</a>
	</c:if>
	<h1>글 상세 페이지</h1>
	<table class="table table-hover table-warning">
		<tr>
			<th class="bg-warning">글번호</th>
			<td>${dto.num }</td>
		</tr>
		<tr>
			<th  class="bg-warning">작성자</th>
			<td>${dto.writer }</td>
		</tr>
		<tr>
			<th  class="bg-warning">제목</th>
			<td>${dto.title }</td>
		</tr>
		<tr>
			<th  class="bg-warning">등록일</th>
			<td>${dto.regdate }</td>
		</tr>
		<tr>
			<th  class="bg-warning">조회수</th>
			<td>${dto.viewCount }</td>
		</tr>
	</table>
	<div class="contents mb-4">${dto.content }</div>
	<a class="btn btn-outline-info" href="list.do">목록 보기</a>
	
	<c:if test="${dto.writer eq id }">
		<a class="btn btn-outline-warning" href="private/updateform.do?num=${dto.num }">
			수정
		</a>
		<a class="btn btn-outline-danger" href="javascript:deleteConfirm()">
			삭제
		</a>
	</c:if>
</div>

<script>
	function deleteConfirm(){
		var isDelete=confirm("해당 글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="private/delete.do?num=${dto.num }"
		}
		
	}
</script>
</body>
</html>