<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html ng-app="myApp">  
<head>
<meta charset="UTF-8">
<title>/angularjs/test08.jsp</title>
<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
<script>
	// myApp 이라는 이름의 모듈 만들기
	var myApp=angular.module("myApp", []);
	//모듈을 이용해서 one이라는 이름의 컨트롤러 만들기
	myApp.controller("one", function($scope, $http){
		//$http는 서버와 통신을 할 수 있는 함수.
		console.log($http);
			//{}함수에 오브젝트를 전달 할 때 사용한다. 함수이기ㅒ때문에 인자로 오브젝트{}를 받음
			//전송 버튼을 눌렀을때 호출되는 함수 
			$scope.send=function(){
				$http({
					url:"send.jsp",
					method:"post",
					params:{msg:$scope.msg},//직렬화 한다.//msg라는 파라미터 명으로 입력한 문자열을 읽어온다. 파라미터 명, 파라미터 value
					headers:{"Content-Type":"application/x-www-form-urlencoded;charset=utf-8"}
				}).success(function(data){
					//data : {toClient:"hello"}구조의 Object이다.
					console.log(data);//성공 했을 때 실행 할 함수
					$scope.result=data.toClient;
				});
			};
			
			$scope.send2=function(){
				$http({
					url:"send.jsp",
					method:"get",
					params:{msg:$scope.msg2},
				}).success(function(data){
					//data : {toClient:"hello"}구조의 Object이다.
					console.log(data);//성공 했을 때 실행 할 함수
					$scope.result2=data.toClient;
				});
			};
	});
</script>
</head>
<body ng-controller="one">
	<h3>$http 서비스 테스트</h3>
		<input type="text" ng-model="msg" placeholder="서버에 할 말 입력"/>
		<button ng-click="send()">Ajax 전송(post)</button><!-- $scope.send() -->
		<p ng-bind="result"></p>
		
		<input type="text" ng-model="msg2" placeholder="서버에 할 말을 입력해주세요!2" />
		<button ng-click="send2()">Ajax 전송(get)</button>
		<p ng-bind="result2"></p>
</body>
</html>