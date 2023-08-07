<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
<%
	String userid =(String)session.getAttribute("userid");
	if(userid == null) response.sendRedirect("/user/login");
%>
<title>회원 정보</title>
</head>
<body>

<div>
	<img id="topBanner" src="/resources/images/logo.jpg">
</div>

<div class="main">
	<h1>회원 정보</h1><br>
	<div class="boardView">
		<div class="field">아이디 : ${userinfo.userid }</div>
		<div class="field">이름 : ${userinfo.username }</div>
		<div class="field">성별 : ${userinfo.gender }</div>	
		<div class="field">취미 : ${userinfo.hobby}		</div>	
		<div class="field">직업 : ${userinfo.job }</div>	
		<div class="content"> ${userinfo.description }</div>	
	</div>
</div>
		<!-- Scripts -->
			<script src="/resources/js/css/jquery.min.js"></script>
			<script src="/resources/js/css/browser.min.js"></script>
			<script src="/resources/js/css/breakpoints.min.js"></script>
			<script src="/resources/js/css/util.js"></script>
			<script src="/resources/js/css/main.js"></script>
</body>
</html>