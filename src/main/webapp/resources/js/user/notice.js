window.addEventListener('load', async () => {
    //getCookie 함수 정의
    const getCookie = (name) => {
        const cookies = document.cookie.split(';').map((el) => el.split('='));
            let getItem = [];
            for (let i =0; i < cookies.length; i++){
                if(cookies[i][0].trim() === name) {
                    getItem.push(cookies[i][1]);
                    break;
                }
            }
            if(getItem.length > 0) {
                return decodeURIComponent(getItem[0]);
        }
    }
    
    //-----쿠키에서 정보 get-----//
    let userid = getCookie('userid');
    let password = getCookie('password');
    let authkey = getCookie('authkey');

    //아이디 쿠키
    if(userid != undefined) {	//쿠키가 존재 하면(이미 만들어진 상태에서 다시 페이지를 방문 했을 때)
        document.querySelector('#rememberUserId').checked = true;	//아이디 저장 -> 체크
        document.querySelector('#userid').value = userid;	//userid input에 쿠키의 아이디 띄움
    } else { 	//쿠키에 userid가 없으면
        document.querySelector('#rememberUserId').checked = false;   //아이디 저장 체크 X
    }
    
    //비밀번호 쿠키
    if(password != undefined) {	//쿠키가 존재 하면(이미 만들어진 상태에서 다시 페이지를 방문 했을 때)
        document.querySelector('#rememberPassword').checked = true;	//비밀번호 저장에 저장에 체크
        
        //Base 64로 인코딩 된 password를 디코딩
        const decrypt = CryptoJS.enc.Base64.parse(password);	//1차 디코딩
        const hashData = decrypt.toString(CryptoJS.enc.Utf8);	//2차 디코딩
            password = hashData;
        document.querySelector('#password').value = password; //해서 input에 password 띄워줌
    
    } else {    //쿠키에 pw 없으면 비밀번호 저장 체크 X
        document.querySelector('#rememberPassword').checked = false;    
    }
    
    //자동 로그인 쿠키 존재 -> 자동 로그인 처리
    if(authkey !== undefined) {

        let formData = new FormData();
        formData.append("authkey", authkey);
        await fetch('/user/login?autologin=PASS', {
            method: 'POST',
            body: formData,
        }).then((response) => response.json())
            .then((data) => {
            if(data.message == 'good'){
                document.location.href='/board/list?page=1';
            } else{
                alert('시스템 장애로 자동 로그인에 실패했습니다.<br>잠시후 다시 시도해주세요.');
            }
        }).catch((error) => {console.log("error =" + error);} );
    }
});
window.addEventListener('load', () => { 

	//Enter onkeydown으로 로그인 처리 요청//
	password.onkeydown = (event) => {
	    if(event.keyCode == 13){
	        login_Check();
	    }
	}

    //체크박스 동작 처리//
    const rememberUserId = document.querySelector("#rememberUserId");
    const rememberPassword = document.querySelector("#rememberPassword");
    const rememberMe = document.querySelector("#rememberMe");
    //아이디 저장 checkbox 
    rememberUserId.onclick = () => {
        if(rememberUserId.checked){
            //자동 로그인 체크 해제 시키기
            rememberMe.checked = false;
        }
    }
    //비밀번호 저장 checkbox 
    rememberPassword.onclick = () => {
        if(rememberPassword.checked){
            //자동 로그인 체크 해제 시키기
            rememberMe.checked = false;
        }
    }
    //자동 로그인 체checkbox 
    rememberMe.onclick = () => {
        if(rememberMe.checked){
            //자동 로그인 체크 시 아이디 비밀번호 저장 쿠키 삭제되고 토큰을 생성 하기 위해서 아이디, 비밀번호 저장 체크박스 해제 시키기
            rememberUserId.checked = false;
            rememberPassword.checked = false;
        }
    }
});
window.addEventListener('load', () => {
//-----입력 정보 유효성 검사 후 로그인 처리----//
    btn_login.onclick = login_Check = async () => {		

        //아이디 유효성 검사
        if(userid.value === '' || userid.value === null){
            alert("아이디를 입력하세요.");
            userid.focus();
            return false;
            }
        
        //패스워드 유효성 검사
        if(password.value === '' || password.value === null){
            alert("암호를 입력하세요.");
            password.focus();
            return false;
            }
        
        let formData = new FormData();
        formData.append("userid", userid.value);
        formData.append("password", password.value);
        
        //NEW : 로그인하면서 쿠키를 새로 생성
        //PASS : 이미 쿠키가 생성되어 있는 상태에서의 로그인
        await fetch('/user/login?autologin=NEW', {
            method: 'POST',
            body: formData,
        }).then((response) => response.json())
            .then((data) => {
                if(data.message ==='good'){
                    cookieManage(userid.value, password.value, data.authkey);
                    document.location.href='/board/list?page=1';
                } else if(data.message === 'ID_NOT_FOUND'){
                    alert('존재하지 않는 아이디입니다.');
                    userid.focus();
                } else if(data.message === 'PASSWORD_NOT_FOUND'){
                    alert('비밀번호가 일치하지 않습니다.');
                    password.focus();
                } else{
                    alert('시스템 장애로 로그인을 실패했습니다. 잠시후 다시 시도해주세요.');
                }
            }).catch((error) => {
                console.log("error = " + error);
            }); 	
    }
});
//----- 아이디 존재 여부 확인 -----//
window.addEventListener('load', () => {

	const checkID = document.querySelector('#checkID');
	checkID.innerHTML = " ";
    userid.onchange = async () => {

		const userid = document.querySelector("#userid");

		await fetch('/user/idCheck',{		
			method: "POST",
			body: userid.value,		
		}).then((response) => response.text())
		  .then((data) => {		     
				if(data == 0)
					checkID.innerHTML = "존재하지 않는 아이디 입니다. 다시 입력하세요.";
				else {
					checkID.innerHTML = " ";
				}
		  });
		
	}
});

//----- 체크 옵션에 따라 쿠키 생성삭제 처리 -----//
const cookieManage = (userid, password, authkey) => {

    // 아이디 쿠키
    if(rememberUserId.checked){	//쿠키 생성
        document.cookie = 'userid =' + userid + '; path =/; expires=Sun, 31 Dec 2023 23:59:59 GMT';
    } else {	//체크 하지 않고 로그인 시 쿠키 삭제
        document.cookie = 'userid =' + userid + '; path =/; max-age=0';
    }
    
    // 비밀번호 쿠키	
    if(rememberPassword.checked){	//쿠키 생성
        //Base64(양방향 복호화 64비트 알고리즘) 알고리즘을 이용한 비밀번호 암호화
        const key = CryptoJS.enc.Utf8.parse(password);	//패스워드값을 인코딩
        const base64 = CryptoJS.enc.Base64.stringify(key);
        password = base64;
        document.cookie = 'password =' + password + '; path =/; expires=Sun, 31 Dec 2023 23:59:59 GMT';
    } else {	//체크 하지 않고 로그인 시 쿠키 삭제
        document.cookie = 'password =' + password + '; path =/; max-age=0';		
    }
    
    // 자동로그인 Authkey 쿠키 
    if(rememberMe.checked){	//쿠키 생성
        document.cookie = 'authkey =' + authkey + '; path =/; expires=Sun, 31 Dec 2023 23:59:59 GMT';
    } else {	//체크 하지 않고 로그인 시 쿠키 삭제
        document.cookie = 'authkey =' + authkey + '; path =/; max-age=0';
    }
    
}