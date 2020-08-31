<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html ng-app="myApp">
<head>
<meta charset="UTF-8">
<title>view/users/signup_form.do</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.css" />
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/angular.min.js"></script>
<script>
	//myApp이라는 모듈 만들기
	var myApp=angular.module("myApp", []);
	//formCtrl 이라는 컨트롤러 만들기
	myApp.controller("formCtrl", function($scope, $http){//angularjs가 초기화 될 때 최초 한번만 호출된다.
		$scope.canUseId=false; //입력한 아이디가 사용 가능한지 여부
		//ng-model에 입력한 id의 값
		$scope.idChanged=function(){
			$http({
				url:"checkid.do",
				method:"get",
				params:{inputId:$scope.id}
			}).success(function(data){
				//data => {isExist:true} or {isExist:false} 인 object 이다.
				//입력한 아이디가 DB에 존재하지 않아야지 사용 할 수 있다.
				$scope.canUseId=!data.isExist;
				$scope.myForm.id.$valid= !data.isExist;//값을 강제로 집어넣을 수 있다.
				$scope.myForm.id.$invalid= data.isExist;;
			});//success 종료
		};//idChanged 종료
		//비밀번호 입력란을 입력했을 때 호출되는 함수
		//$scope.isPwdEqual=true;
		$scope.pwdChanged=function(){
			//비밀번호를 같게 입력 했는지 여부를 모델로 관리
			$scope.myForm.pwd.$valid=$scope.pwd==$scope.pwd2;//같은지
			$scope.myForm.pwd.$invalid=$scope.pwd!=$scope.pwd2;//다른지
			$scope.myForm.pwd2.$valid=$scope.pwd==$scope.pwd2;//같은지
			$scope.myForm.pwd2.$invalid=$scope.pwd!=$scope.pwd2;//다른지
		}//pwdChanged
	});//myApp.controller 종료
</script>
</head>
<body>
	<div class="container mt-4" ng-controller="formCtrl">
	<h1>회원가입폼입니다.</h1>
	<p>아이디 중복 여부 : {{canUseId}}</p>
		<form action="signup.do" method="post" id="myForm" name="myForm" novalidate>
			<div class="form-group">
				<label for="id">아이디</label>
				<input type="text" name="id" id="id" class="form-control"
					   ng-model="id"
					   ng-required="true"
					   ng-pattern="/^[a-z].{4,9}$/"
					   ng-class="{'is-invalid': myForm.id.$invalid && myForm.id.$dirty,
				   				  'is-valid': myForm.id.$valid}"
				   	   ng-change="idChanged()"
				/>
				<small class="form-text text-muted">영문자 소문자로 시작하고 최소 5글자~10글자까지 입력가능합니다.</small>
				<div class="invalid-feedback">사용 할 수 없는 아이디 입니다.</div>
				<div class="valid-feedback">사용 가능한 아이디 입니다.</div>
				<!-- <button id="checkBtn" class="btn btn-warning">중복확인</button> -->
				<!-- <span id="checkResult"></span> -->
			</div>
			<div class="form-group">
				<label for="pwd">비밀번호</label>
				<input type="password" name="pwd" id="pwd" class="form-control"
					   ng-model="pwd"
					   ng-required="true"
					   ng-minlength="5"
					   ng-maxlength="10"
					   ng-class="{'is-invalid':myForm.pwd.$invalid  && myForm.pwd.$dirty,
					   			  'is-valid':myForm.pwd.$valid}"
					   ng-change="pwdChanged()"
				/>
				<small class="form-text text-muted">최소 5글자~10글자이내로 입력하세요!</small>
				<div class="invalid-feedback">하단의 비밀번호를 확인해주세요!</div>
			</div>
			<div class="form-group">
				<label for="pwd2">비밀번호 확인</label>
				<input type="password" name="pwd2" id="pwd2" class="form-control"
					   ng-model="pwd2"
					   ng-required="true"
					   ng-minlength="5"
					   ng-maxlength="10"
					   ng-class="{'is-invalid':myForm.pwd2.$invalid && myForm.pwd2.$dirty,
					   			  'is-valid':myForm.pwd2.$valid}"
					   ng-change="pwdChanged()"
				/>
				<div class="valid-feedback">비밀번호가 동일합니다.</div>
			</div>
			<div class="form-group">
				<label for="email">이메일</label>
				<input type="text" name="email" id="email" class="form-control" 
					   ng-model="email"
					   ng-required="true"
					   ng-pattern="/@/"
					   ng-class="{'is-invalid':myForm.email.$invalid && myForm.email.$dirty,
					   			 'is-valid':myForm.email.$valid}"
				/>
				<div class="invalid-feedback">이메일 형식에 맞게 입력해주세요</div>
				<div class="valid-feedback">이메일 형식에 맞게 입력하셨습니다.</div>
			</div>
			<button type="submit" ng-disabled="myForm.$invalid || !canUseId || !isPwdEqual" class="btn btn-info">가입</button>
			<button type="reset" class="btn btn-danger">reset</button>
		</form>
	</div>
	<script>
	/*jquery로 이용 하는 법*/
	/* //아이디를 검증할 정규 표현식
	var reg_id=/^[a-z].{4,9}$/;
	//비밀번호를 검증할 정규 표현식
	var reg_pwd=/^.{5,10}$/;
	//이메일을 검증할 정규 표현식
	var reg_email=/@/;
	
	//각각의 input 요소의 유효성 여부
	var isIdValid=false;
	var isPwdValid=false;
	var isEmailValid=false;
	//폼 전체의 유효성 여부
	var isFormValid=false;
	
	$("#myForm").on("submit", function(){
		//폼 유효성 여부를 얻어낸다
		isFormValid=isIdValid && isPwdValid && isEmailValid;
		if(!isFormValid){//만일 폼이 유효하지 않으면
			return false;//폼 전송 막기 
		}
	});
		//아이디를 입력했을때 실행할 함수 등록 
		$("#id").on("input", function(){
			//입력한 아이디를 읽어온다.
			var inputId=$("#id").val();
			//아이디 형식에 맞게 입력했는지 여부
			var result=reg_id.test(inputId);
			//일단 두개의 클래스를 제거 하고 
			$(this).removeClass("is-valid is-invalid");
			if(result){//형식에 맞게 입력 했다면
				//ajax 를 이용해서 서버에 보낸후 결과를 응답 받는다.
				$.ajax({
					method:"GET",
					url:"checkid.do",
					data:"inputId="+inputId,
					success:function(data){
						$(this).removeClass("is-valid is-invalid");
						//data => {isExist:true} or {isExist:false} 인 object 이다.
						if(data.isExist){//이미 존재하는 아이디임으로 사용 불가
							isIdValid=false;
							$("#id").addClass("is-invalid");
						}else{//사용가능 
							isIdValid=true;
							$("#id").addClass("is-valid");
						}
		 			}
				});				
			}else{//형식에 맞게 입력 하지 않았다면
				isIdValid=false;
				$("#id").addClass("is-invalid");
			}
		});
		//비밀번호 입력란 혹은 비밀번호 확인란에 input이벤트 처리
		$("#pwd, #pwd2").on("input", function(){
			//입력한 비밀번호를 읽어온다.
			var inputPwd = $("#pwd").val();
			var inputPwd2 = $("#pwd2").val();
			//형식에 맞게 입력했는지 여부
			var result = reg_pwd.test(inputPwd);
			$("#pwd, #pwd2").removeClass("is-valid is-invalid");
			if(result){//형식에 맞게 입력했다면
				if(inputPwd == inputPwd2){//비밀번호 확인란과 동일하게 입력했다면
					isPwdValid=true;
					$("#pwd, #pwd2").addClass("is-valid");
				}else{//확인란과 다르게 입력했다면
					isPwdValid=false;
					$("#pwd, #pwd2").addClass("is-invalid");
				}
			}else{//형식에 맞게 입력하지 않았다면
				isPwdValid=false;
				$("#pwd, #pwd2").addClass("is-invalid");
			}
		});
		
		$("#email").on("input", function(){
			var inputEmail = $("#email").val();
			//형식에 맞게 입력했는지 여부
			isEmailValid = reg_email.test(inputEmail);
			$(this).removeClass("is-valid is-invalid");
			if(isEmailValid){
				$(this).addClass("is-valid");
			}else{
				$(this).addClass("is-invalid");
			}
		});
		//아이디 중복 확인을 통과 했는지 여부
		var canUseId = false; */
	</script>

</body>
</html>