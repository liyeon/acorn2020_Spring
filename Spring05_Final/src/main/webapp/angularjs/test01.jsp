<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/angularjs/test01.jsp</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/angular.min.js"></script>
</head>
<body ng-app>
	<h1>hello angular js!</h1>
	<!-- 
		model은 데이터의 의미를 가진다. 
		angularjs는 연결 된 것 처럼 동작을 시킬 수 있다.
		데이터는 화면에 화면은 데이터에 양방향으로 연결되어있다.
		model은 view에 view는 model에
		mvvm framework라고도 한다.
	-->
	<input ng-model="msg" type="text" placeholder="메세지를 입력해주세요!" />
	<p>{{msg}}</p>
	<!-- 
	javascript로만 입력 했을 때
	document.querySelector().addEventListener("input",
		function(){
			var mag=xxx;
			document.querySelector().innerText=msg;
		}
		);
	 -->
	 <!--
	 angularjs가 클라이언트 화면에서 인식 되는 것이다
	  페이지 소스보기에서는 최초로 응답받은 코드만 출력한다.
	  응답 되고 난 후 그 다음에 조절이된다. 
	  웹브라우저가 해석하는 자바스크립트.
	  ng- 는 디렉티브(지시어)라고 한다.
	  다양한 지시어를 익히고 지시어의 사용법을 익히면 된다.
	  ng-model
	  체크박스는 boolean타입으로 관리가 된다.
	 
	 -->
	<h1 ng-init="friends=['김구라','해골','원숭이']">친구 목록 입니다!</h1>
	<ul>
		<li ng-repeat="tmp in friends">{{tmp}}</li>
	</ul>
	
	<h1>체크 박스를 체크해보세요</h1>
	<!-- 체크했는지의 여부를 isShow라는 모델 명으로 관리하겠다.보일지 가릴지의 여부 -->
	<input type="checkbox" ng-model="isShow" /> <strong>{{isShow}}</strong> <br/>
	<img src="../resources/images/puff5.png" ng-show="isShow" />
	<!-- 조건부로 보이게 할것인지 말것인지 ng-hide라는class가 추가된다. -->
	
</body>
</html>