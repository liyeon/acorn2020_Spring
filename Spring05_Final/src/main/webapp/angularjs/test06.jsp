<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/angularjs/test056.jsp</title>
<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
<script>
	//"myApp"이라는 이름의 모듈 만들기
	var myApp=angular.module("myApp", []);
	//모듈을 이용해서 myCtrl이라는 이름의 컨트롤러 만들기
	myApp.controller("myCtrl", function($scope){
		/*
			- 이 함수는 페이지가 로딩되는 시점에 최초 한번 호출된다.
			- $scope 에는 angular가 관리하는 특별한 객체가 전달된다.
			- $scope는 해당 컨트롤렁서 사용하는 영역객체이다.
			- $scope 에는 각각의 컨트롤러에서 사용하는 모델(데이터)가 저장된다.
		*/
		console.log("myCtrl에 있는 함수 호출됨.");
		console.log($scope);
		//$scope object에 nick이라는 방(모델)을 만들고 문자열 저장하기
		$scope.nick="김구라";
		// $scope object에 btnClicked라는 방에 함수 저장하기
		$scope.btnClicked=function(){
			alert("버튼을 눌렀습니다.");
		};
	});
	// 모듈을 이용해서 yourCtrl 이라는 이름의 컨트롤러 만들기
	myApp.controller("yourCtrl", function($scope){
		console.log("yourCtrl에 있는 함수 호출됨.");
		console.log($scope);
		$scope.nick="해골";
		$scope.onMouseover=function(){
			alert("마우스를 올렸습니다.");
		};
	});
</script>
</head>
<body ng-app="myApp">
	<div ng-controller="myCtrl">
		<h3>myCtrl 컨트롤러가 관리하는 영역</h3>
		<p>별명 : <strong>{{nick}}</strong></p>
		<button ng-click="nick='개구라'">눌러보거라</button><!-- $scope.nick='xxx'scope의 nick이라는 방에 문자열을 바꿨음 --> 
		<button ng-click="btnClicked()">눌러보셈2</button><!-- $scope에 있는 btnClicked()라는 함수를 콜(호출) 하는것이다. -->
	</div>
	<div ng-controller="yourCtrl">
		<h3>yourCtrl 컨트롤러가 관리하는 영역</h3>
		<p>별명 : <strong ng-bind="nick"></strong></p>
		<button ng-click="nick='원숭이'">눌러보거라</button>
		<button ng-mouseover="onMouseover()">마우스를 올려 보거라</button>
		<!-- mouseout, mousemove, focus, blur, change, input 등등 -->
	</div>
</body>
</html>