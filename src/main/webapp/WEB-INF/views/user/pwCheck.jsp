<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
	String userid = (String)session.getAttribute("userid");
// 	if(userid == null)response.sendRedirect("/user/login");
	
	String pwc = (String)session.getAttribute("pwc");
// 	if(pwc == "Y")response.sendRedirect("/user/welcome");
	
	String username = (String)session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
<script src="/resources/js/user/pwCheck.js"></script>
<meta charset="UTF-8">
<head>
	<title> 비밀번호 확인 | MARISOLBOARD</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="\resources\css\MarisolBoard.css" />
	<!-- <link rel="stylesheet" href="/resources/css/MarisolBoard.css"> -->
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
			font-weight: 800;
		}

		div.find_box{
			width:600px;
			height: 400px;
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
			background-color: #ee5f81;
		}

		a.link_find{
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
		<header id="header">
			<div class="inner">
				<!-- Logo -->
				<a href="/board/list?page=1;" class="logo">
					<span class="title">🌈MARISOLBOARD</span>
				</a>
				<!--top-menu-->
				<div align="right" class="menu">
					<a href="/manager">관리자메뉴</a> &nbsp;
					<a href="/user/mypage?userid=<%=userid%>">마이페이지</a> &nbsp;
					<a href="WEB-INF\views\master\sysmanage.html">로그아웃</a>
				</div>
			</div>
		</header>
		<!-- Main -->
		<h3 align="center" style="margin-top: 30px;">비밀번호 확인</h3>
		<div id="main" align="center" style="padding-bottom: 80px;">
			<div class="find_box" style="margin: top -5px; padding-top: 30px;">
				<div class="col-6 col-12-small" style="color:#969696; font-size: 13pt; margin: 40px 0 30px 0;">
					새로운 비밀번호 설정을 위해 기존 비밀번호를 확인해주세요.
				</div>
				<form class="login_form" name="loginForm" id="loginForm" method="post">
					<div id="findData" class="inner">
						<table style="width:500px; margin:100px 0 50px 0;">
							<tr>
								<td> 현재 비밀번호 </td>
								<td>
									<input type="password" id="password" name="password" placeholder="현재 비밀번호를 입력해주세요.">
									<input type="hidden" id="userid" name="username" value="${userid }">	
								</td>
							</tr>
						</table>
					</div>
						<button class="button primary small" id="btn_submit" value="제출">확인</button>	
						<button class="button small" id="btn_cancel" value="ancel">취소</button>
				</form>
			</div> <!-- loginBox div End -->
		</div><!-- main div End -->
		<!--footer-->
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