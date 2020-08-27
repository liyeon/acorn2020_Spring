<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/angularjs/test02.jsp</title>
<!-- angularjs 로딩시키기 
클라이언트 사이드에서 조작이 일어나는 것
-->
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/angular.min.js"></script>
</head>
<!-- ng-app 
body에서 일어나는 일은  algular로 관리를 하겠다는 의미 -->
<body ng-app><!-- angular로 관리하는 영역 -->
<!-- ng-init(초기화)는 count라는 이름의 모델을 만들고 초기값을 0으로 부여하겠다. -->
<h1 ng-init="count=0">이벤트 처리</h1>
<!-- var count=0; {count:0} angular가 관리하는 object에 count라는 방을 만들고 0이라는 초기값을 부여한것-->

<!--버튼에 클릭 이벤트가 일어나면 count=count+1이 수행된다.--><!-- 이벤트가 일어나는 요소에 직접 지시어를 써놓는다. -->
<button ng-click="count=count+1">눌러보거라</button><!-- controller가 관리하는 $scope영역이라고 보면 된다. -->
<button ng-click="count=0">리셋</button>
<button ng-click="count=count-1">눌러보거라2</button>
<!-- 모델값이 바뀌면 view에 자동 반영 -->
<!-- count모델 안에 있는 값을 출력하기 -->
<p>{{count}}</p><!-- 더블 브레이스라고 함-->
<p ng-bind="count"></p><!-- 위와 아래는 동일한 코드 ng-bind는 count라는 방에 있는 값을 inner text로 출력을 하겠다. -->
</body>
</html>