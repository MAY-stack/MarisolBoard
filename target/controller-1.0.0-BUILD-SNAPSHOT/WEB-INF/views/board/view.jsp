<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 라이브러리 사용 -->
<script src="/resources/js/board/view.js"></script>
<%//세션 확인
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	 		if(userid == null)response.sendRedirect("/user/login");	//userid가 null이면 로그인 페이지로 보냄
%>
<style>
/****좋아요/싫어요*****/
.likeClick, .dislikeClick {
    padding: 10px 10px;
	text-align: center;	
	text-decoration: none;
    border: solid 1px #a0a0a0;
    display: inline-block;
    background-color: #d2d2d2;
    border-radius: 20px
}
</style>
<title>글 상세 보기 | 게시판</title>
</head>
<body>
    <h1><a href="/board/list?page=1">🌈BOARD📋</a></h1>
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
    
	<div class="main">
		<h2>글 상세 보기</h2>
		<div class="boardView">
			<div class="field">이름 : ${view.writer}</div>
			<div class="field">제목 : ${view.title}</div>
			<div class="field">날짜 : ${view.regdate}</div>
			<div class="content"><pre>${view.content}</pre></div>
			<div class="uploadedFile" align="center">		
				첨부파일 : 
		        <c:if test="${fileListView != null}">
		        	<c:forEach items="${fileListView}" var="fileView">
						<div class="field">파일명 : <a href="/board/filedownload?fileseqno=${fileView.fileseqno}">${fileView.org_filename}</a> ( ${fileView.filesize} Byte )
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${fileListView == null}">
					<div class="field">업로드된 파일이 없습니다.
					</div>
				</c:if>	
			</div> <!-- uploadedFile End -->
			<br>
            <div class="likeForm" style="width:50%; height:auto; margin:auto;"><!-- 좋아요/싫어요 display likeForm -->
                <span id='like'></span>&nbsp;<a href='#' id="likeClick" class="likeClick">좋아요</a>
               <a href="#" id="disLikeClick" class="dislikeClick">싫어요</a>&nbsp;<span id="dislike"></span><br>
                 <span id='myChoice' style='color:darkgreen' style="text-align:center;"></span>
           </div><!-- 좋아요/싫어요 display likeForm END-->
           <br>
		</div> <!-- boardView END-->
		<br>
		<div class="bottom_btns" style="width:80%; margin:auto" align="center"> <!-- 고정값으로 하는것 보다 %단위 사용하는 것이 더 유연하게 적용될 수 있음 -->
				<a href='/board/list?page=${page}&keyword=${keyword}' id="btn_goList">목록가기</a>
				<button class="btn_" id="btn_preV">이전글</button>
				<button class="btn_" id="btn_modify">수정하기</button>
				<button class="btn_" id="btn_delete">삭제하기</button>
				<button class="btn_" id="btn_nextV">다음글</button>
		</div> <!-- btn End -->
        <!-- replyDiv start -->
		<div class="replyDiv" style="text-align:left;width:60%;height:300px; margin:auto; ">
			<p id="replyNotice">댓글을 작성해 주세요</p>
			<form id="replyForm" name="replyForm" method="POST"> 
				작성자 : <input type="text" id="replywriter" name="replywriter" value="${username}" readonly><br>
		    	<textarea id='replycontent' name='replycontent' cols='80' rows='5' maxlength='150' placeholder='글자수:150자 이내'></textarea><br>
		    	<input type="hidden" id="seqno" name="seqno" value="${view.seqno}">
		    	<input type="hidden" id="userid" name="userid" value="${userid}">
			</form>
			<input type="button" id="btn_reply" value="댓글등록">
			<input type="button" id="btn_reply_cancle" value="취소">
			<br>			
			<div id="replyList" style="width:100%; height:600px; overflow:auto;"> 
			</div><!-- replyList End  -->		
		</div><!-- replyDiv End -->
	</div> <!-- main End -->
</body>
</html>