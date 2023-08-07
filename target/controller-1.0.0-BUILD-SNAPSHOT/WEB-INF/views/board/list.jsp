<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<!-- 세션 확인 -->
<%  
	String userid = (String)session.getAttribute("userid");
	if(userid == null)response.sendRedirect("/user/login");
	
	String pwc = (String)session.getAttribute("pwc");
	if(pwc == "Y")response.sendRedirect("/user/welcome");
	
	String username = (String)session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
<script src="/resources/js/board/list.js"></script>
<title>게시물 목록 보기</title>
<style>
a:link{color:black;text-decoration:none;}
</style>
</head>
<body>

<h1><a href="/board/list?page=1">🌈BOARD📋</a></h1>
	<div class="topMenu">

		<div id="home">[<a href="/board/list?page=1">처음으로</a>]</div>
		<div id="write">[<a href="/board/write">글쓰기</a>]</div>
		<div id="myInfo">[<a href="/user/mypage?userid=<%=userid%>">마이 페이지</a>]</div>
		<div id="logOut" onclick="logout()" style="cursor:pointer;">[로그아웃]</div>
	</div>

<div class="tableDiv">
		<c:if test="${role =='MASTER' }">
			<a href="/master/sysmanage">시스템 관리</a>&nbsp;
		</c:if>
	<h2>글목록</h2>
	<!-- 검색창 -->
	<input type="text" name="keyword" id="keyword"	placeholder="Enter the title, author name and content to search" onkeydown="press()">
	<input type="button" value="search" onclick="search()">
	<table class="InfoTable">
		<tr>
			<th>번호</th>	<!-- 테이블 헤드 -->
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<tbody> <!-- DB에서 데이터를 불러와서 반복적으로 출력시켜주는 부분 -->
			<c:forEach items="${list}" var="list">	<!-- JSTL의 core를 불러와서 반복문을 사용 할 것 -->
				<tr onmouseover="this.style.background='#45D2D2'" onmouseout="this.style.background='white'"> <!-- 마우스오버 배경색 변경 효과 -->
					<td>${list.seqno}</td>	<!-- 게시물 번호 -->
					<td style="text-align:left"><!-- seqno이 list.seqno과 같은 것으로 가는 링크를 제목에 달아줌-->
					<a onclick="javascript:document.viewForm.submit()" id="hypertext" href="/board/view?seqno=${list.seqno}&page=${page}&keyword=${keyword}"
						onmouseover="this.style.textDecoration='underline'"
						onmouseout="this.style.textDecoration='none'"
						>${list.title}
							</a>
						</td>
					<td>${list.writer}</td>
					<td>${list.regdate}</td>
					<td>${list.hitno}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		<c:if test="${totalCount == 0 && keyword == ''}">
			<br>아직 등록된 글이 없습니다.
		</c:if>
		<c:if test="${totalCount == 0 && keyword != ''}">
			<br>검색 결과가 없습니다.
		</c:if>
	<br>
		<div id="pageList"> ${pageList }	</div>
	<br>
</div>
</body>
</html>