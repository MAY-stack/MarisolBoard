<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 | 회원 등록</title>
<link rel="stylesheet" href="/resources/css/board.css">	<!-- CSS stylesheet 적용 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 사용 -->
<script>
/*****************************아이디 중복 확인**************************/
$(document).ready(function(){
	$("#userid").change(function(){
		$.ajax({
			url : "/user/idCheck",
			type : "post",
			data : {"userid" : $("#userid").val()},
			success : function(data){
					if(data != 0){
						$("#checkID").html("동일한 아이디가 이미 존재합니다. <br> 새로운 아이디를 입력하세요.");
						$("#userid").val("").focus();
					}else $("#checkID").html("사용 가능한 아이디입니다.");
				}
		});
	});
});

/*****************************체크박스 모두 선택 처리**************************/
function selectAll(checkElement) {		 
	const checkboxes = document.getElementsByName("hobbies");
	checkboxes.forEach((checkbox) => {
		checkbox.checked = checkElement.checked;
	});
}
</script>
</head>
<body>
	<h1>🌈MODoo BOARD📋</h1>

<div class="main">	
	<h2>사용자 등록</h2><br>
	<div class="WriteForm"> 
		<form id="RegistryForm" name="RegistryForm" method="POST">	<!-- 회원 등록 Form -->
			<input type="text" class="input_field" id="userid" name="userid" placeholder="사용할 아이디를 입력하세요.">
				<p id="checkID" style="color:red;text-align:center;font-size: 15px;"></p>	<!-- 아이디 중복 여부 확인 결과 -->
			<input type="password" class="input_field" id="password" name="password" placeholder="비밀번호를 입력해 주세요.">
			<input type="password" class="input_field" id="password1" name="password1" placeholder="비밀번호를 다시 한 번 입력해 주세요.">
			<input type="text" class="input_field" id="username" name="username" placeholder="이름을 입력해 주세요.">
			<div style="width:90%; text-align:left; position:relative; left:35px; border-bottom:2px solid #adadad; margin:10px; padding:10px">
				성별 : 
				<label><input type="radio" name="gender" value="남성">남성</label><!-- label: 옆에 글자를 클릭해도 체크 표시됨 -->
				<label><input type="radio" name="gender" value="여성">여성</label><br>
				취미 :
				<label><input type="checkbox" id="all" name="all" onclick="selectAll(this)">전체선택</label>
				<label><input type="checkbox" name="hobbies" value="음악감상">음악감상</label>
				<label><input type="checkbox" name="hobbies" value="영화보기">영화보기</label>
				<label><input type="checkbox" name="hobbies" value="스포츠">스포츠</label><br>
				직업 :
				<select name="job">
					<option disabled selected>-- 아래의 내용 중에서 선택</option>
					<option value="회사원">회사원</option>
					<option value="공무원">공무원</option>
					<option value="자영업">자영업</option>
				</select><br>
			</div><br>
			<textarea class="input_content" id="content" cols="100" rows="300" name="description" placeholder="자기소개를 입력해주세요."></textarea><br>
			<input type="button" class="btn_write" value="뒤로가기" onclick="history.back()">
			<input type="button" class="btn_write" value="사용자 등록" onclick="register()">
		</form><!-- 회원 등록 Form End-->	
	</div><!-- div "WriteForm" End-->
</div><!-- main div End -->

<script>
/****************회원가입 처리 요청*******************/
function register() {		
	/*********************입력 정보 유효성 검사*******************/
	//아이디 입력 여부
	if($("#userid").val() == '') { alert("아이디를 입력하세요."); $("#userid").focus();  return false; }
	//사용자이름 입력 여부
	if($("#username").val() == '') { alert("이름을 입력하세요."); $("#username").focus(); return false; }
	//비밀번호
	var Pass = $("#password").val();	
	var Pass1 = $("#password1").val();
		//비밀번호 입력 여부
		if(Pass == '') { alert("암호를 입력하세요."); $("#password").focus(); return false; }
		if(Pass1 == '') { alert("암호를 입력하세요."); $("#password1").focus(); return false; }
		//비밀번호 - 비밀번호확인 일치 여부
		if(Pass != Pass1) 		
			{ alert("입력된 비밀번호를 확인하세요"); $("#password1").focus(); return false; }	

	// (비밀번호) 암호유효성 검사(자바스크립트의 정규식)
	var num = Pass.search(/[0-9]/g); 	// [0~9] : 0~9까지의 숫자가 들어 있는지 검색 -> 검색되지 않으면 -1 반환, g : 글로벌 검색
 	var eng = Pass.search(/[a-z]/ig); 	//i : 알파벳 대소문자 구분 없이 검색 -> 검색되지 않으면 -1 반환
 	var spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); //특수문자가 포함되어 있는지 검색
	if(Pass.length < 8 || Pass.length > 20) { alert("암호는 8자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(Pass.search(/\s/) != -1){ alert("암호는 공백 없이 입력해주세요."); return false; }
	else if(num < 0 || eng < 0 || spe < 0 ){ alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."); return false; }
 	 	
	/*********************유효성 검사 후 처리요청 submit*******************/
 	$("#RegistryForm").attr('action', '/user/signup').submit();
}
</script>
</body>
</html>