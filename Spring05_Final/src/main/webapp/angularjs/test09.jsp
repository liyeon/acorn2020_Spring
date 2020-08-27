<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html ng-app="myApp">
<head>
<meta charset="UTF-8">
<title>/angularjs/test09.jsp</title>
<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
<script>
	// myApp 이라는 이름의 모듈 만들기
	var myApp=angular.module("myApp", []);
	//모듈을 이용해서 one이라는 이름의 컨트롤러 만들기
	myApp.controller("one", function($scope, $http){
		//폼에 입력한 내용을 담을 모델
		$scope.formData={};
		
		//$http는 서버와 통신을 할 수 있는 함수.
		console.log($http);
			//전송 버튼을 눌렀을때 호출되는 함수 
			$scope.send=function(){
				$http({
					url:"member_insert.jsp",
					method:"post",
					params:$scope.formData,
					headers:{"Content-Type":"application/x-www-form-urlencoded;charset=utf-8"}
				}).success(function(data){
					console.log(data);
				});//success
			};//send
			
	});//
</script>
</head>
<body ng-controller="one">
	<h3>$http 서비스 테스트</h3>
	<form ng-submit="send()"><!-- 특정 폼에 있는 것을 ajax전송 하는 방법 -->
		이름 <input type="text" ng-model="formData.name" />
		주소 <input type="text" ng-model="formData.addr"/>
		<button type="submit">전송</button>
	</form>
	<p>{{formData}}</p><!-- 오브젝트를 문자열화해서 보여준다. ng-bind는  -->
</body>
</html>