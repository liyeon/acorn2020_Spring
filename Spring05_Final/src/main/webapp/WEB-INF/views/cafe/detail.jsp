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
	.profile-image {box-shadow: rgba(209, 209, 209, 0.68) 0px 0px 5px ;width : 50px; height :50px; text-align : center;display : inline-block;border-radius : 50%; object-fit : cover;}
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
	.insert-form {
		margin : 40px 0 100px 0;
		padding : 0 0 50px 0;
	}
	.comment-form textarea, .comment-form button
	{
		float : left;
	}
	/*.reply-icon을 li 요소를 기준으로 배치하기*/
	.comments li{
	position : relative;
	display : inline-block;
	width : 100%;
	}
	.comments ul li{
	padding : 20px 0;
	border-top : 1px solid #f1f1f1;
	}
	.comments ul li:last-child{
	border-bottom : 1px solid #f1f1f1;
	}
	.comment-form textarea{
		width : 85%;
		height : 100px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
	.comments .comment-form{
		display : none;
	}
	.comment-form button{
		width : 15%;
		height : 100px;
	}
	
	.comments .reply-icon{
		position : absolute;
		top : 20px;
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
	.comments i {
	 background : #addbc2;
	 padding : 5px 17px 5px 10px;
	 color : #fff;
	 border-radius : 10px;
	}
	.loader{
		position: fixed; /* 좌하단 고정된 위치에 배치 하기 위해 */
		width: 100%;
		left: 0;
		bottom: 0;
		text-align: center; /* 이미지를 좌우로 가운데  정렬 */
		z-index: 1000;
		display: none; /* 일단 숨겨 놓기 */
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
						<li <c:if test="${tmp.num ne tmp.comment_group }"> style="padding-left:50px"</c:if>>
						<c:if test="${tmp.num ne tmp.comment_group }"> <%--not equal --%>
							<svg viewBox="0 0 16 16" class="bi bi-arrow-return-right reply-icon" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
								<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
								<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/>
							</svg>
						</c:if>
						삭제된댓글입니다!!!!
						</li>
						
						</c:when>
					<c:otherwise>
						<li id="comment${tmp.num }" <c:if test="${tmp.num ne tmp.comment_group }"> style="padding-left:50px"</c:if>>
						<c:if test="${tmp.num ne tmp.comment_group }"> <%--not equal --%>
							
							<svg viewBox="0 0 16 16" class="bi bi-arrow-return-right reply-icon" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		  						<path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z"/>
		 						<path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z"/>
							</svg>
						</c:if>
							<dl>
								<dt>
									<c:choose>
										<c:when test="${empty tmp.profile}">
											<svg class="profile-image" width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-person-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						  						<path fill-rule="evenodd" d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
											</svg>
										</c:when>
										<c:otherwise>
											<img class="profile-image"
											src="${pageContext.request.contextPath }${tmp.profile }" />
										</c:otherwise>
									</c:choose>
									<c:if test="${tmp.num ne tmp.comment_group }">
										<i>@${tmp.target_id }</i>
									</c:if>
									<span>${tmp.writer }</span>
									<span>${tmp.regdate }</span>
									<a data-num="${tmp.num }" href="javascript:" class="reply-link">답글</a>
									<c:if test="${tmp.writer eq id }">
										<a data-num="${tmp.num }" href="javascript:" class="comment-update-link">수정</a>
										<a data-num="${tmp.num }" href="javascript:" class="comment-delete-link">삭제</a>
									</c:if>
								</dt>
								<dd>
									<pre>${tmp.content }</pre>
								</dd>
							</dl>
							<form class="comment-form re-insert-form" action="private/comment_insert.do" method="post">
								<input type="hidden" name="ref_group" value="${dto.num }"/>
								<input type="hidden" name="target_id" value="${tmp.writer }"/>
								<input type="hidden" name="comment_group" value="${tmp.comment_group }"/>
								<textarea name="content" class="form-control"></textarea>
								<button type="submit" class="btn btn-success">등록</button>
							</form>
							<!-- 로그인된 아이디와 댓글의 작성자가 같으면 수정폼 출력 -->
							<c:if test="${tmp.writer eq id }">
								<form class="comment-form update-form" action="private/comment_update.do" method="post">
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
	</div><!-- /.comments -->
	
	<div class="clearfix"></div>
	<div class="page-display mt-4 mb-4 text-center">
		<ul class="pagination" style="display : inline-flex">
		<c:if test="${startPageNum ne 1 }">
			<li class="page-item"><a class="page-link" href="detail.do?num=${dto.num }&pageNum=${startPageNum-1 }">Prev</a></li>
		</c:if>
		<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
			<c:choose>
				<c:when test="${i eq pageNum }">
					<li class="page-item active"><a class="page-link" href="detail.do?num=${dto.num }&pageNum=${i }">${i }</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="detail.do?num=${dto.num }&pageNum=${i }">${i }</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${endPageNum lt totalPageCount }">
			<li class="page-item"><a class="page-link" href="detail.do?num=${dto.num }&pageNum=${endPageNum+1 }">Next</a></li>
		</c:if>
		</ul>	
	</div><!-- page-display -->
	<hr />
	<!-- 원글에 댓글을 작성하는 form -->
	
	<form class="comment-form insert-form" action="private/comment_insert.do" method="post">
		<!-- 원글의 글번호가 ref_group 번호가 된다. -->
		<input type="hidden" name="ref_group" value="${dto.num }" />
		<!-- 원글의 작성자가 댓글의 수신자가 된다. -->
		<input type="hidden" name="target_id" value="${dto.writer }"/>
		<textarea name="content" class="form-control"<c:if test="${empty id }">readonly</c:if>><c:if test="${empty id }">로그인이 필요합니다.</c:if></textarea>
		<button type="submit" class="btn btn-dark">등록</button>
	</form>
	
	
</div><!-- container -->

<div class="loader">
	<img src="${pageContext.request.contextPath }/resources/images/ajax-loader.gif"/>
</div>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.5.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery.form.min.js"></script>
<!-- form이 ajax로 자동으로 제출 되도록 함 -->
<script>
/*
 *  문서 객체에서 click이라는 이벤트가 .comment-update-link를 가지고 있는 함수를 출력해주세요
 	추가됨과 동시에 자동으로 이벤트가 걸린다.
	 추가 한 거의 속성이.comment-update-link라면 동일한 함수를 출력해달라
	 
	동적으로 추가 된 것까지 실행하려면 .ajaxForm(form이 실행됨과 동시에 존재해야한다.)으로 하면 안되고
	ajaxSubmit을 해야 추가 된 것 까지 실행 가능하다.
	$(this).ajaxSubmit // submit이벤트가 일어난 바로 그 폼을 실행시키ㄴ다. 
	
	추후에 추가 될 것 까지 실행이 되려면 $(document).on으로 실행시켜야한다.
	나중에 추가 될 문서객체에도 자동으로 이벤트가 걸린다.
	
 */
	//댓글 수정 링크를 눌렀을 때 호출되는 함수 등록
	$(document).on("click",".comment-update-link", function(){
		/*
			click 이벤트가 일어난 댓글 수정 링크에 저장된 data-num 속성의 값을 읽어와서
			id선택자를 구성한다.
		*/
		var selector="#comment"+$(this).attr("data-num");
		//구성된 id 선택자를 이용해서 원하는 li요소에서 .update-form을 찾아서 동작하기
		$(selector)
		.find(".update-form")
		.slideToggle();
	});
	
	//로딩한 jquery.form.min.js jquery플러그인의 기능을 이용해서 댓글 수정 폼을
	//ajax 요청을 통해 전송하고 응답받기
	$(document).on("submit", ".update-form", function(){
		//이벤트가 일어난 폼을 ajax로 전송되도록 하고 
		$(this).ajaxSubmit(function(data){ //ajax의 동작을 data로 받아온다. form이 아닌 Submit형태로 받아온다.
			//console.log(data);
			//수정이 일어난 댓글의 li 요소를 선택해서 원하는 작업을 한다.
			var selector="#comment"+data.num; //"#comment6" 형식의 선택자 구성
			
			//댓글 수정 폼을 안보이게 한다. 
			$(selector).find(".update-form").slideUp();
			//pre 요소에 출력된 내용 수정하기
			$(selector).find("pre").text(data.content);
		});
		//폼 전송을 막아준다.
		return false;
	});
	
	
	$(document).on("click",".comment-delete-link", function(){
		//삭제할 글번호 
		var num=$(this).attr("data-num");
		var isDelete=confirm("댓글을 삭제하시겠습니까?");
		if(isDelete){
			location.href="${pageContext.request.contextPath }"+"/cafe/private/comment_delete.do?num="+num+"&ref_group=${dto.num}";
		}
		
	});
	//답글 달기 링크를 클릭했을때 실행할 함수 등록
	$(document).on("click",".reply-link", function(){
		//로그인 여부
		var isLogin=${not empty id};
		if(isLogin == false){
			alert("로그인 페이지로 이동합니다.")
			location.href="${pageContext.request.contextPath }/users/loginform.do?"+
					"url=${pageContext.request.contextPath }/cafe/detail.do?num=${dto.num}";
		}
		
		var selector="#comment"+$(this).attr("data-num");
		$(selector)
		.find(".re-insert-form")
		.slideToggle();
		
		if($(this).text()=="답글"){//링크 text를 답글일때 클릭하면 
			$(this).text("취소");//취소로 바꾸고 
		}else{//취소일때 크릭하면 
			$(this).text("답글");//답글로 바꾼다.
		}	
	});
	$(document).on("submit",".insert-form", function(){
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