<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/angularjs/test11.jsp</title>
<!-- 부트스트랩 로딩시키기 -->
<link rel="stylesheet" href="../resources/css/bootstrap.css" rel="stylesheet" />

<!-- angularjs 로딩시키기 -->
<script type="text/javascript" src="../resources/js/angular.min.js"></script>
<script>
	var myApp=angular.module("myApp", []);
	myApp.controller("msgCtrl", function($scope){
		//페이지가 로딩 되는 시점에 msgs라는 모델을 정의하고 배열 저장하기
		$scope.msgs=[{msg:"하나"},{msg:"두울"}];
		//페이지가 로딩되는 시점에 send라는 함수 정의하기
		$scope.send=function(){
			//msgs 배열에 새로운 object를 만들어서 저장하기(view에 자동 반영된다.)
			$scope.msgs.push({msg:$scope.inputMsg});
			$scope.inputMsg="";
		};
		
		//ajax 통신으로 받아온 데이터라고 가정하자
		//핸드폰 목록을 담을 배열
		$scope.phones=[];
		//전화기 목록을 얻어오는 함수
		$scope.getPhones=function(){
			$scope.phones.push({name:"아이폰 6",snippet:"가볍고 이쁜 폰입니다.",price:80});
			$scope.phones.push({name:"겔럭시 S5",snippet:"삼성에서 만든 방수폰 입니다.",price:110});
			$scope.phones.push({name:"Nexus 6",snippet:"Google 테블릿 입니다.",price:65});
			$scope.phones.push({name:"옵티머스 G",snippet:"LG 핸드폰 입니다.", price:80});
		};
		
		
		$scope.table=[{num:1, name:"김탱구", addr:"탱구좋아욤"}]
		$scope.sendTable=function(){
			$scope.table.push({num:$scope.inputNum,name:$scope.inputName,addr:$scope.inputAddr});
			$scope.inputNum="";
			$scope.inputName="";
			$scope.inputAddr="";  
		};
	});
</script>
</head>
<body ng-app="myApp">
	<div class="container mt-4" ng-controller="msgCtrl">
		<div class="form-group form-row">
			<input type="text" ng-model="inputMsg" placeholder="메세지를 입력하세요" class="form-control col-md-10"/>
			<button ng-click="send()" class="btn btn-info col-md-2">전송</button>
		</div>
		
		<ul>
			<li ng-repeat="tmp in msgs">{{tmp.msg}}</li>
		</ul>
		
		<h3>전화기 목록입니다.</h3>
		<button ng-click="getPhones()" class="btn btn-dark">목록 받아오기</button>
		<table class="table table-hover mt-4">
			<tr class="bg-warning">
				<th>이름</th>
				<th>설명</th>
				<th>가격</th>
			</tr>
			<tr ng-repeat="tmp in phones | filter:keyword | orderBy:orderValue : isReverse"><!-- 역순으로 하고 싶으면 true를 넣으면 된다. -->
				<td ng-bind="tmp.name"></td>
				<td ng-bind="tmp.snippet"></td>
				<td ng-bind="tmp.price"></td>
			</tr>
		</table>
		
		
		
		<div class="form-row">
			<input type="text" placeholder="검색어를 입력해주세요!" class="form-control col-md-7 mr-auto" ng-model="keyword"/>
			<select ng-model="orderValue" class="form-control col-md-5"><!-- 정렬값 -->
				<option value="">정렬</option>
				<option value="name">이름</option>
				<option value="price">가격</option>
			</select>
		</div>
			
			<label>
				<input type="checkbox" ng-model="isReverse"/>역순
			</label>
			<p>입력한 검색어 : <strong>{{keyword}}</strong></p>
			<p>정렬 방식 : <strong>{{orderValue}}</strong></p>
		
		<div class="form-group form-row mt-4">
			<input type="text" ng-model="inputNum" placeholder="번호를 입력하세요" class="form-control col-md-3 mr-auto"/>
			<input type="text" ng-model="inputName" placeholder="이름를 입력하세요" class="form-control col-md-4 mr-auto"/>
			<input type="text" ng-model="inputAddr" placeholder="주소를 입력하세요" class="form-control col-md-4"/>
			<button ng-click="sendTable()" class="btn btn-info">전송</button>
		</div>
		
		
		<table class="table table-warning">
			<tr class="bg-warning">
				<th>번호</th>
				<th>이름</th>
				<th>주소</th>
			</tr>
			<tr ng-repeat="tmp in table">
				<td>{{tmp.num}}</td>
				<td>{{tmp.name}}</td>
				<td>{{tmp.addr}}</td>
			</tr>
		</table>
		
	</div>
</body>
</html>