<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판|비밀번호 변경</title>
<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
  <style>
       input[type="text"],
       input[type="password"] {
           text-decoration: none;
           color: #585858;
           cursor: pointer;
           display: inline-block;
           font-size: 0.8em;
           font-weight: 300;
           position: relative;
           width: 600px;
       }

       p {
           color: #ee5f81;
           text-align: center;
           font-size: 16px;
       }
       
    input[type="checkbox"] + label,
	input[type="radio"] + label {
		text-decoration: none;
		color: #585858;
		cursor: pointer;
		display: inline-block;
		font-size: 0.9em;
		font-weight: 300;
		padding-left: 2.55em;
		padding-right: 0.75em;
		position: relative;
	}
	select {
		font-size: 0.7em;
	}
	textarea{
		border: solid 1px #c9c9c9;
	}
	textarea:focus {
		border-color: #f2849e;
		box-shadow: inset 0 -1px 0 0 #f2849e;
	}

   </style>
</head>
<script src="/resources/js/user/setpw.js"></script>
<body>
 
<h1>변경할 비밀번호를 입력하세요.</h1>

	<div id="dataForm">
	    비밀번호<br>
	    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요.">
	    <p id="checkPW"></p><br>
	    비밀번호확인<br>
	    <input type="password" id="password1" name="password1" placeholder="비밀번호를 다시 한 번 입력해 주세요.">
	    <p id="checkPW1"></p><br>
		<input type="hidden" id="userid" value = "${userid }">
		<input type="button" class = "button primary" id="btn_setpw" value="변경 하기"> 
		<input type="button" class = "button" id="btn_cancle" value="변경 취소">
	</div>
		<!-- Scripts -->
			<script src="/resources/js/css/jquery.min.js"></script>
			<script src="/resources/js/css/browser.min.js"></script>
			<script src="/resources/js/css/breakpoints.min.js"></script>
			<script src="/resources/js/css/util.js"></script>
			<script src="/resources/js/css/main.js"></script>

</body>
</html>