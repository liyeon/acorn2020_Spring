<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/angularjs/test10.jsp</title>
<!-- 부트스트랩 로딩시키기 -->
<link rel="stylesheet" href="../resources/css/bootstrap.css" rel="stylesheet" />
<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
</head>
<body ng-app>
	<div class="container mt-4">
		<h1>과일을 선택하세요</h1>
		<select ng-model="selectedFruit"
				ng-change="selectedFruit2=selectedFruit"
				class="form-control mb-4">
			<option value="">선택</option>
			<option value="orange">오렌지</option>
			<option value="apple">사과</option>
			<option value="banana">바나나</option>
			<option value="kiwi">키위</option>
			<option value="peach">복숭아</option>
		</select>
		<p>선택된 과일 : <strong ng-bind="selectedFruit"></strong></p>
		
		<select ng-model="selectedFruit2" class="form-control mb-4">
			<option value="">선택</option>
			<option value="orange">오렌지</option>
			<option value="apple">사과</option>
			<option value="banana">바나나</option>
			<option value="kiwi">키위</option>
			<option value="peach">복숭아</option>
		</select>
		<h1>체크박스를 테스트 해보세요</h1>
		
		<label>
			<input type="checkbox" ng-model="isShow"/> isShow
		</label>
		<label>
			<input type="checkbox" ng-model="isMake"/> isMake
		</label>
		<!-- 문서 객체를 보이고 숨기고를 조작하는 지시어는 ng-show -->
		<p ng-show="isShow">안녕하세요!</p><!-- 만들어져있고 css 클래스가 추가 되는 것으로 나타남 -->
		<!-- 문서객체를 동적으로 만들고 제거하고를 조작하는 지시어는 ng-if  -->
		<p ng-if="isMake">또 만났네용!</p><!-- 없는 것을 동적으로 요소객체를 만들어서 넣고 제거한다.-->
	</div>
</body>
</html>