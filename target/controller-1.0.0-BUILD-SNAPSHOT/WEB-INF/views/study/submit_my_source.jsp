<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<srcipt>
/****************회원가입 처리 요청*******************/
btnRegister.addEventListener('click', async () => {
	/*입력 정보 유효성 검사*/
	if(imgCheck == 'N') { alert("프로필 이미지를 등록하세요."); return false; }	//프로필 이미지 등록 여부
	if(userid.value == '') { alert("아이디를 입력하세요."); userid.focus();  return false; }	//아이디 입력 여부
	if(username.value == '') { alert("이름을 입력하세요."); username.focus(); return false; } //사용자이름 입력 여부
	
	/*비밀번호*/
	let Pass = password.value;	
	let Pass1 = password1.value;
	
	//비밀번호 입력 여부
	if(Pass == '') { alert("암호를 입력하세요."); password.focus(); return false; }
	if(Pass1 == '') { alert("암호를 입력하세요."); password1.focus(); return false; }
	//비밀번호 - 비밀번호확인 일치 여부
	if(Pass != Pass1) 		
		{ alert("입력된 비밀번호를 확인하세요"); password1.focus(); return false; }	

	// (비밀번호) 암호유효성 검사(자바스크립트의 정규식)
	let num = Pass.search(/[0-9]/g); 	// [0~9] : 0~9까지의 숫자가 들어 있는지 검색 -> 검색되지 않으면 -1 반환, g : 글로벌 검색
	let eng = Pass.search(/[a-z]/ig); 	//i : 알파벳 대소문자 구분 없이 검색 -> 검색되지 않으면 -1 반환
	let spe = Pass.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); //특수문자가 포함되어 있는지 검색
	if(Pass.length < 8 || Pass.length > 20) { alert("암호는 8자리 ~ 20자리 이내로 입력해주세요."); return false; }
	else if(Pass.search(/\s/) != -1){ alert("암호는 공백 없이 입력해주세요."); return false; }
	else if(num < 0 || eng < 0 || spe < 0 ){ alert("암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."); return false; }
	
	const gender = document.querySelector('input[name=gender]:checked');	//이름으로 값을 가져오기, 같은 이름의 여러개의 값 중 체크 된 것을 가져오라는 옵션

	const hobby = document.querySelectorAll('input[name=hobbies]:checked');//querySelectorAll : 여러개의 값을 가져 오는 메소드
	let hobbyArray = []; //가져온 hobbies의 값을 배열로 만들어 줌
	for(let i=0; i<hobby.length; i++)
		hobbyArray.push(hobby[i].value);
	const job = document.querySelector('select[name=job] option:checked');
	
	// 추가정보의 유효성 검사
	if(gender.value == '') { alert("성별을 선택하세요."); return false;}
	if(hobby.value == '') { alert("취미을 선택하세요."); return false;}
	if(job.value == '') { alert("직업을 선택하세요."); return false;}
	if(description.value == '') { alert("자기소개를 입력해주세요."); description.focus(); return false;}
	
	if(zipcode.value == '') { alert("우편번호를 입력하세요."); zipcode.focus(); return false; }
	if(addr2.value == '') { alert("상세 주소를 입력하세요."); addr2.focus(); return false; }
	address.value = (addr1.value + " " + addr2.value);	//검색 주소와 상세주소 합치기
	
	if(telno.value == '') { alert("전화번호를 입력하세요."); telno.focus(); return false; }
	//전화번호 문자열 정리
	const beforeTelno = telno.value;
	const afterTelno = beforeTelno.replace(/\-/gi,"").replace(/\ /gi,"").trim();	//-나 공란 등 입력 될 시 공백으로 대체, .trim() : 앞뒤의 공백을 제거하는 메소드
	telno.value = afterTelno;
	
	//이메일 주소의 유효성 검사
	let email = email.value;
	if(email.value == '') { alert("이메일주소를 입력하세요."); email.focus(); return false; }
		//let at = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	
/*유효성 검사 후 처리요청 submit*/
	//$("#RegistryForm").attr('action', '/user/signup').submit(); => 

	//let formData = new FormData();
	//formData.append("userid", userid.value) 와같이 하나씩 조합해서 보낼 수도 있고
	//폼의 id를 받아서바로 처리도 가능함
	let formData = new FormData(RegistryForm);	//-> 자동으로 시리얼라이즈드 하고 비동기 식으로 보낼 수 있고 편하다...
	//아래와 결과는 값음
	
	/**********************************************
	document.RegistryForm.action = '';
	document.RegistryForm.submit(); -> 이렇게 보냈을 때는 form문 내의 값들을 serialization 해서 전달 하는 것임
	※ jQuery에서 보내기 위해서는
		${'#RegistryForm'}.serialize() 식으로 보내줘야 함.
	************************************************/
	//-> 데이터를 객체에 담아서 보내기로 바꾸기
	//데이터를 보낼 자바스트립트 객체 data 생성 -> 파일 첨부 위해서 다른 형식으로 바꿈
// 	const data = {		
// 		userid: userid.value,
// 		username: username.value,
// 		password: password.value,
// 		gender: gender.value,
// 		hobby: hobbyArray.toString(),
// 		job: job.value,
// 		description: description.value,
// 		zipcode: zipcode.vlue,
// 		address: address.vlue,
// 		telno: telno.vlue,
// 		email: email.vlue,		
// 	}
	await fetch('/user/signup', {
// 		headers: {	//-> formData로 보내면 이부분은 필요 없음
// 			"content-type": "application/json"	//내용의 타입이 json임을 명시
// 		},		
		method: "POST",	//parse: javascript=>Json으로 바꾸는 것
		//body: JSON.stringify(data)
		body: formData,
		//JSON.parse(): JSON 문자열을 JavaScript 객체로 변환
		//JSON.stringify(): JavaScript 객체를 JSON 문자열로 변환
		
	}).then((response) => response.json())
	  .then((data)=>{
		if(data.status === 'good'){
		 alert(data.username + "님 회원 가입을 축하드립니다.");
		 document.location.href = "/board/list?page=1";
		}else {
			alert("서버 장애로 회원가입에 실패했습니다.");
		}
	});//promise
});
</script>

</body>
</html>