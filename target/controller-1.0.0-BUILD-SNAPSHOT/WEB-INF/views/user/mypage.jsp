<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" type="text/css" href="/resources/css/board.css">
	<link rel="stylesheet" href="/resources/css/modify.css">
	<script src="/resources/js/user/mypage.js"></script>
	<% String userid=(String)session.getAttribute("userid"); if(userid==null)
		response.sendRedirect("/user/login"); %>
		<title>게시판 | 마이페이지</title>
</head>
<body>
	<div class="main">
		<h2>마이페이지 | 게시판</h2><br>
		<form class="boardView" id=UserInfoForm method="POST">
			<input type="file" name="fileUpload" id="profileImage" style="display:none;" />
			<div class="imageZone" id="imageZone">
				<img src="/profile/${user.stored_filename}" style='width:300px; height:auto;'> <br>
			</div>
			프로필 사진을 클릭하면 사진을 변경할 수 있습니다.
			<span id="img_cancle">취소</span>
			<div class="field">ID : ${user.userid }</div>
			<div class="field">이름 : ${user.username }</div>
			<div class="field">성별 : ${user.gender }</div>
			취미 :
			<label><input type="checkbox" id="all" name="all">전체선택</label>
			<label><input type="checkbox" class="hobby" name="hobby" value="음악감상">음악감상</label>
			<label><input type="checkbox" class="hobby" name="hobby" value="영화보기">영화보기</label>
			<label><input type="checkbox" class="hobby" name="hobby" value="스포츠">스포츠</label><br>

			직업 :
			<select class="job" name="job" id="job">
				<option disabled selected>-- 아래의 내용 중에서 선택</option>
				<option value="회사원">회사원</option>
				<option value="공무원">공무원</option>
				<option value="자영업">자영업</option>
			</select><br>

			<input type="hidden" id="org_filename" name="org_filename" value="${user.org_filename}">
			<input type="hidden" id="stored_filename" name="stored_filename" value="${user.stored_filename}">
			<input type="hidden" id="filesize" name="filesize" value="${user.filesize}">
			<input type="hidden" id="userid" name="userid" value="${user.userid}">
			<input type="hidden" id="username" name="username" value="${user.username}">
			<input type="hidden" id="org_job" name="org_job" value="${user.job}">
			<input type="hidden" id="org_hobbies" name="org_hobbies" value="${user.hobby}">
			<input type="hidden" id="address" name="address">
			<input type="hidden" id="role" name="role" value="${user.role}">

			<!-- 추가 정보 -->
			<input type="text" id="addrSearch" name="addrSearch" class="addrSearch" placeholder="시/군/구 + 도로명, 동명 또는 건물명 예) 동해시 중앙로, 여수 중앙동, 대전 현대아파트">
			<input type="button" id="btn_addrSearch" class="btn_addrSearch" value="주소검색">
			<input type="text" id="zipcode" class="input_field" name="zipcode" value="${user.zipcode}" readonly>
			<input type="text" id="addr1" class="input_field" name="addr1" value="${user.addr1}" readonly>
			<input type="text" id="addr2" class="input_field" name="addr2" value="${user.addr2}">
			<input type="text" id="telno" class="input_field" name="telno" value="${user.telno}"><br>
			이메일 <input type="text" id="email" class="input_field" name="email" value="${user.email}">
				<p id="emailCheck" style="color:red;text-align:center;font-size: 15px;"></p><!-- 이메일 정규성 확인 여부 -->
				<p style="color:red;"> 일반 사용자 </p>
			<!-- 추가 정보 끝-->
			자기 소개 :<br>
			<textarea class="input_content" id="description" cols="100" rows="500" name="description">${user.description}</textarea>
			<input type="button" class="btn_write" id="btn_modify" value="수정" />
			<input type="button" class="btn_cancel" id="btn_cancel" value="취소" />
		</form>
	</div>
</body>
</html>