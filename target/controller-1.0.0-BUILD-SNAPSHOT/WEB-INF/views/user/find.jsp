<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기 | 게시판</title>
</head>
<script src="/resources/js/user/find.js"></script>
<body>
<h1><a href="/board/list?page=1">🌈BOARD📋</a></h1>
    <div id="findData">
        이름<input type ="text" id="username">
        연락처<input type="text" id="telno">
        <button id="btn_find_id">제출?</button>
    </div>

    <div id="result">
    아이디 찾기 결과 :
    <span id = "showMaskingId"></span>
    </div>
       
    비밀번호 찾기
    <div id="resetPwData">
        
        아이디<input type ="text" id="userid_pw">
        이름<input type ="text" id="username_pw">
        연락처<input type="text" id="telno_pw">
        <button id="btn_reset_pw">제출?</button>
        <span id="showMaskingEmail" style="display:none"></span><br>

    </div>

</body>

</html>