<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%//세션 확인
 	if(session.getAttribute("userid") != null)
 	response.sendRedirect("/board/list");
%>
<%-- <% String userid=(String)session.getAttribute("userid"); // session의 반환타입이 object이기 때문에 string으로 캐스팅 한 userid(세션 생성한)를 가져옴   --%>
<%-- 	if(!userid.equals("marisol")) response.sendRedirect("/user/signup"); //userid가 생성되어있는 세션의 userid 값과 일치하지 않으면 singup으로 리디렉션. 로그인하지 않은 사용자의 접근을 막는 방식으로 자주 사용 --%>
<meta charset="UTF-8">
<title>로그인</title>
 
<style>
body { font-family: "나눔고딕", "맑은고딕" }
h1 { font-family: "HY견고딕" }
a:link { color: black; }
a:visited { color: black; }
a:hover { color: blue; }
a:active { color: red; }
#hypertext { text-decoration-line: none; cursor: hand; }
#topBanner {
       margin-top:10px;
       margin-bottom:10px;
       max-width: 500px;
       height: auto;
       display: block; margin: 0 auto;
}  
.login {
  width:900px;
  height:auto;
  padding: 20px, 20px;
  background-color:#FFFFFF;
  text-align:center;
  border:5px solid gray;
  border-radius: 30px;
}   
.userid, .username, .userpasswd {
  width: 80%;
  border: none;
  border-bottom: 2px solid #adadad;
  outline:none;
  color: #636e72;
  font-size:16px;
  height:25px;
  background: none;
  margin-top: 20px;
}
.bottomText {
  text-align: center;
  font-size: 20px;
}
.login_btn  {
  position:relative;
  left:40%;
  transform: translateX(-50%);
  margin-bottom: 40px;
  width:80%;
  height:40px;
  background: linear-gradient(125deg,#81ecec,#6c5ce7,#81ecec);
  background-position: left;
  background-size: 200%;
  color:white;
  font-weight: bold;
  border:none;
  cursor:pointer;
  transition: 0.4s;
  display:inline;
}
</style>
</head>

<body>
<script>
// ////////////////////패스워드 확인////////////
// $(document).ready(function(){
// 	$("#password").change(function(){
// 		$.ajax({
// 			url : "/user/pwCheck",
// 			type : "post",
// 			data : {"userid" : $("#userid").val(),
// 					"password" : $(#"password").val()},
// 			success : function(data){
// 					if(data == 0){
// 						$("#pwIDCheck").html("비밀번호가 일치하지 않습니다.");
// 						$("#password").val("").focus();
// 					}//else $("#pwIDCheck").html("사용 가능한 아이디입니다.");
				
// 				}
// 		});
		
// 	});
// });

/////////////로그인 처리////////////
function loginCheck(){
	
	document.loginForm.action = "/user/login";
 	document.loginForm.submit();

}

</script>

<div class="main" align="center">
	<div> <!-- 상단 로고 -->
	    <img id="topBanner" src ="${pageContext.request.contextPath}/resources/images/logo.jpg" title="서울기술교육센터" >
	</div>
	<div class="login">
		<h1>로그인</h1>
		<form name="loginForm" id="loginForm" class="loginForm" method="post"> 
			<input type="text" name="userid" id="userid" class="userid" placeholder="아이디를 입력하세요.">
         	<input type="password" id="password" name="password" class="userpasswd" placeholder="비밀번호를 입력하세요.">
         	<br><br>
     		<input type="button" id="btn_login" class="login_btn" value="로그인" onclick="loginCheck()"> 
		</form>
		<p id="pwIDCheck" style="color:red;text-align:center;font-size: 15px;"></p>
		<div class="bottomText">
			사용자가 아니면 ▶<a href="/user/signup">여기</a>를 눌러 사용자등록을 해주세요.<br><br>
    	</div>
	</div> <!-- login div End -->
</div> <!-- main div End -->
</body>

</html>