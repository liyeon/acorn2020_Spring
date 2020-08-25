<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 부트스트랩 로딩시키기 -->
<title>/angularjs/test05.jsp</title>
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
		<div class="form-group">
			<label for="id">아이디</label>
			<input ng-model="id" ng-required="true"
				   type="text" name="id" id="id" class="form-control"
				   ng-class="{'is-invalid': myForm.id.$invalid && myForm.id.$dirty,
				   'is-valid': myForm.id.$valid}"/>
			<div class="invalid-feedback">아이디는 반드시 입력하세요</div>
			<div class="valid-feedback">아이디를 입력하셨군요!</div>
		</div>
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