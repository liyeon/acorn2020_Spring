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
				   'is-valid': myForm.id.$valid}"
				   />
				   <!-- true or false -->
			<div class="invalid-feedback">아이디는 반드시 입력하세요</div>
			<div class="valid-feedback">아이디를 입력하셨군요!</div>
		</div>
		<div class="form-group">
			<label for="nick">닉네임</label>
			<input ng-model="nick" ng-required="true"
				   type="text" name="nick" id="nick" class="form-control" 
				   ng-class="{'is-invalid': myForm.nick.$invalid && myForm.nick.$dirty,
				   			  'is-valid': myForm.nick.$valid}"
				   ng-minlength="3"
				   ng-maxlength="10"
				   ng-pattern="/^[가-힇]+$/"
				   />
			<div class="invalid-feedback">한글로만 3글자~10글자 이내로입력해야합니다.</div>
			<div class="valid-feedback">3글자~10글자 이내로 입력하셨습니다.</div>
		</div>		
		<button type="submit" class="btn btn-outline-success" ng-disabled="myForm.$invalid">제출</button>
	</form>
	<p>입력한 아이디 : <strong>{{id}}</strong></p>
	<p>아이디가 유효한지 여부 : <strong>{{myForm.id.$valid}}</strong></p>
	<!-- form의 name 속성, ng-model명.$유효한지여부 -->
	<p>아이디가 유효하지 않은지여부 : <strong>{{myForm.id.$invalid}}</strong></p>
	<p>아이디가 청결(순결)? 한지 여부 : <strong>{{myForm.id.$pristine}}</strong></p><!-- 청결/순결 pristine 한번도 입력한적없으면 true -->
	<p>아이디가 더럽혀졌는지 여부 : <strong>{{myForm.id.$dirty}}</strong></p><!-- 아이디는 반드시 입력하세요 같을 때 사용? -->
	
	<p>입력한 닉네임 : <strong>{{nick}}</strong></p>
	<p>닉네임이 유효한지 여부 : <strong>{{myForm.nick.$valid}}</strong></p>
	<!-- form의 name 속성, ng-model명.$유효한지여부 -->
	<p>닉네임가 유효하지 않은지여부 : <strong>{{myForm.nick.$invalid}}</strong></p>
	<p>닉네임가 청결(순결)? 한지 여부 : <strong>{{myForm.nick.$pristine}}</strong></p><!-- 청결/순결 pristine 한번도 입력한적없으면 true -->
	<p>닉네임가 더럽혀졌는지 여부 : <strong>{{myForm.nick.$dirty}}</strong></p><!-- 아이디는 반드시 입력하세요 같을 때 사용? -->
	
	<p>닉네임을 입력 안 했는지 여부 : <strong>{{myForm.nick.$error.required}}</strong></p>
	<p>닉네임을 입력했는지 여부 : <strong>{{!myForm.nick.$error.required}}</strong></p>
	<p>닉네임을 최소 글자 이상 입력 안 했는지 여부 : <strong>{{myForm.nick.$error.minlength}}</strong></p>
	<p>닉네임을 최소 글자 이상 입력 했는지 여부 : <strong>{{!myForm.nick.$error.minlength}}</strong></p>
	<p>닉네임을 최대 글자 이하로 입력 안 했는지 여부 : <strong>{{myForm.nick.$error.maxlength}}</strong></p>
	<p>닉네임을 최대 글자 이하로 입력 했는지 여부 : <strong>{{!myForm.nick.$error.maxlength}}</strong></p>
	<p>닉네임을 정규표현식에 맞게 입력 안 했는지 여부 : 
		<strong>{{myForm.nick.$error.pattern}}</strong>
	</p>
	<p>닉네임을 정규표현식에 맞게 입력 했는지 여부 : 
		<strong>{{!myForm.nick.$error.pattern}}</strong>
	</p>
	
	<p>폼 전체의 유효성 여뷰 : <strong>{{myForm.$valid}}</strong></p>
	<p>폼 전체의 유효하지 않은지 : 여뷰 <strong>{{myForm.$invalid}}</strong></p>
</div>
</body>
</html>