<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
window.onload = () => {
let mailCheckBtn = document.querySelector('#mailCheckBtn');

	mailCheckBtn.onclick = async () => {
		let userEmail1 = document.querySelector('#userEmail1');
		let userEmail2 = document.querySelector('#userEmail2');
		let mailCheckInput = document.querySelector('#mailCheckInput');

	    const eamil = userEmail1.value + userEmail2.value // 이메일 주소값 얻어오기!
	    console.log('완성된 이메일 : ' + eamil); // 이메일 오는지 확인
	    const checkInput = mailCheckInput.value // 인증번호 입력하는곳 
	    
	    url = '/user/mailCheck?email=' + eamil;
	
	    await fetch(url)
	    .then((response) => response.text())
	    .then((data) => console.log(data));
	} // end send eamil
}
</script>
<body>
<div class="form-group email-form">
	 <label for="email">이메일</label>
	 <div class="input-group">
	<input type="text" class="form-control" name="userEmail1" id="userEmail1" placeholder="이메일" >
	<select class="form-control" name="userEmail2" id="userEmail2" >
	<option>@naver.com</option>
	<option>@daum.net</option>
	<option>@gmail.com</option>
	<option>@hanmail.com</option>
	 <option>@yahoo.co.kr</option>
	</select>
	</div>   
<div class="input-group-addon">
	<button type="button" class="btn btn-primary" id="mailCheckBtn">본인인증</button>
</div>
	<div class="mail-check-box">
<input class="form-control mail-check-input" id="mailCheckInput" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
</div>
	<span id="mail-check-warn"></span>
</div>
<script>
// // let signup_date = new Date();
// // signup_date = ${user.signup_date };
//  console.log('${user.signup_date }');
// const date1 = new Date('${user.signup_date }'); 
// console.log('date: ' + new Date('2023-05-21 12:49:52'));
// console.log('date1: ' + date1);
// //const adj_date1 = new Date(date1.setDate(date1.getDate()+3));


// const date2 = new Date(date1);
// const date3 = new Date('2023-05-21 12:49:52');
// console.log("date1 = " + date1);
// console.log("date2 = " + date2);
// console.log("date3 = " + date3);

// console.log("date1 == date3");
// console.log(date1 == date3);
// console.log("date1 >= date3");
// console.log(date1 >= date3);
// console.log("date1 <= date3"); 
// console.log(date1 <= date3);
// window.onload =() => {
// 	btn.onclick = async () => {
	
// 		let userid = document.querySelector('#userid').value;
// 	    let formData = new FormData();
// 	    formData.append("userid", userid );
// 	    await fetch('/test', {
// 	        method: 'POST',
// 	        body: formData,
// 	    }).then((response) => response.json())
// 	        .then((data) => {
// 	        if(data.pwex == 'N'){
// 	            console.log("비번 사용가능");
// 	        } else{
// 	        	console.log("비번 변경 ㄱ");
// 	        }
// 	    }).catch((error) => {console.log("error =" + error);} );
// 	}
// }
<!-- </script> -->

<form id="date_test" method="post">
<input id="userid" type="hidden" value="${user.userid }" >
</form>
<button id="btn"></button>

</body>
</html>