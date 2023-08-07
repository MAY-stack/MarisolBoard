<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> --%>
<!-- 세션 확인 -->
<%  
	String userid = (String)session.getAttribute("userid");
	if(userid != null)response.sendRedirect("/board/list");
	
	String pwc = (String)session.getAttribute("pwc");
	if(pwc == "Y")response.sendRedirect("/user/notice");
	
	String username = (String)session.getAttribute("username");
%>
<html>
	<head>
		<title> Home | Marisol Board </title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
		<script src="/resources/js/board/home.js"></script>
	<!-- Scripts -->
		<script src="/resources/js/css/jquery.min.js"></script>
		<script src="/resources/js/css/browser.min.js"></script>
		<script src="/resources/js/css/breakpoints.min.js"></script>
		<script src="/resources/js/css/util.js"></script>
		<script src="/resources/js/css/main.js"></script>
		
		<style>

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
<!-- 							<span class="title">🌈MarisolBoard📋</span> -->
						</a>
		
<!-- 						Nav -->
						<nav>
							<ul>
								<li><a href="#menu">메뉴</a></li>
							</ul>
						</nav>
		
					</div>
				</header>

				<!-- Menu -->
				<nav id="menu">
					<h2>Menu</h2>
					<ul>
					<li><a href="/user/login">Login</a></li>

<%-- 					<c:if test="${role =='MASTER' }"> --%>
<!-- 						<li><a href="/master/sysmanage">Master</a></li> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${role =='MASTER' }"> --%>
<!-- 						<li><a href="/master/sysmanage">Master</a></li> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${role =='MASTER' }"> --%>
<!-- 						<li><a href="/master/sysmanage">Master</a></li> -->
<%-- 					</c:if> --%>
					<c:if test="${role =='MASTER' }">
						<li><a href="/master/sysmanage">Master</a></li>
					</c:if>
					</ul>
				</nav>

				<!-- Main -->
					<div id="main">
						<div class="inner">
							<header>
								<h1 align="center">Marisol Board</h1>
								<p> Welcome to Marisol Board. This is written in English to look good without any special meaning. This is the result of my first full stack development project. It may not work well. I just put pictures of cute things below. It doesn't work even if you click it.</p>
							</header>
							<section class="tiles">
								<article class="style1">
									<span class="image">
										<img src="/resources/images/panda/chunsik.jpg" alt="" />
									</span>
										<a href="#">
										<h2>춘식이</h2>
										<div class="content">
											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
										</div>
									</a>
								</article>
								<article class="style2">
									<span class="image">
										<img src="/resources/images/panda/bigbao.jpg" alt="" />
									</span>
									<a href="#">
										<h2>푸바오</h2>
										<div class="content">
											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
										</div>
									</a>
								</article>
								<article class="style3">
									<span class="image">
										<img src="/resources/images/panda/mininis.jpg" alt="" />
									</span>
									<a href="#">
										<h2>미니니</h2>
										<div class="content">
											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p>
										</div>
									</a>
								</article>
<!-- 								<article class="style2"> -->
<!-- 									<span class="image"> -->
<!-- 										<img src="images/pic07.jpg" alt="" /> -->
<!-- 									</span> -->
<!-- 									<a href="generic.html"> -->
<!-- 										<h2>Ipsum</h2> -->
<!-- 										<div class="content"> -->
<!-- 											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p> -->
<!-- 										</div> -->
<!-- 									</a> -->
<!-- 								</article> -->
<!-- 								<article class="style3"> -->
<!-- 									<span class="image"> -->
<!-- 										<img src="images/pic08.jpg" alt="" /> -->
<!-- 									</span> -->
<!-- 									<a href="generic.html"> -->
<!-- 										<h2>Dolor</h2> -->
<!-- 										<div class="content"> -->
<!-- 											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p> -->
<!-- 										</div> -->
<!-- 									</a> -->
<!-- 								</article> -->
<!-- 								<article class="style1"> -->
<!-- 									<span class="image"> -->
<!-- 										<img src="images/pic09.jpg" alt="" /> -->
<!-- 									</span> -->
<!-- 									<a href="generic.html"> -->
<!-- 										<h2>Nullam</h2> -->
<!-- 										<div class="content"> -->
<!-- 											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p> -->
<!-- 										</div> -->
<!-- 									</a> -->
<!-- 								</article> -->
<!-- 								<article class="style5"> -->
<!-- 									<span class="image"> -->
<!-- 										<img src="images/pic10.jpg" alt="" /> -->
<!-- 									</span> -->
<!-- 									<a href="generic.html"> -->
<!-- 										<h2>Ultricies</h2> -->
<!-- 										<div class="content"> -->
<!-- 											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p> -->
<!-- 										</div> -->
<!-- 									</a> -->
<!-- 								</article> -->
<!-- 								<article class="style6"> -->
<!-- 									<span class="image"> -->
<!-- 										<img src="images/pic11.jpg" alt="" /> -->
<!-- 									</span> -->
<!-- 									<a href="generic.html"> -->
<!-- 										<h2>Dictum</h2> -->
<!-- 										<div class="content"> -->
<!-- 											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p> -->
<!-- 										</div> -->
<!-- 									</a> -->
<!-- 								</article> -->
<!-- 								<article class="style4"> -->
<!-- 									<span class="image"> -->
<!-- 										<img src="images/pic12.jpg" alt="" /> -->
<!-- 									</span> -->
<!-- 									<a href="generic.html"> -->
<!-- 										<h2>Pretium</h2> -->
<!-- 										<div class="content"> -->
<!-- 											<p>Sed nisl arcu euismod sit amet nisi lorem etiam dolor veroeros et feugiat.</p> -->
<!-- 										</div> -->
<!-- 									</a> -->
<!-- 								</article>								 -->
							</section>
						</div>
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
