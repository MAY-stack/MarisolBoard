<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String userid=(String)session.getAttribute("userid"); if(userid==null)
	response.sendRedirect("/user/login"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 마이페이지 | MARISOLBOARD</title>
<link rel="stylesheet" href="/resources/css/MarisolBoard.css">	
<style>
	table {
		width : 800px; 
	}

	table tbody tr {
		border : none;
	}
	table td {			
		font-size: 15pt;
		width:25%;
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

	td:nth-child(1){
		font-weight: 700;
	}
	table tr td span {
		vertical-align: middle;
		margin-top: 80px;
		color:rgb(162, 162, 162);
		font-weight: 500;
		font-size:14pt;
	}
	input, select {
		width: 60%;
	}
	
	input[type="button"].xsmall{
		height:40px;
		width: 100px;
		padding:5px 0 5px 5px;
		position: relative;
		top: 5px;
	}
</style>
</head>
<body>
	<input type="hidden" id="org_job" value="${user.job }">
	<input type="hidden" id="org_hobbies" value="${user.hobby }">
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header">
			<div class="inner">
				<!-- Logo -->
				<a href="/board/list" class="logo">
					<span class="title">🌈MARISOLBOARD</span>
				</a>
				<!--top-menu-->
				<div align="right" class="menu">
					<a href="WEB-INF\views\master\sysmanage.html">관리자메뉴</a> &nbsp;
					<a href="/board/list">게시물 목록</a> &nbsp;
					<a href="/user/logout">로그아웃</a>
				</div>
			</div>
		</header>
		<div id="main" align="center"><!-- main div Start-->
			<h2 style="margin-bottom: 20px;">마이페이지</h2>
			<div style="width:900px; border: lightgray 1px solid">
				<div class="inner" style="margin-top:70px;">
					<div class="table-wrapper" align="center">
						<form id="UserInfoForm" name="UserInfoForm" method="POST" enctype="multipart/form-data" >
							<table>
								<tr>
									<td colspan="4" align="center">
										<input type="file" name="fileUpload" id="profileImage" style="display:none;" />
										<div class="imageZone" id="imageZone" style="width:800px; height:auto; min-height:250px; border:dotted 1px rgba(88, 88, 88, 0.5); text-align: center; vertical-align:middle;">
											<img src="/profile/${user.stored_filename}">
										</div>
										<span>프로필 사진을 클릭하면 사진을 변경할 수 있습니다.</span>
									    <span id="img_cancle"></span>
									</td>
								</tr>
								<tr>
									<td colspan="4"><p></p></td>
								</tr>
								<tr>
									<td>ID</td>
									<td>${user.userid }</td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>비빌번호 설정일</td>
									<td>
										<div class="alt">
											${user.pw_set_date }
										</div>
									</td>
									<td>
										<a href="/user/pwCheck?userid=<%=userid%>" class="button primary xsmall" 
											style="height:30px; width: 140px; padding:13px 8px 0px 13px; position: relative; top:0px;">
											비밀번호 변경</a>
									</td>
									<td></td>
								</tr>
								<tr>
									<td >이름</td>
									<td style="width:30%" >
										<input type="text"  id="username" name="username" value="${user.username }" readonly>
									</td>
									<td style="text-align: center; font-weight: 600;">성별</td>
									<td style="width:30%" >
										<input type="text" id="gender" name="gender"  value="${user.gender }">
									</td>
								</tr>
								<tr>
									<td>취미</td>
									<td colspan="3">
										<input type="checkbox" id="all" name="all">
										<label for="all">전체선택</label>
										<input type="checkbox" id="music" class="hobby" name="hobby" value="음악감상">
										<label for="music">음악감상</label>
										<input type="checkbox" id="movie" class="hobby" name="hobby" value="영화보기">
										<label for="movie">영화보기</label>
										<input type="checkbox" id="sports" class="hobby" name="hobby" value="스포츠">
										<label for="sports">스포츠</label>
									</td>
								</tr>
								<tr>
									<td>직업</td>
									<td colspan="3">
										<select class="job" name="job" id="job">
											<option disabled selected>-- 선택 --</option>
											<option value="회사원">회사원</option>
											<option value="공무원">공무원</option>
											<option value="자영업">자영업</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="vertical-align: top;">주소</td>
									<td colspan="3">
										<div style="display: grid-row;">
											<input type="text" id="addrSearch" name="addrSearch" style="width:400px; float: left;" placeholder="시/군/구 + 도로명, 동명 또는 건물명" onkeydown="enterCheck()">
											<input type="button" id="btn_addrSearch" 
												class="xsmall" value="주소검색" onclick="searchAddr()">
										</div>
									<br>
								</tr>
								<tr>
									<td></td>
									<td colspan="3" style="display: grid-row;">
										<input type="text" id="zipcode" class="input_field" name="zipcode" placeholder="우편번호" value="${user.zipcode}" readonly>
										<input type="text" id="addr1" class="input_field" name="addr1" placeholder="주소 검색 결과" value="${user.addr1}" readonly>
										<input type="text" id="addr2" class="input_field" name="addr2" placeholder="상세주소" value="${user.addr2}" >
										<input type="hidden" id="address" name="address"></td>
									</td>
								</tr>
								<tr>
									<td>전화번호</td>
									<td><input type="text" id="telno" name="telno" value="${user.telno}" placeholder="010-1234-1234"></td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><input type="text" id="email" name="email" value="${user.email}" placeholder="example@website.com"></td>
								</tr>
								<tr>
									<td colspan="4">자기소개</td>
								</tr>
								<tr>
									<td colspan="4" align="center">
									<textarea class="input_content"  style="width:800px; height:300px; margin-top: 20px;" id="description" name="description"
										placeholder="자기소개를 입력해주세요.">${user.description}</textarea>
									</td>
								</tr>
								<tr>
									<td colspan="4">
										<div align="center" style="margin-top: 40px;">	<!-- 처리 버튼 -->
											<input type="button" class="button primary small" style="width:20%" id="btn_modify" value="수정완료">
											<input type="button" class="button small" style="width:20%" id="btn_cancel" value="수정취소" onclick="history.back()">
										</div>
									</td>
								</tr>
							</table>
						</form><!-- UserInfoForm End-->
					</div><!--table-wrapper div End-->
				</div> <!--inner div End-->
			</div><!--틀-->
		</div><!--main div End-->
	</div><!--wrapper div End-->
	<!-- Scripts -->
	<script src="/resources/js/css/jquery.min.js"></script>
	<script src="/resources/js/css/browser.min.js"></script>
	<script src="/resources/js/css/breakpoints.min.js"></script>
	<script src="/resources/js/css/util.js"></script>
	<script src="/resources/js/css/main.js"></script>
	<script src="/resources/js/user/mypage.js"></script>
</body>
</html>