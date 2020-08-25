<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 로딩시키기 -->
<title>/angularjs/test04.jsp</title>
<link rel="stylesheet" href="../resources/css/bootstrap.css" rel="stylesheet" />
<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
</head>
<!-- ng-app 
body에서 일어나는 일은  algular로 관리를 하겠다는 의미 -->
<body ng-app>
<div class="container mt-4">
	<h1>form 검증</h1>
	<!-- novalidate는 웹브라우저가 자체 유효성 검증을 하지 못하도록 하는 설정 -->
	<form name="myForm" action="insert.jsp" method="post" novalidate>
		<!-- 입력한 문자열을 id라는 모델명으로 관리, 반드시 입력해야한다. -->
		<input type="text" name="id" ng-model="id" ng-required="true"/>
		<p style="color:red;" ng-show="myForm.id.$invalid && myForm.id.$dirty">아이디는 반드시 입력해주세요!</p><!-- 보여줄시점을 생각하느냐 -->
		<p style="color:red;" ng-hide="myForm.id.$valid || myForm.id.$pristine">아이디는 반드시 입력해주세요!2</p><!-- 숨길 시점을 먼저 생각하느냐 -->
		<button type="submit" class="btn btn-success" ng-disabled="myForm.id.$invalid">제출</button>
	</form>
	<p>입력한 아이디 : <strong>{{id}}</strong></p>
	<p>아이디가 유효한지 여부 : <strong>{{myForm.id.$valid}}</strong></p>
	<!-- form의 name 속성, ng-model명.$유효한지여부 -->
	<p>아이디가 유효하지 않은지여부 : <strong>{{myForm.id.$invalid}}</strong></p>
	<p>아이디가 청결(순결)? 한지 여부 : <strong>{{myForm.id.$pristine}}</strong></p><!-- 청결/순결 pristine 한번도 입력한적없으면 true -->
	<p>아이디가 더럽혀졌는지 여부 : <strong>{{myForm.id.$dirty}}</strong></p><!-- 아이디는 반드시 입력하세요 같을 때 사용? -->
</div>
</body>
</html>