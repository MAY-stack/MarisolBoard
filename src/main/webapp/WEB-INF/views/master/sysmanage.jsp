<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 관리자 메뉴 | MARISOLBOARD</title>
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
<style>
.menubar{
	width: 100%;
	height: auto;
	background-color:rgba(88, 88, 88);
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	text-align:center;
}

.menubar a:link, a:visited, a:active {
	color: white;
	font-weight: 700;
}

.menubar a{
	display:block;
	text-decoration: none;
}

.menubar .main-menu > li {
	float: left;
	width: 20%;
	height: 100%;
	line-height: 50px;
	list-style:none;
	font-weight: bold;
	position: relative;
	margin: 0px;
}

.menubar .main-menu > li > a:hover {
	background-color : #f0f6f9;
	color : #168;
	font-weight: bold;
}
</style>
</head>
<body>

<div id="main" style="vertical-align: middle; padding-top:60px;">
<h1 align="center">🌈Marisol Board📋</h1>
<h2 align="center" >관리자 메뉴🔧</h2>
<div class='menubar'>
	<ul class='main-menu'>
		<li><a href='/board/list?page=1'>게시글 목록</a></li>
		<li><a href='/master/sysmanage'>관리자 메뉴</a></li>
		<li><a href='/master/sysinfo'>시스템 정보</a></li>
		<li><a href='/master/filemanage'>첨부파일 관리</a></li>
	</ul>
</div>
<div align="center" style="vertical-align: middle;">
	<img src="/resources/images/manager.png">
</div>
<footer id="footer" style="padding:30px 0 40px 0;">
	<div class="inner">
		<!-- <section>
					<h2>Get in touch</h2>
					<ul class="icons">
						<li><a href="#" class="icon brands style2" ><img src="\resources\images\icons\github_logo_icon_248225.png" style="width:45px; vertical-align: middle;"><span class="label">GitHub</span></a></li>
						<li><a href="#" class="icon brands style2"><img src="\resources\images\icons\tistory_logo_icon_249387.png" style="width:40px; vertical-align: middle;"><span class="label">Tistory</span></a></li>
					</ul>
				</section> -->
		<ul class="copyright"  align="center">
			<li> 2023년 대한상공회의소 서울기술교육센터 기업프로젝트 S/W 개발자 과정</li>
			<li>교육생: <a href="#">성민경</a></li>
		</ul>
	</div>
</footer>
</div>

</body>
</html>