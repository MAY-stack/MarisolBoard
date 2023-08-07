window.addEventListener('load', async () => {
    //getCookie 함수 정의
    const getCookie = (name) => {
        const cookies = document.cookie.split(';').map((el) => el.split('='));
            let getItem = [];
            for (let i =0; i < cookies.length;i++){
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

//----- keyword로 검색한 목록 요청 -----//
const search = () => {
	const keyword = document.querySelector('#keyword');
	document.location.href="/board/list?page=1&keyword="+keyword.value;
}
//----- Enter keydown으로 검색 요청 -----//
function press(){
	if(event.keyCode == 13){search();return;}
}

//----- 로그아웃-----//
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
	const logout = () => {
		let authkey = getCookie('authkey');
		if(confirm('로그아웃 하시겠습니까?')){
			if(authkey !== undefined){
				document.cookie = 'authkey=' + authkey + '; path=/; max-age=0;';
			} document.location.href='/user/logout';
	
		}
	}