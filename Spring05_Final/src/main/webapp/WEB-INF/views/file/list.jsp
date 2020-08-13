<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file/list.do</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
</head>
<body>
<div class="container mt-4">
<h1>파일 목록입니다.</h1>
	<a href="private/upload_form.do" class="btn btn-dark mt-4">파일 업로드</a>
	<table class="table mt-4 table-hover">
		<thead class="thead-dark">
			<tr>
				<th>번호</th>
				<th>작성자</th>
				<th>제목</th>
				<th>파일명</th>
				<th>파일크기</th>
				<th>등록일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="tmp" items="${list }">
			<tr>
				<td>${tmp.num }</td>
				<td>${tmp.writer }</td>
				<td>${tmp.title }</td>
				<td><a href="download.do?num=${tmp.num }">${tmp.orgFileName }</a></td>
				<td><fmt:formatNumber value="${tmp.fileSize }" pattern="#,###"/>byte</td>
				<td>${tmp.regdate }</td>
				<td>
					<c:if test="${tmp.writer eq id }">
						<a href="private/delete.do?num=${tmp.num }">삭제</a>
					</c:if>
				
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="Page navigation" style="text-align : center;">
		<ul class="pagination">
		<c:if test="${startPageNum ne 1 }">
			<li class="page-item">
			<a class="page-link" 
			href="list.do?pageNum=${startPageNum - 1 }&condition=${condition }&keyword=${encodedK }">Prev</a></li>
		</c:if>
		<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
			<c:choose>
				<c:when test="${i eq pageNum }">
				<li class="page-item active">
				<a class="page-link" 
				href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a></li>
				</c:when>
				<c:otherwise>
				<li class="page-item">
				<a class="page-link" href="list.do?pageNum=${i }&condition=${condition }&keyword=${encodedK }">${i }</a>
				</li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${endPageNum lt totalPageCount }">
			<li class="page-item">
			<a class="page-link" 
			href="list.do?pageNum=${endPageNum + 1 }&condition=${condition }&keyword=${encodedK }">Next</a></li>
		</c:if>
		</ul>
	</div>
	
	
	<form action="list.do" method="get" class="mb-4"><!-- 전송하기 위한 목적이라 get -->
	<div class="input-group">
		<div class="input-group-prepend">
    		<label class="input-group-text" for="condition">검색조건</label>
			<select name="condition" id="condition" class="custom-select">
				<option value="title_filename" <c:if test="${condition eq 'title_filename' }">selected</c:if>>제목+파일명</option>
				<option value="title" <c:if test="${condition eq 'title' }">selected</c:if>>제목</option>
				<option value="writer" <c:if test="${condition eq 'writer' }">selected</c:if> >작성자</option>
			</select>
		</div>
		<input value="${keyword }" type="text" name="keyword" placeholder="검색어를 입력해주세요!" class="form-control" />
		 	<div class="input-group-append">
				<button type="submit" class="btn btn-outline-secondary">검색</button>
			</div>
		</div>
	</form>
</div>
</body>
</html>