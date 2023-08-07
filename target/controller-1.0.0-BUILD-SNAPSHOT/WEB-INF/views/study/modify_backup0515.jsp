<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%//세션 확인, userid 확인
	String userid = (String)session.getAttribute("userid");
	if(userid == null)
			response.sendRedirect("/user/login");
%>
<meta charset="UTF-8">
<title>게시물 상세 내용 보기</title>
<link rel="stylesheet" href="/resources/css/board.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script><!-- jQuery 라이브러리 사용 -->
<script>
//화면 시작하자 마자 작동할 것 windows.onload의 jquery형태
$(document).ready(function () {
	//이벤트 리스너 => 대기 상태, 이벤트 발생하면 작동, 발생 안하면 작동 안함
	$("#btn_modify").click(function () {	//#btn_modify에 대해 click이 발생하면 function을 실행 하도록 함		
		//유효성 체크
		if ($("#writer").val() == '') { alert("이름을 입력하세요."); $("#writer").focus(); return false; }
		if ($("#title").val() == '') { alert("title을 입력하세요."); $("#title").focus(); return false; }
		if ($("#content").val() == '') { alert("content을 입력하세요."); $("#content").focus(); return false; }

		//submit
		$("#ModifyFrom").attr.("acticon", "/board/modify").submit();

	})// End of $("#btn_modify").click

})// End of $(document).ready()
</script>
<script> /****기존 파일 삭제*******/
function check(box){
	var con=document.getElementById("onOff");
		if(box.checked==true)
			{
				con.style.display = 'block';	
			}
		else {
				con.style.display = 'none';	
		}
}
</script>
</head>
<body>
	<div class="main">
		<h1>게시물 내용 수정</h1> <br>
		<div class="ModifyForm">
			<form id="ModifyForm" method="post" enctype="multipart/form-data">
				<input type="text" class="input_field" id="writer" name="writer" value="${view.writer}" readonly> <!-- readonly 수정불가 옵션 -->
				<input type="text" class="input_field" id="" name="title" value="${view.title}">
				<input type="hidden" name="seqno" value="${view.seqno}">
				<input type="hidden" name="userid" id="userid" value="${view.userid}">
				<textarea class="input_content" id="content" cols="100" rows="500"
					name="content">${view.content}</textarea>
					<div class="uploadedFile" align="center">
						첨부파일 : 
						<c:if test="${view.org_filename != null}">
							<a href="/board/fileDownload?seqno=${view.seqno}">${view.org_filename}</a>
							<label><input type="checkbox" name="fileDelete" value="fileDelete" onClick="check(this)" id="fileDelete"> 삭제</label><br>
							<input type="file" name="fileUpload" id="onOff" style="display: none"><br>	<!-- 파일을 열고 정보를 읽는 역할까지 함. 여러개 옵션: multiple -->
							<input type="hidden" name="org_filename" value="${view.org_filename}">
							<input type="hidden" name="stored_filename" value="${view.stored_filename}">							
						</c:if>
						<c:if test="${view.org_filename == null}">
							첨부된 파일이 없습니다.<br>
							<input type="file" name="fileUpload" id="fileUpload"><br>	<!-- 파일을 열고 정보를 읽는 역할까지 함. 여러개 옵션: multiple -->
						</c:if>
					</div>
				<a id="hypertext" href="/board/view?seqno=${view.seqno}&page=${page}&keyword=${keyword}">뒤로가기</a>	<!-- 게시물 상세보기 페이지로 돌아감 -->
				<button type="reset" class="btn_modify" id="btn_reset">되돌리기</button>
				<button class="btn_modify" id="btn_modify">수정완료</button>
			</form>
		</div>
	</div>
	<br><br>
	
</body>

</html>