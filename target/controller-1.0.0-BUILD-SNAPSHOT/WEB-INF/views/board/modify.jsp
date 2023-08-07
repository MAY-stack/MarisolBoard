<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title> 글 수정 | 게시판 </title>
<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	if(userid == null) response.sendRedirect("/");
%>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
<script src="/resources/js/board/modify.js"></script>
</head>   
<body>
<h1 style="display:block; align:center;"><a href="/board/list?page=1">🌈BOARD📋</a></h1>
    <!-- model 값 받기 -->
    <input type="hidden" name="page" id="page" value="${page}">
	<input type="hidden" name="keyword" id="keyword" value="${keyword}">
    <input type="hidden" name="seqno" id="seqno" value="${view.seqno}">
<%-- 	<input type="hidden" name="pre_seq" id="pre_seq" value="${pre_seq}"> --%>
<%-- 	<input type="hidden" name="preV_PageNum" id="preV_PageNum" value="${preV_PageNum}"> --%>
<%-- 	<input type="text" name="seq" id="seq" value="${view.seq}"> --%>
<%-- 	<input type="hidden" name="next_seq" id="next_seq" value="${next_seq}"> --%>
<%-- 	<input type="hidden" name="nextV_PageNum" id="nextV_PageNum" value="${nextV_PageNum}"> --%>
    <input type="hidden" name="writer" id="writer" value="${view.userid}">	<!-- 글작성자 -->
    <input type="hidden" name="likeCnt" id="likeCnt" value="${view.likecnt}">	<!-- 글의 좋아요 개수 -->
    <input type="hidden" name="dislikeCnt" id="dislikeCnt" value="${view.dislikecnt}"> <!-- 글의 싫어요 개수-->
    
    <input type="hidden" name="username" id="username" value="${username}"> <!-- 접속 사용자 이름 -->
    <input type="hidden" name="myLikeCheck" id="myLikeCheck" value="${myLikeCheck}"> <!-- 접속한 사용자의 싫어요여부 -->
    <input type="hidden" name="myDislikeCheck" id="myDislikeCheck" value="${myDislikeCheck}"> <!-- 접속한 사용자의 싫어요여부 -->
    
    <input type="hidden" name="modify_authority" id="modify_authority" value="${modify_authority}"> <!-- 접속한 사용자의 수정 권한 -->



<div class="FormDiv">

	<h2>글 수정</h2>
	
	<form id="ModifyForm" method="POST" >
		<input type="text" class="field" id="writer" value="작성자 : <%=username %> 님" readonly>
		<input type="text" class="field" id="title" name="title"  value="${view.title}">
		<input type="hidden" name="seqno" value="${view.seqno}">
		<input type="hidden" name="userid" value="${view.userid}">
		<input type="hidden" name="page" value="${page}">
		<input type="hidden" name="keyword" value="${keyword}">
		<textarea id="content" cols="100" rows="500" name="content">${view.content}</textarea>
		
		<c:if test="${fileListView != null }">
         	<div id="fileListForm"><p style="text-align:left;"> 파일 목록 <br> 삭제를 원하는 파일명을 체크하세요.</p></div>
         	<div id="fileList">	
         		<p style="text-align:left;">
        	 		<c:forEach items="${fileListView}" var="file" >
         				<input type="checkbox" name="deleteFileList" value="${file.fileseqno}"> 
         				 ${file.org_filename}&nbsp( ${file.filesize} Byte)<br>
	         		</c:forEach>
         		</p>
         	</div>       
        </c:if>
				
		<div class="fileuploadForm">
			<input type="file" id="input-file" name="uploadFile" style="display:none;" multiple />
			<div id="fileZone" class="fileZone">파일 첨부를 하기 위해서는 클릭하거나 여기로 파일을 드래그 하세요.<br>첨부파일은 최대 5개까지 등록이 가능합니다.</div><!-- fileClick div End -->
  			<div id="fileUploadList" class="fileUploadList"></div><!-- fileUploadList div End -->
		</div>

		<input type="button" class="btn_write" id="btn_modify" value="수정"/>
		<input type="button" class="btn_cancel" value="취소" onclick="history.back()" />
	</form>	

</div>
<br><br>
</body>
</html>