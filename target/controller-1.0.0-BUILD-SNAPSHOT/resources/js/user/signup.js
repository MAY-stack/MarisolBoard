window.onload = () =>{
	
	// ----- 프로필 이미지 ----- //
		var profileImageCheck = "N";
		var imgZone = document.querySelector('#imageZone');
		var fileSelect = document.querySelector('#profileImage');
		
		// imgZone 클릭 -> selectFile 작동
		imgZone.addEventListener('click', function (e){
			fileSelect.click(e);
			});
		
		// 파일 선택(fileSelect)
		fileSelect.addEventListener('change', (e) => {
			const files = e.target.files;	//선택한 이미지의 정보를 files 배열에 담기
			var fileSelect = files[0];
			//선택 파일 유효성 확인
			if(fileSelect.type.indexOf("image") < 0) { alert("이미지 파일만 선택 가능합니다."); return false; }	//파일 유형 확인
			//if(fileSelect.size > 1024*1024) { alert("1MB 이하 파일만 올려주세요."); return false; }	//파일 크기 제한 필요 시
			
			showImage(files);	//이미지 미리보기 함수의 인자로 files 전달
			console.log(e.target.files);
		
		}); 
		
		// 선택한 이미지 파일 미리보기
		const showImage = (files) => {
			imgZone.innerHTML = '';
			const imgFile = files[0];
			const reader = new FileReader(); //new 연산자를 통해서 FileReader() 객체를 reader가 참조(상속)
			reader.onload = function(event){ //아래 img 태그로 만들어진 element에 이미지를 보낼거라는 걸 결정--> 파일을 읽고 나서 해야 할 일...
				imgZone.innerHTML = "<img src=" + event.target.result + " id='uploadImg' style='max-width: 590px; max-height: auto; margin:auto;'>";
				console.log(event.target.result);
			};
			
			reader.readAsDataURL(imgFile); //실제로 파일을 읽는 부분은 여기...
			profileImageCheck = "Y";
		}
	
	// ----- 프로필 이미지 끝----- //
	
	// -- 입력 정보 비동기 feedback
		// ID 사용 가능 여부
		const checkID = document.querySelector('#checkID');
		checkID.innerHTML = " ";
		userid.onchange = async () => {
			const userid = document.querySelector("#userid");
			await fetch('/user/idCheck',{		
				method: "POST",
				body: userid.value,		
			}).then((response) => response.text())
			  .then((data) => {		     
					if(data == 0) checkID.innerHTML = "사용 가능한 아이디입니다.";
					else checkID.innerHTML = "이미 사용중인 아이디 입니다. 다른 아이디로 입력해 주세요.";
			  });	
		}

		// 비밀번호 규칙 만족 여부
		password.onchange = () => {
			const inputPW = document.querySelector('#password').value;
			const checkPW = document.querySelector('#checkPW');
			
			let num = inputPW.search(/[0-9]/g); // 0-9까지의 숫자가 들어 있는지 검색. 검색이 안되면 -1을 리턴
			let eng = inputPW.search(/[a-z]/ig); //i : 알파벳 대소문자 구분 없이... 
			let spe = inputPW.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	//특수문자가 포함되어 있는가 검색
			
			if(inputPW.length < 8 || inputPW.length > 20) {
				checkPW.innerHTML = "암호는 8자리 ~ 20자리 이내로 입력해주세요.";
			}else if(inputPW.search(/\s/) != -1){
				checkPW.innerHTML = "암호는 공백 없이 입력해주세요.";
			} else if(num < 0 || eng < 0 || spe < 0 ){
				checkPW.innerHTML = "암호는 영문,숫자,특수문자를 혼합하여 입력해주세요."; 
			} else checkPW.innerHTML = " ";
		}
		
		//비밀번호 확인 일치 여부
		password1.onchange = () => {
			const inputPW = document.querySelector('#password').value;
			const inputPW1 = document.querySelector('#password1').value;
			const checkPW1 = document.querySelector('#checkPW1');
			if(inputPW!=inputPW1){
				checkPW1.innerHTML = "비밀번호가 일치하지 않습니다.";
			} else{checkPW1.innerHTML = " ";}
		}
	
		//이메일 주소 형식 적합 여부
		email.onchange = async () => {
			let Email = email.value;
			let emailCheck = document.querySelector('#emailCheck');
			let at = Email.search(/[@]/gi);
			let dot = Email.search(/[.]/gi);
			if(at < 0 || dot < 0) emailCheck.innerHTML = "올바르지 않은 이메일 형식입니다.";
			else emailCheck.innerHTML = "";
		}
	
	
	//-----정보 유효성 검사 후 가입 처리 시작----- //
		btn_register.onclick = async () => {
			let img = document.getElementsByName('fileUpload').name;
			//유효성 검사
			if(profileImageCheck == 'N') { alert("프로필 이미지를 등록하세요"); return false; }
			if(userid.value == '') { alert("아이디를 입력하세요."); userid.focus();  return false; }
			if(username.value == '') { alert("이름을 입력하세요."); username.focus(); return false; }
	
			const Pass = password.value;
			const Pass1 = password1.value;
			if(Pass == '') { alert("비밀번호를 입력하세요."); password.focus(); return false; }
			if(Pass1 == '') { alert("비밀번호확인을 입력하세요."); password1.focus(); return false; }
				
			const gender = document.querySelector('input[name=gender]:checked');	
			
			let hobby = document.querySelector('#hobby');
			const hobbies = document.querySelectorAll('input[name=hobbies]:checked');
			
			let hobbyArray = [];
			for(let i=0; i<hobbies.length; i++)
				hobbyArray.push(hobbies[i].value);
				console.log(hobbyArray);
			hobby.value = hobbyArray;
			console.log(hobby.value);
			const job = document.querySelector('select[name=job] option:checked');

			if(gender.value == '') { alert("성별을 선택하세요."); return false; }
			if(hobby.value == '') { alert("취미를 선택하세요."); return false; }
			if(job.value == '') { alert("직업을 선택하세요."); return false; }
			if(description.value == '') { alert("자기소개를 입력하세요."); description.focus(); return false; }
			
			if(zipcode.value == '') { alert("우편번호를 입력하세요."); zipcode.focus(); return false; }
			if(addr2.value == '') { alert("상세 주소를 입력하세요."); addr2.focus(); return false; }
			
			address.value = addr1.value + " " + addr2.value;
			
			if(telno.value == '') { alert("전화번호를 입력하세요."); telno.focus(); return false; }
			//전화번호 문자열 정리
			const beforeTelno = telno.value;
			const afterTelno = beforeTelno.replace(/\-/gi,"").replace(/\ /gi,"").trim();
			telno.value = afterTelno;
			
			//이메일 주소 검사
			let Email = email.value;
			if(Email == '') { alert("이메일주소를 입력하세요."); email.focus(); return false; }
			
			//검사 후 가입 처리 요청
			let formData = new FormData(RegistryForm);
			
			await fetch('/user/signup', {
				method: 'POST',
				body: formData,				
			}).then((response) => response.json())
			  .then((data) => {
				  if(data.status === 'good'){
					  alert(decodeURIComponent(data.username) + "님, 회원 가입을 축하 드립니다.");
					  document.location.href="/board/list?page=1";
				  } else {
					  alert("서버 장애로 회원 가입에 실패했습니다.");
				  }
			});
			
		}
	//-----정보 유효성 검사 후 가입 처리 끝----- //
		
	}
	
	// ----- 체크박스 모두 선택 처리----- //
	const selectAll = () => {
		console.log("done");
		const all = document.querySelector('#all');
		const checkboxes = document.getElementsByName("hobbies");
		if(all.checked){
		checkboxes.forEach((checkboxes) => {
			checkboxes.checked = true;
		});}else{
		checkboxes.forEach((checkboxes) => {
			checkboxes.checked = false;
		});} 
	}
	
	//----- 주소(우편번호) 검색----- //
	const searchAddr = () => {
	
		if(addrSearch.value =='') {			//-> id 는 그 자체로 element로 인식해서 select 할 수 있음
			alert("검색할 주소를 입력하세요.");
			addrSearch.focus();
			return false;
		}
	
		window.open(	//모바일에서는 잘 안먹어서 안쓰는 추세이긴 함
				  "/user/addrSearch?page=1&addrSearch=" + addrSearch.value,	//새창으로 볼 url
				  "회원가입 | 주소검색",	//브라우저 이름
				  "width=930, height=540, top=50, left=50"		//창의 크기 //다른 옵션들도 더 많음.. 	          
		);
	}
	//-----Enter onkeydown -> 주소(우편번호) 검색----- //
	function enterCheck(){
		if(event.keyCode == 13){searchAddr();return;}
	}