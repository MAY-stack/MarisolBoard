<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<!DOCTYPE html>
<%  
	String userid = (String)session.getAttribute("userid");
	String tempPw = (String)session.getAttribute("tmepPw");
%>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
	<script src="/resources/js/board/list.js"></script>
			<!-- Scripts -->
	<script src="/resources/js/css/jquery.min.js"></script>
	<script src="/resources/js/css/browser.min.js"></script>
	<script src="/resources/js/css/breakpoints.min.js"></script>
	<script src="/resources/js/css/util.js"></script>
	<script src="/resources/js/css/main.js"></script>
	<title>비밀번호 변경 주기 알림</title>
	<style>
		a {
			transition: border-bottom-color 0.2s ease, color 0.2s ease;
			text-decoration: none;
			color: #585858;
			border-bottom: none;
		}
	</style>
</head>

<body class="is-preload">
		<!-- Header -->
		<header id="header">
			<div class="inner">

				<!-- Logo -->
				<a href="/;" class="logo">
					<span class="title">🌈MarisolBoard📋</span>
				</a>


			</div>
		</header>

		</header>
		<!-- Menu -->
		<nav id="menu">
		<h2>Menu</h2>
			<ul>
				<li><a href="/">Home</a></li>
				<li><a href="/board/list">Board</a></li>
				<li><a href="/board/write">Write</a></li>
				<li><a href="/user/mypage?userid=<%=userid%>">Mypage</a></li>
				<li><a href="/user/login">Login</a></li>
				<li onclick="logout()"><a href="#">Logout</a></li>
				<c:if test="${role =='MASTER' }">
					<li><a href="/master/sysmanage">Master</a></li>
				</c:if>
<!-- 						<li><a href="elements.html">////</a></li> -->
			</ul>
		</nav>
			<!-- Main -->
<div id="main">

			<header>
				<h2 align="center">비밀번호를 변경하세요.</h2>
<!-- 				<p> Welcome to Marisol Board. Etiam quis viverra lorem, in semper lorem. Sed nisl arcu euismod sit amet nisi euismod sed cursus arcu elementum ipsum arcu vivamus quis venenatis orci lorem ipsum et magna feugiat veroeros aliquam. Lorem ipsum dolor sit amet nullam dolore.</p> -->
			</header>
	<div class="inner" align="center">
	<c:set var="tempPw" value="<%=tempPw%>" />
		<c:if test="${ tempPw eq 'Y' }">
			<a href="#">시스템 관리</a>&nbsp;
		</c:if>
		<h3 style="text-aliagn:center;">비밀번호를 변경한지 30일이 지났습니다.<br>정보 보호를 위해 비밀번호를 변경해주세요.</h3><br>
	<a class="button primary" href="/user/pwCheck?userid=<%=userid%>">지금 변경하기</a>
	<a class="button" href="/user/pwextend">다음에 알리기</a>
	</div>
</div>
</body>
</html>