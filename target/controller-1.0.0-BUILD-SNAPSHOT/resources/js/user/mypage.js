var profileImageChange='N';

window.onload = () =>{
	//직업 select
	let org_job = document.querySelector('#org_job');
	let job = document.querySelector('#job');
	
	for(let i=0; i<job.options.length; i++){
	
		if(job.options[i].value == org_job.value){
			job.options[i].selected = true;
		}
	
	}
	
	//취미 check
    let org_hobbies = document.querySelector('#org_hobbies');
    let org_hobby = org_hobbies.value.split(',');
	let hobbyCheckBox = document.querySelectorAll('.hobby');
	
	for(let i = 0; i < org_hobby.length; i++) {
    	for (let k = 0; k < hobbyCheckBox.length; k++){
        	if(org_hobby[i] == hobbyCheckBox[k].value){
                hobbyCheckBox[k].checked = true;
			}
        }
    }

}

window.addEventListener('load', () =>{
	//-- 프로필 이미지 --//
	let imgZone = document.querySelector('#imageZone');
	var fileSelect = document.querySelector('#profileImage');

	// imgZone 클릭 -> selectFile 작동
	imgZone.onclick = (e) => {
		fileSelect.click(e);
	}
	
	// 파일 선택(fileSelect)
	fileSelect.onchange = (e) => {
		//선택한 이미지 정보 files에 담기
		const files = e.target.files;
		var fileSelect = files[0];
		
		//선택 파일 유효성 확인
		if(files.length != 0){
			if(fileSelect.type.indexOf("image") < 0) {	//파일 종류 확인
				alert("이미지 파일만 선택 가능합니다.");
				return false; 
			}
			//if(fileSelect.size < 10) { alert("1MB 이하 파일만 올려주세요."); return false; }	//파일 크기 제한 필요 시
		showImage(files);	//이미지 미리보기 함수의 인자로 files 전달
		}
	}

	// 선택 이미지 미리보기
	const showImage = (files) => {

		const reader = new FileReader();
		const imgFile = files[0];
		
		reader.onload = (event) => {
		
			let img_cancle = document.querySelector('#img_cancle');
			
			imgZone.innerHTML = "<img src=" + event.target.result + " id='uploadImg' style='width:350px;height:auto'>";
			img_cancle.style.display="inline";

		}

		reader.readAsDataURL(imgFile);		
		profileImageChange = "Y";

	}

	//이미지 선택 취소
	img_cancle.onclick = (files) => {
		files.is_delete = true;	//.is_delete 객체가 삭제 되었는지 확인하는 boolean 타입 담는 내장 객체
		
		document.querySelector('#uploadImg').innerHTML = "";
		
		profileImageChange = "N";

		let stored_filename = document.querySelector('#stored_filename').value;
		imgZone.innerHTML = "<img src= /profile/" + stored_filename + " style='width:300px; height:auto;'> <br>"
	}
	// ----- 프로필 이미지 끝----- //
	
	//이메일 주소 형식 적합 여부
	email.onchange = async () => {
		let Email = email.value;
		let emailCheck = document.querySelector('#emailCheck');
		let at = Email.search(/[@]/gi);
		let dot = Email.search(/[.]/gi);
		if(at < 0 || dot < 0) emailCheck.innerHTML = "올바르지 않은 이메일 형식입니다.";
		else emailCheck.innerHTML = "";
	}
	
	
//-----정보 유효성 검사 후 정보 수정----- //
	btn_modify.onclick = async () => {

		const hobby = document.querySelectorAll('input[name=hobby]:checked');
		let hobbyArray = [];
		for(let i=0; i<hobby.length; i++)
			hobbyArray.push(hobby[i].value);
			console.log(hobbyArray);
		const job = document.querySelector('select[name=job] option:checked');

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
		
		//검사 후 수정 처리 요청
		let uiForm = document.getElementById('UserInfoForm');
		let formData = new FormData(uiForm);

		if(profileImageChange == "Y"){
			formData.append("profileImageChange", "Y");
		} else formData.append("profileImageChange", "N");
		await fetch('/user/infomodify', {
			method: 'POST',
			body: formData,			
		}).then((response) => response.json())
			.then((data) => {
				if(data.msg === 'good'){
					alert("수정 되었습니다.");
					var profileImageChange = "N"
					document.location.href="/board/list?page=1";
				} else {
					var profileImageChange = "N"
					alert("서버 장애로 정보 수정에 실패했습니다.");
				}
		});
	}//-----정보 유효성 검사 & 정보 수정 끝----- //
});

window.addEventListener('load', () => {

	//hobby 모두 선택&해제
	all.onclick = () => {
		
		let checkboxes = document.getElementsByName("hobby");		
		if(all.checked){
			
			checkboxes.forEach((checkboxes) => {
				checkboxes.checked = true;
			});

		}else{
			checkboxes.forEach((checkboxes) => {
				checkboxes.checked = false;
			});
		}
	}

	//주소 (우편번호) 검색
	btn_addrSearch.onclick = searchAddr = () => {

		if(addrSearch.value =='') {
			alert("검색할 주소를 입력하세요.");
			addrSearch.focus();
			return false;
		}
		window.open("/user/addrSearch?page=1&addrSearch=" + addrSearch.value,	//주소 검색 창 URL
					"마이페이지 | 주소검색",	//브라우저 title
					"width=930, height=540, top=50, left=50"	//브라우저 크기
					);
	}

	//Enter onkeydown -> searchAddr()
	addrSearch.onkeydown = (e) => {
		if(e.keyCode == 13){
			searchAddr();return;
		}
	}
	
	//취소 버튼 > 뒤로가기
	btn_cancel.onclick = () => {
		history.back();
	}
});