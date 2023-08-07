<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- 세션 확인 -->
<% 	String userid = (String)session.getAttribute("userid");
		if (userid != null) response.sendRedirect("/board/list");	%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.0.0/crypto-js.min.js"></script>
	<title> 로그인 | MARISOLBOARD</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css">	<style>
		table {
			width: 800px;
		}

		table tbody tr {
			border: none;
		}

		table tbody tr:nth-child(2n + 1) {
			background-color: white;
		}

		p {
			color: #ee5f81;
			text-align: center;
			font-size: 16px;
		}

		td:nth-child(1) {
			width: 25%;
			font-weight: 800;
		}
		
	</style>
</head>

<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header" style="padding-top:100px;">
			<div class="inner">
				<!-- Logo -->
				<!-- <a href="/board/list?page=1;" class="logo">
						<span class="title">🌈MARISOLBOARD</span>
					</a> -->
				<!--top-menu-->
				<div align="right" class="menu">
					<!-- <a href="WEB-INF\views\master\sysmanage.html" >관리자메뉴</a> &nbsp;
						<a href="WEB-INF\views\master\sysmanage.html" >마이페이지</a> &nbsp;
						<a href="WEB-INF\views\master\sysmanage.html" >로그아웃</a> -->
				</div>
			</div>
		</header>
		<!-- Main -->
		<h1 align="center">🌈Marisol Board📋</h1>
		<div id="main" align="center" style="padding-bottom: 80px;">
			<div class="login_box">
				<h2>로그인</h2>
				<form class="login_form" name="loginForm" id="loginForm" method="post">
					<table style="width:500px;">
						<tr>
							<td> 아이디 </td>
							<td>
								<input type="text" name="userid" id="userid" class="input_login_data" placeholder="아이디">
								<p id="checkID"></p>
							</td>
						</tr>
						<tr>
							<td> 비밀번호 </td>
							<td>
								<input type="password" id="password" name="password" class="input_login_data"
									placeholder="비밀번호">
							</td>
						</tr>
					</table>
					<div class="col-6 col-12-small" style="margin-top: 20px;">
						<input type="checkbox" id="rememberUserId" name="save_id">
						<label for="rememberUserId">아이디 저장</label>
						<input type="checkbox" id="rememberPassword" name="save_password">
						<label for="rememberPassword">비밀번호 저장</label>
						<input type="checkbox" id="rememberMe" name="auto_login">
						<label for="rememberMe">자동 로그인</label>
					</div><br>
					<!-- 아이디 비밀번호 저장, 자동 로그인 선택 영역 End-->
					<input type="button" id="btn_login" value="로그인" class="button primary samll" style="width:500px;">
				</form>
				<div class="bottomText">
					<a href="/user/signup">회원가입</a> | <a href='/user/find'>아이디·비밀번호 찾기</a>
				</div>
			</div> <!-- loginBox div End -->
		</div> <!-- main div End -->
		<!-- Footer -->
		<footer id="footer" style="padding:30px 0 40px 0;">
			<div class="inner">
				<!-- <section>
							<h2>Get in touch</h2>
							<ul class="icons">
								<li><a href="#" class="icon brands style2" ><img src="\resources\images\icons\github_logo_icon_248225.png" style="width:45px; vertical-align: middle;"><span class="label">GitHub</span></a></li>
								<li><a href="#" class="icon brands style2"><img src="\resources\images\icons\tistory_logo_icon_249387.png" style="width:40px; vertical-align: middle;"><span class="label">Tistory</span></a></li>
							</ul>
						</section> -->
				<ul class="copyright" style="margin-top: 20px;" align="center">
					<li> 2023년 대한상공회의소 서울기술교육센터 기업프로젝트 S/W 개발자 과정</li>
					<li>교육생: <a href="#">성민경</a></li>
				</ul>
			</div>
		</footer>
	</div>

	<!--script-->
	<script src="/resources/js/css/jquery.min.js"></script>
	<script src="/resources/js/css/browser.min.js"></script>
	<script src="/resources/js/css/breakpoints.min.js"></script>
	<script src="/resources/js/css/util.js"></script>
	<script src="/resources/js/css/main.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
	<script src="/resources/js/user/login.js"></script>
	<!--script-->

</body>
</html>