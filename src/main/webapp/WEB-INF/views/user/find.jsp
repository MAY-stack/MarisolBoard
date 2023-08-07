<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title> 아이디·비밀번호 찾기 | MARISOLBOARD</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
	<style>
		table {
			width: 800px;
		}

		table tbody tr {
			border: none;
			font-size: 13pt;
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
			font-weight: 700;
		}

		div.find_box{
			width:600px;
			padding:50px 20px 50px 20px;
			border: lightgray 2px solid;
		}
		
		table.tab_find{
			width: 500px;
			height: 45px;
			background-color: #cbcbcb;
			font-size: 12pt;
			margin-top: 20px;
		}

		.tab_find td{
			width: 50%;
			text-align: center;
			font-weight: 500;
			background-color: #cbcbcb;
			border: none;
		}

		td.tab_find.on {
			background-color: #f2849e;
		}
		
		td.tab_find.on:hover {
			background-color: #f2849e;
			cursor:pointer;
		}
		
		td.tab_find:hover {
			background-color: #f2849e;
			cursor:pointer;
		}

		a.link_find{
			width: 600px;
			color: white;
			font-weight: 600;
			border-bottom: none;
		}
		
		a.link_find:hover {
			width: 600px;
			color: white;
			font-weight: 600;
			border-bottom: none;
		}
		

		input.input_data{

			font-size: 12pt;

		}
	</style>
</head>

<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header" style="padding-top:100px;">
		</header>
		<!-- Main -->
		<h1 align="center">🌈Marisol Board📋</h1>
		<div id="main" align="center" style="padding-bottom: 80px;">
			<div class="col-6 col-12-small" style="color:#969696; font-size: 13pt; margin-bottom: 15px;">
				회원가입시 입력한 정보로 아이디·비밀번호를 찾을 수 있습니다.
			</div>
			<div id="find_pw_box" class="find_box" style="margin-bottom:50px; padding-top: 30px;">
				<table class="tab_find">
					<tr>
						<td class="tab_find">
							<a href="javascript:;" class="link_find">아이디 찾기</a>
						</td>
						<td class="tab_find on" id="find_pw_tab">
							<a href="javascript:;" class="link_find"> 비밀번호 찾기</a>
						</td>
					</tr>
				</table>
				<h4 style="margin:50px;">비밀번호 찾기</h4>
				<form class="login_form" name="loginForm" id="loginForm" method="post">
					<div id="findData" class="inner">
						<table style="width:500px; margin-bottom: 50px;">
							<tr>
								<td> 아이디 </td>
								<td>
									<input type="text" id="userid_pw" name="userid" class="input_data" placeholder="아이디">
								</td>
							</tr>
							<tr>
								<td> 이름 </td>
								<td>
									<input type="text" id="username_pw" name="userna1me"class="input_data" placeholder="이름">
								</td>
							</tr>
							<tr>
								<td> 연락처 </td>
								<td>
									<input type="text" id="telno_pw" name="telno" class="input_data" placeholder="연락처">
								</td>
							</tr>
						</table>
					</div>
					<input type="button" id="btn_reset_pw" value="비밀번호 찾기" class="button primary small" style="width:500px;">
				</form>
				<div class="col-6 col-12-small" style="margin: 60px 0 20px 0; font-size: 13pt;">
					<span style="font-weight: 400; font-size:15pt;" id="find_pw_result"></span>
				</div>
			</div><!--loginBox div End -->
<!-- 	<div id="find_id_box" class="find_box" style="margin: top -5px; padding-top: 30px;">
				<table class="tab_find">
					<tr>
						<td class="tab_find on" id="find_id_tab">
							<a href="javascript:;" class="link_find">아이디 찾기</a>
						</td>
						<td class="tab_find" id="find_pw_tab">
							<a href="javascript:;" class="link_find"> 비밀번호 찾기</a>
						</td>
					</tr>
				</table>
				<h4 style="margin:50px;">아이디 찾기</h4>
				<form class="login_form" name="loginForm" id="loginForm" method="post">
					<div id="findData" class="inner">
						<table style="width:500px; margin-bottom: 50px;">
							<tr>
								<td> 이름 </td>
								<td>
									<input type="text" id="username" name="userna1me"class="input_data" placeholder="이름">
								</td>
							</tr>
							<tr>
								<td> 연락처 </td>
								<td>
									<input type="text" id="telno" name="telno" class="input_data" placeholder="연락처">
								</td>
							</tr>
						</table>
					</div>
					<input type="button" id="btn_find_id" value="아이디 찾기" class="button primary small" style="width:500px;">
				</form>
				<div class="col-6 col-12-small" style="margin-bottom: 50px; font-size: 13pt;">
					아이디 찾기 결과 : <span style="font-weight: 400; font-size:15pt;" id="find_id_result"></span>
				</div>
			</div>loginBox div End 
		</div>main div End -->
		<!--footer-->
		<footer id="footer" style="padding:30px 0 60px 0;">
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
	<script src="/resources/js/user/find.js"></script>
	<!--script-->
	


</body>

</html>