<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 | 게시판</title>
    <link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
    <script src="/resources/js/user/signup.js"></script>
    <style>
        input[type="text"],
        input[type="password"] {
            text-decoration: none;
            color: #585858;
            cursor: pointer;
            display: inline-block;
            font-size: 0.8em;
            font-weight: 300;
            position: relative;
            width: 600px;
        }

        p {
            color: #ee5f81;
            text-align: center;
            font-size: 16px;
        }
        
	    input[type="checkbox"] + label,
		input[type="radio"] + label {
			text-decoration: none;
			color: #585858;
			cursor: pointer;
			display: inline-block;
			font-size: 0.9em;
			font-weight: 300;
			padding-left: 2.55em;
			padding-right: 0.75em;
			position: relative;
		}
		select {
			font-size: 0.7em;
		}
		textarea{
			border: solid 1px #c9c9c9;
		}
		textarea:focus {
			border-color: #f2849e;
			box-shadow: inset 0 -1px 0 0 #f2849e;
		}

    </style>
</head>
<body>
    <h1 align="center">🌈My BOARD📋</h1>
    <div class="main" align="center"  ><!-- main div Start-->
        <h2>회원가입</h2>
<!--         <div class="container" style="text-align:left; position:relative; left:35px; margin:10px; padding:10px" align="center"> -->
            <form id="RegistryForm" name="RegistryForm" method="POST" enctype="multipart/form-data" >
                <!-- RegistryForm Start -->
                <input type="file" name="fileUpload" id="profileImage" style="display:none;" />
                <div class="imageZone" id="imageZone" style="width:600px; height:auto; border:#ee5f81 2px solid; text-align: center; vertical-align:middle;">
                    이곳을 클릭해서 프로필 사진을 <br>선택해 주세요.
                </div>
                ID
                <input type="text" id="userid" name="userid" placeholder="사용할 아이디를 입력하세요.">
                <p id="checkID"></p><br>
                비밀번호<br>
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요.">
                <p id="checkPW"></p><br>
                비밀번호확인<br>
                <input type="password" id="password1" name="password1" placeholder="비밀번호를 다시 한 번 입력해 주세요.">
                <p id="checkPW1"></p><br>
                이름<br>
                <input type="text" id="username" name="username" placeholder="이름을 입력해 주세요."><br>
                성별 :
                <input type="radio" id="gender_male" name="gender" value="남성">
                <label for="gender_male">남성</label>
                <input type="radio" id="gender_female" name="gender" value="여성">
                <label for="gender_female">여성</label><br>
                취미 :
                <input type="checkbox" id="all" name="all" onclick="selectAll(this)">
                <label for="all">전체선택</label>
                <input type="checkbox" id="music" name="hobbies" value="음악감상">
                <label for="music">음악감상</label>
                <input type="checkbox" id="movie" name="hobbies" value="영화보기">
                <label for="movie">영화보기</label>
                <input type="checkbox" id="sports" name="hobbies" value="스포츠">
                <label for="sports">스포츠</label>
                <input type="hidden" id="hobby" name="hobby"><br>
                직업 :
                <select style="width:600px;" name="job">
                    <option disabled selected>-- 아래의 내용 중에서 선택</option>
                    <option value="회사원">회사원</option>
                    <option value="공무원">공무원</option>
                    <option value="자영업">자영업</option>
                </select><br>
                주소 : <br>
                <input type="text" id="addrSearch" name="addrSearch"
                    placeholder="시/군/구 + 도로명, 동명 또는 건물명 예) 동해시 중앙로, 여수 중앙동, 대전 현대아파트" style="width:460px;" onkeydown="enterCheck()">
                <input type="button" id="btn_addrSearch" class="small" style="width:130px" value="주소검색" onclick="searchAddr()">
                <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" style="width:150px" readonly>
                <br><input type="text" id="addr1" name="addr1" placeholder="주소 검색 결과" readonly>
                <br><input type="text" id="addr2" name="addr2" placeholder="상세주소">
                <br><input type="hidden" id="address" name="address"><br>
                <br><input type="text" id="telno" name="telno" placeholder="010-1234-1234"><br>
                로그인 정보 분실 시 이용되므로 꼭 사용가능한 연락처와 이메일 주소를 입력해주세요.
                <br><input type="text" id="email" name="email" placeholder="example@website.com">
             	
                <br><p id="emailCheck"></p>
                <br><p>일반 사용자 권한으로 등록됩니다.</p>
                <br><textarea class="input_content" id="description" cols="100" rows="20" name="description"
                	style="width:600px; height:300px;"
                    placeholder="자기소개를 입력해주세요."></textarea><br>
            </form><!-- 회원 등록 Form End-->
        </div>
        <input type="button" class="button primary" align="center" id="btn_register" value="사용자 등록">
        <input type="button" class="button" align="center" value="뒤로가기" onclick="history.back()">
    </div><!-- main div End -->
</body>

</html>