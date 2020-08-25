<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 로딩시키기 -->
<title>/angularjs/test03.jsp</title>
<link rel="stylesheet" href="../resources/css/bootstrap.css" rel="stylesheet" />
<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
</head>
<!-- ng-app 
body에서 일어나는 일은  algular로 관리를 하겠다는 의미 -->
<body ng-app>
<div class="container mt-4">
	<h1 ng-init="a='btn-warning'">클래스 속성 조작하기</h1>
	<input type="text" ng-model="b" class="form-control mb-2"/><br/>
	<button class="btn btn-primary">버튼1</button>
	<button class="btn {{a}}">버튼2</button>
	<button class="btn {{b}}">버튼3</button>
	<button ng-class="['btn', 'btn-danger']">버튼4</button><!-- 배열형태 -->
	<!-- 속성을 추가 할지말지 boolean type으로 관리한다. -->
	<button ng-class="{'btn':true, 'btn-primary':true}">버튼5</button><!-- 오브젝트 형태 -->
	<br />
	<br />
	<input type="checkbox" ng-model="isLarge"/>
	<button class="btn btn-success" ng-class="{'btn-lg':isLarge}">버튼</button>
</div>
</body>
</html>