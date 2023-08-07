<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title> 회원가입 | MARISOLBOARD</title>
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
	
	<style>
		table {
			width : 800px; 
		}
	
		table tbody tr {
			border : none;
		}
		table td {			
			font-size: 15pt;
		}
	
		table th {
			margin: 50px;
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

		.imageZone span{
			vertical-align: middle;
			margin-top: 80px;
			color:rgb(162, 162, 162);
			font-weight: 400;
			font-size:14pt;
		}
		input, select {
			width: 60%;
		}
	</style>
</head>

<body>
	<!-- Wrapper -->
	<div id="wrapper">
		<!-- Header -->
		<header id="header">
			<div class="inner">
				<!-- Logo -->
				<a href="/board/list?page=1;" class="logo">
					<span class="title">🌈MARISOLBOARD</span>
				</a>
			</div>
		</header>
		<div id="main" align="center"><!-- main div Start-->
			<h2 style="margin-bottom: 20px;">회원가입</h2>
			<div style="width:900px; border: lightgray 1px solid">
				<div class="inner" style="margin-top:70px;">
					<div class="table-wrapper" align="center">
						<form id="RegistryForm" name="RegistryForm" method="POST" enctype="multipart/form-data" >
							<table>
								<tr>
									<td colspan="2" align="center">
										<input type="file" name="fileUpload" id="profileImage" style="display:none;" />
										<div class="imageZone" id="imageZone" style="width:800px; height:auto; min-height:250px; border:dotted 1px rgba(88, 88, 88, 0.5); text-align: center; vertical-align:middle;">
											<br><br>
											<span>이곳을 클릭해서 프로필 사진을 <br>선택해 주세요.</span>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="2"><p></p></td>
								</tr>
								<tr>
									<td>ID</td>
									<td><input type="text" id="userid" name="userid" placeholder="사용할 아이디를 입력하세요.">
										<p id="checkID"></p></td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td><input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요.">
										<p id="checkPW"></p>
									</td>
								</tr>
								<tr>
									<td>비밀번호 확인</td>
									<td><input type="password" id="password1" name="password1" placeholder="비밀번호를 다시 한 번 입력해 주세요.">
										<p id="checkPW1"></p></td>
								</tr>
								<tr>
									<td>이름</td>
									<td><input type="text" id="username" name="username" placeholder="이름을 입력해 주세요."></td>
								</tr>
								<tr>
									<td>성별</td>
									<td><input type="radio" id="gender_male" name="gender" value="남성">
										<label for="gender_male">남성</label>
										<input type="radio" id="gender_female" name="gender" value="여성">
										<label for="gender_female">여성</label></td>
								</tr>
								<tr>
									<td>취미</td>
									<td><input type="checkbox" id="all" name="all" onclick="selectAll(this)">
										<label for="all">전체선택</label>
										<input type="checkbox" id="music" name="hobbies" value="음악감상">
										<label for="music">음악감상</label>
										<input type="checkbox" id="movie" name="hobbies" value="영화보기">
										<label for="movie">영화보기</label>
										<input type="checkbox" id="sports" name="hobbies" value="스포츠">
										<label for="sports">스포츠</label>
										<input type="hidden" id="hobby" name="hobby"></td>
								</tr>
								<tr>
									<td>직업</td>
									<td><select name="job">
										<option disabled selected>-- 선택 --</option>
										<option value="회사원">회사원</option>
										<option value="공무원">공무원</option>
										<option value="자영업">자영업</option>
									</select></td>
								</tr>
								<tr>
									<td style="vertical-align: top;">주소</td>
									<td>
										<div style="display: grid-row;">
											<input type="text" id="addrSearch" name="addrSearch" style="width:400px; float: left;" placeholder="시/군/구 + 도로명, 동명 또는 건물명" onkeydown="enterCheck()">
											<input type="button" id="btn_addrSearch" style="height:40px; width: 120px; padding:0 0 2px 5px; position: relative; top: 5px" class="xsmall" value="주소검색" onclick="searchAddr()">
										</div>
									<br>
								</tr>
								<tr>
									<td></td>
									<td style="display: grid-row;">
										<input type="text" id="zipcode" name="zipcode" style="width: 200px;" placeholder="우편번호" readonly>
										<input type="text" id="addr1" name="addr1" placeholder="주소 검색 결과" readonly>
										<input type="text" id="addr2" name="addr2" placeholder="상세주소">
										<input type="hidden" id="address" name="address"></td>
									</td>
								</tr>
								<tr>
									<td>전화번호</td>
									<td><input type="text" id="telno" name="telno" placeholder="010-1234-1234"></td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><input type="text" id="email" name="email" placeholder="example@website.com">
										<p id="emailCheck"></p></td>
									</td>
								</tr>
								<tr>
									<td colspan="2">자기소개</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
									<textarea class="input_content"  style="width:800px; height:300px; margin-top: 20px;" id="description" name="description"
										placeholder="자기소개를 입력해주세요."></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div align="center" style="margin-top: 40px;">	<!-- 처리 버튼 -->
											<input type="button" class="button primary small" style="width:20%" id="btn_register" value="회원가입">
											<input type="button" class="button small" style="width:20%" value="취소" onclick="history.back()">
										</div>
									</td>
								</tr>
							</table>
						</form><!-- RegistryForm End-->
					</div><!--table-wrapper div End-->
				</div> <!--inner div End-->
			</div><!--틀-->
		</div><!--main div End-->
	</div><!--wrapper div End-->
	<script src="/resources/js/user/signup.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
</body>

</html>