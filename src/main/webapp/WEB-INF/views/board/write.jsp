<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%//세션 확인
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
 	if(userid == null) response.sendRedirect("/user/login");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title> 글쓰기 | MARISOLBOARD</title>
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
	<script src="/resources/js/board/write.js"></script>
	<style>
		table {
			width: 800px;
			margin-top: 50px;
		}

		table tbody tr {
			border: none;
		}

		table td {
			font-size: 15pt;
		}

		table th {
			margin: 50px 50px 50px 50px;
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
			font-weight: 600;
		}

		.fileZone span {
			vertical-align: middle;
			margin-top: 80px;
			color:rgb(162, 162, 162);
			font-weight: 400;
			font-size:13pt;
		}

		input,
		select {
			width: 60%;
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
					<c:if test="${role == 'MASTER' }">
						<a href="/master/sysmanage" style="display: inline-block; align-content: end; font-weight:500;">관리자메뉴</a> &nbsp;
					</c:if>
					<!-- <a href="/board/write">글쓰기</a> &nbsp; -->
					<a href="/user/mypage?userid=<%=userid%>">마이페이지</a> &nbsp;					
					<a href="" id="btn_logout">로그아웃</a>
				</div>
			</div>
		</header>
		<div id="main" align="center" >
			<div class="inner">
				<header>
					<h2 align="center">글쓰기</h2>
				</header>
				<div style="width:900px; border: lightgray 1px solid">
					<form id="WriteFrom" method="POST">
						<table>
							<tr style="height: 40px;">
								<td style="width: 100px;"> 작성자 </td>
								<td> <input type="text" class="input_field" name="writer" id="writer"
										value="<%=username%>" readonly> </td>
							</tr>
							<tr style="height: 40px;">
								<td> 제목 </td>
								<td> <input type="text" class="input_field" name="title" id="title"
										placeholder="제목을 입력하세요."> </td>
							</tr>
							<tr style="height: 40px;">
								<td colspan="2"> 내용 </td>
								<td> </td>
							</tr>
							<tr>
								<td colspan="2" align="center"><textarea class="input_content" id="content"
										name="content" cols="100" rows="20"
										style="width:800px; height:300px; margin-top: 20px;"
										placeholder="여기에 내용을 입력하세요."></textarea>
								</td>
							</tr>
							<tr style="height: 45px;">
								<td colspan="2"><br>파일첨부</td>
							</tr>
							<tr>								
								<td colspan="2" align="center">
									<input type="file" id="input-file" name="uploadFile" style="display:none;" multiple />
									<input type="file" name="fileUpload" id="profileImage" style="display:none;" />
									<div id="fileZone" class="fileZone" style="width:800px; height:auto; min-height:130px; border:dotted 1px rgba(88, 88, 88, 0.5); text-align: center; font-size: 13pt; font-weight: 400; vertical-align:middle;">
										<br>
										<span>파일 첨부를 하시려면 이곳을 클릭하거나 여기로 파일을 드래그 하세요.<br>
												(파일은 최대 5개까지 등록이 가능합니다.)</span>
									</div><!-- fileClick div End -->
									<div id="fileUploadList" class="fileUploadList" style="font-weight:400;">
									</div><!-- fileUploadList div End -->
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<div align="center" style="margin-top: 40px;">	<!-- 처리 버튼 -->
										<input type="button" class="button primary small" style="width:20%" id="btn_write" value="등록" >
										<input type="button" class="button small" style="width:20%" value="취소" onclick="history.back()">
									</div>
								</td>
							</tr>
						</table>
						<input type="hidden" name="userid" value="<%=userid%>"> <!-- 세션의 userid 정보 저장 -->
					</form><!-- WriteForm End -->
				</div><!--틀-->
			</div><!--inner div End-->
		</div><!-- main div End -->
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
	</div><!--wrapper div End -->
			<!-- Scripts -->
			<script src="/resources/js/css/jquery.min.js"></script>
			<script src="/resources/js/css/browser.min.js"></script>
			<script src="/resources/js/css/breakpoints.min.js"></script>
			<script src="/resources/js/css/util.js"></script>
			<script src="/resources/js/css/main.js"></script>
</body>

</html>