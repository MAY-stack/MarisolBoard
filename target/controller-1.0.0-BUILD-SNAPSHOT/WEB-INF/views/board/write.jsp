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
<title>글쓰기 | 게시판</title>
<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
<script src="/resources/js/board/write.js"></script>
</head>
<body>
	<h1><a href="/board/list?page=1">🌈BOARD📋</a></h1>
	<div class="main">
		<div class="WriteDiv">
		<h2>글쓰기</h2><br>
			<form id="WriteFrom" method="POST">
				<input type ="text" class="input_field" name="writer" id="writer" value="<%=username%>" readonly>
				<input type="text" class="input_field" name="title" id="title" placeholder="제목을 입력하세요.">
				<input type="hidden" name="userid" value="<%=userid%>">	<!-- 세션의 userid 정보 저장 -->
				<textarea class="input_content" id="content" name="content" cols="100" rows="100" placeholder="여기에 내용을 입력하세요."></textarea><br><br>
				<div class="fileuploadForm">
					<input type="file" id="input-file" name="uploadFile" style="display:none;" multiple />
					<div id="fileZone" class="fileZone">파일 첨부를 하기 위해서는 클릭하거나 여기로 파일을 드래그 하세요.<br>첨부파일은 최대 5개까지 등록이 가능합니다.</div><!-- fileClick div End -->
		  			<div id="fileUploadList" class="fileUploadList"></div><!-- fileUploadList div End -->
				</div>
				<input type="button" class="btn_write" id="btn_write" value="등록"/>
				<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
			</form><!-- WriteForm End -->
		</div><!-- WriteDiv End -->
	</div><!-- main div End -->
</body>
</html>