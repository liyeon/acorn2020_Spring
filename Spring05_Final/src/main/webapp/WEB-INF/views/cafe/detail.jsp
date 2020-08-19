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
	#profileImage {box-shadow: rgba(209, 209, 209, 0.68) 0px 0px 5px ;width : 50px; height :50px; text-align : center;display : inline-block;border-radius : 50%; object-fit : cover;}
	svg#profileImage{color :#e2e2e2;	}
	/*ul 요소의 기본 스타일 제거*/
	.comments {margin-top : 50px;}
	.comments ul{
		padding : 0;
		margin : 0;
		list-style-type: none;
	}
	
	.comments dt{
		margin-top : 5px;
	}
	.comments dd{
		margin-left : 26px;
	}
	.comment_form, .comment-insert-form, .comment-update-form {
	display : inline-block;
	width : 100%;
	margin : 20px 0;
	}
	.comment_form textarea, .comment_form button,
	.comment-insert-form textarea, .comment-insert-form button,
	.comment-update-form textarea, .comment-update-form button
	
	{
		float : left;
	}
	/*.reply_icon을 li 요소를 기준으로 배치하기*/
	.comments li{
	position : relative;
	display : inline-block;
	width : 100%;
	}
	.comments ul li{
	padding : 20px 0;
		border-top : 1px solid #888;
	}
	.comments ul li:last-child{
	border-bottom : 1px solid #888;
	}
	.comment_form textarea, .comment-insert-form textarea, .comment-update-form textarea{
		width : 85%;
		height : 100px;
	}
	/* 댓글에 댓글을 다는 폼은 일단 숨긴다. */
	.comments form{
		display : none;
	}
	.comment_form button, .comment-insert-form button, .comment-update-form button{
		width : 15%;
		height : 100px;
	}
	
	.reply_icon{
		position : absolute;
		top : 27px;
		left : 11px;
		width : 30px;
		height : 30px;
		color : #b7decb;
	}
	.comments pre{
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
		margin : 10px 0 0 27px;
		display: block;
 		padding: 9.5px;
		font-size: 13px;
		line-height: 1.42857143;
		color: #333333;
		word-break: break-all;
		word-wrap: break-word;
    	white-space: pre-wrap;
		background-color: #f5f5f5;
		border: 1px solid #ccc;
		border-radius: 4px;
	}
	
</style>
</head>
<body>
<div class="container mt-4 mb4">
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
	<!-- 댓글 목록 -->
	<div class="comments">
		<ul>
			<c:forEach var="tmp" items="${commentList }">
				<c:choose>
					<c:when test="${tmp.deleted eq 'yes'}">
						<li>삭제된댓글입니다!!!!</li>
					</c:when>
					<c:otherwise>
						<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }"> style="padding-left:50px"</c:if>>
						<c:if test="${tmp.num ne tmp.comment_group }">
							
							<svg viewBox="0 0 16 16" class="bi bi-arrow-return-right reply_icon" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
		 						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/>
							</svg>
						</c:if>
							<dl>
								<dt>
									<c:choose>
										<c:when test="${empty tmp.profile}">
											<svg id="profileImage" width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-person-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  						<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
											</svg>
										</c:when>
										<c:otherwise>
											<img id="profileImage"
											src="${pageContext.request.contextPath }${tmp.profile }" />
										</c:otherwise>
									</c:choose>
									
									<span>${tmp.writer }</span>
									<c:if test="${tmp.num ne tmp.comment_group }">
										<strong>@${tmp.target_id }</strong>
									</c:if>
									<span>${tmp.regdate }</span>
									<a href="javascript:" class="reply_link">답글</a>
									<c:if test="${tmp.writer eq id }">
										<a href="javascript:" class="comment-update-link">수정</a>
										<a href="javascript:deleteComment(${tmp.num })">삭제</a>
									</c:if>
								</dt>
								<dd>
									<pre>${tmp.content }</pre>
								</dd>
							</dl>
							<form class="comment-insert-form" action="private/comment_insert.do" method="post">
								<input type="hidden" name="ref_group" value="${dto.num }"/>
								<input type="hidden" name="target_id" value="${tmp.writer }"/>
								<input type="hidden" name="comment_group" value="${tmp.comment_group }"/>
								<textarea name="content" class="form-control"></textarea>
								<button type="submit" class="btn btn-success">등록</button>
							</form>
							<!-- 로그인된 아이디와 댓글의 작성자가 같으면 수정폼 출력 -->
							<c:if test="${tmp.writer eq id }">
								<form class="comment-update-form" action="private/comment_update.do" method="post">
									<input type="hidden" name="num" value="${tmp.num }" />
									<textarea name="content" class="form-control">${tmp.content }</textarea>
									<button type="submit" class="btn btn-warning">수정</button>
								</form>
							</c:if>
						</li>
					</c:otherwise>
				</c:choose>
			</c:forEach>		
		</ul>
	</div>
	
	<div class="comment_form">
	<!-- 원글에 댓글을 작성하는 form -->
		<form action="private/comment_insert.do" method="post">
			<!-- 원글의 글번호가 ref_group 번호가 된다. -->
			<input type="hidden" name="ref_group" value="${dto.num }" />
			<!-- 원글의 작성자가 댓글의 수신자가 된다. -->
			<input type="hidden" name="target_id" value="${dto.writer }"/>
			<textarea name="content" class="form-control"><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
			<button type="submit" class="btn btn-dark">등록</button>
		</form>
	</div>
	
	
</div><!-- container -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<!-- form이 ajax로 자동으로 제출 되도록 함 -->
<script>
	//댓글 수정 링크를 눌렀을 때 호출되는 함수 등록
	$(".comment-update-link").on("click", function(){
		$(this).parent().parent().parent()
		.find(".comment-update-form")
		.slideToggle();
	});
	
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정 폼을
	//ajax 요청을 통해 전송하고 응답받기
	$(".comment-update-form").ajaxForm(function(data){
		console.log(data);	
		//수정이 일어난 댓글의 li요소를 선택해서 원하는 작업을 한다.
		var selecter="#comment"+data.num; // "#comment4" 등등 형식의 선택자 구성
		
		//댓글 수정 폼을 안 보이게 한다.
		$(selecter).find(".comment-update-form").slideUp();
		//pre요소에 출력 된 내용 수정학.
		$(selecter).find("pre").text(data.content);
	});
	
	
	function deleteComment(num){
		var isDelete=confirm("댓글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+"/cafe/private/comment_delete.do?num="+num+"&ref_group=${dto.num}";
		}
		
	}
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(".reply_link").on("click", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/cafe/detail.do?num=${dto.num}";
		}
		
		$(this).parent().parent().parent().find(".comment-insert-form")
		.slideToggle();
		if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 크릭하면 
			$(this).text("답글");//답글로 바꾼다.
		}	
	});
	$(".comment_form form").on("submit", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/cafe/detail.do?num=${dto.num}";
			return false; //폼 전송 막기 		
		}
	});
	function deleteConfirm(){
		var isDelete=confirm("해당 글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="private/delete.do?num=${dto.num }"
		}
		
	}
</script>
</body>
</html>