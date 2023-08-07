<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 세션 확인 -->
<% 	String userid = (String)session.getAttribute("userid");
		if (userid != null) response.sendRedirect("/board/list");	%>
<!DOCTYPE html>
<html>
<head>
<title>게시판 | 로그인</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 사용 -->
<script src="/resources/js/user/login.js"></script>
<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
</head>
<style>
	input[type="text"],
	input[type="password"]{
		text-decoration: none;
		color: #585858;
		cursor: pointer;
		display: inline-block;
		font-size: 0.8em;
		font-weight: 300;
		position: relative;
		width:500px;
	}
	
	input[type="checkbox"] + label,
	input[type="radio"] + label {
		text-decoration: none;
		color: #585858;
		cursor: pointer;
		display: inline-block;
		font-size: 0.7em;
		font-weight: 300;
		padding-left: 2.55em;
		padding-right: 0.75em;
		position: relative;
	}
	
	p {
            color: #ee5f81;
            text-align: center;
            font-size: 16px;
        }
	
	a {
		font-size: 0.8em;
	}
</style>
<body>
	<h1 align="center">🌈BOARD📋</h1>
<div class="main" align="center">
	<div class="login_div">
		<h2>로그인</h2>
		<form class="login_form" name="loginForm" id="loginForm" method="post" > 
			<p><input type="text" name="userid" id="userid" class="input_login_data" placeholder="아이디"></p>
         	<p><input type="password" id="password" name="password" class="input_login_data"
         			placeholder="비밀번호"></p>
         	<p id="checkID"></p> 
			<div class="col-6 col-12-small" >
				<input type="checkbox" id="rememberUserId" name="save_id">
				<label for="rememberUserId" >아이디 저장</label>
				<input type="checkbox" id="rememberPassword" name="save_password">
				<label for="rememberPassword" >비밀번호 저장</label>
				<input type="checkbox" id="rememberMe" name="auto_login">
				<label for="rememberMe">자동 로그인</label>
			</div><br>
     		<!-- 아이디 비밀번호 저장, 자동 로그인 선택 영역 End-->
     		<input type="button" id="btn_login" value="로그인" class="button primary" style="width:500px;">
		</form>
		<div class="bottomText">
			<a href="/user/signup">회원가입</a> | <a href='/user/find'>아이디·비밀번호 찾기</a>
    	</div>
	</div> <!-- loginBox div End -->
</div> <!-- main div End -->
</body>
</html>