<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <!-- JSTL 사용을 위한 태그 -->
<!-- 세션 확인 -->
<%  
	String userid = (String)session.getAttribute("userid");
	if(userid == null)response.sendRedirect("/user/login");
	
	String pwc = (String)session.getAttribute("pwc");
	if(pwc == "Y")response.sendRedirect("/user/notice");
	
	String username = (String)session.getAttribute("username");
	String role = (String)session.getAttribute("role");
%>
<!DOCTYPE html>
<html>
<head>
<title>게시물 목록 | MARISOLBOARD </title>
<meta charset="utf-8" />
<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
<script src="/resources/js/board/list.js"></script>
<style>
	table thead tr {
		font-weight : 700;
	}
	
	tbody td a {
		transition: border-bottom-color 0.2s ease, color 0.2s ease;
		text-decoration: none;
		color: #585858;
		border-bottom: none;
	}
	
	td{
		font-size: 13pt;
		height:45px;
	}
	
	
	#pageList a{
		border-bottom: none;
		color:rgb(110, 110, 110);
		font-weight: 500;
		font-size:15pt;
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
				<a href="/board/list?page=1" class="logo">
					<span class="title">🌈MARISOLBOARD</span>
				</a>
				<!--top-menu-->
				<div align="right" class="menu">
					<c:if test="${role == 'MASTER' }">
						<a href="/master/sysmanage" style="display: inline-block; align-content: end; font-weight:500;">관리자메뉴</a> &nbsp;
					</c:if>
					<a href="/board/write">글쓰기</a> &nbsp;
					<a href="/user/mypage?userid=<%=userid%>">마이페이지</a> &nbsp;					
					<a href="" id="btn_logout">로그아웃</a>
				</div>
			</div>
		</header>

		<div id="main" align="center" style="padding-bottom:10px;">

			<header>
				<h2 align="center">게시물 목록</h2>
			</header>

			<div class="inner">
				<div class="table-wrapper">
					<div id="search-bar" align="right" style="padding-bottom: 50px;"> <!-- 검색창 -->
						<input type="text" name="keyword" id="keyword" placeholder="작성자, 제목, 내용에서 검색할 단어를 입력하세요."
							onkeydown="press()" style="font-size:10pt; width:350px; height:25px; display: inline; font-size: 12pt;">
						<input type="button" class="xsmall" value="검색" style="display: inline; font-size:11pt;" onclick="search()">
					</div>
					<table style="width:900px;">
						<thead>
							<tr>
								<th>번호</th>
								<th></th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="list"> <!-- JSTL의 core를 불러와서 반복문을 사용 할 것 -->
								<tr onmouseover="this.style.background='rgba(255, 255, 255, 0.5);'">
									<!-- 마우스오버 배경색 변경 효과 -->
									<td style="text-align:center; width:10%;">${list.seqno}</td> <!-- 게시물 번호 -->
									<td> </td>
									<td style="text-align:left; width:40%px;">
										<!-- seqno이 list.seqno과 같은 것으로 가는 링크를 제목에 달아줌-->
										<a onclick="javascript:document.viewForm.submit()" id="hypertext"
											href="/board/view?seqno=${list.seqno}&page=${page}&keyword=${keyword}"
											onmouseover="this.style.textDecoration='underline'"
											onmouseout="this.style.textDecoration='none'">&nbsp${list.title}
										</a>
									</td>
									<td style="text-align:center; width:15%;">${list.writer}</td>
									<td style="text-align:center; width:20%;">${list.regdate}</td>
									<td style="text-align:center; width:10%;">${list.hitno}</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>

						</tfoot>

					</table>
					<div id="pageList" style="margin-top:20px;">
						<p align="center"><span style="font-weight:600;">[</span> ${pageList } <span style="font-weight:600;">]</span></p>
					</div>
					<c:if test="${totalCount == 0 && keyword == ''}">
						<br>아직 등록된 글이 없습니다.
					</c:if>
					<c:if test="${totalCount == 0 && keyword != ''}">
						<br>검색 결과가 없습니다.
					</c:if>

				</div> <!--table-wrapper End-->
			</div>
		</div>
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
</body>
</html>