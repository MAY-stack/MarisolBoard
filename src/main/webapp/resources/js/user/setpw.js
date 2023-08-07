window.onload = () => {
    // 비밀번호 규칙 만족 여부
    password.onchange = () => {
        const inputPW = document.querySelector('#password').value;
        const checkPW = document.querySelector('#checkPW');
			
        let num = inputPW.search(/[0-9]/g); // 0-9까지의 숫자가 들어 있는지 검색. 검색이 안되면 -1을 리턴
        let eng = inputPW.search(/[a-z]/ig); //i : 알파벳 대소문자 구분 없이... 
        let spe = inputPW.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);	//특수문자가 포함되어 있는가 검색
			
        if (inputPW.length < 8 || inputPW.length > 20) {
            checkPW.innerHTML = "암호는 8자리 ~ 20자리 이내로 입력해주세요.";
        } else if (inputPW.search(/\s/) != -1) {
            checkPW.innerHTML = "암호는 공백 없이 입력해주세요.";
        } else if (num < 0 || eng < 0 || spe < 0) {
            checkPW.innerHTML = "암호는 영문,숫자,특수문자를 혼합하여 입력해주세요.";
        } else checkPW.innerHTML = " ";
    }
		
    //비밀번호 확인 일치 여부
    password1.onchange = () => {
        const inputPW = document.querySelector('#password').value;
        const inputPW1 = document.querySelector('#password1').value;
        const checkPW1 = document.querySelector('#checkPW1');
        if (inputPW != inputPW1) {
            checkPW1.innerHTML = "비밀번호가 일치하지 않습니다.";
        } else { checkPW1.innerHTML = " "; }
    }

}

window.addEventListener('load', () => {
    
    var btn_setpw = document.querySelector('#btn_setpw');
    btn_setpw.onclick = async () => {

        let password = document.querySelector('#password');
        let password1 = document.querySelector('#password1');
        let userid = document.querySelector('#userid');
        
        var dataString = { "userid": userid.value, "password": password.value };

        if (password.value != password1.value) {
            alert('비밀번호가 일치하지 않습니다,');
            return false;
        } else {
            await fetch('/user/setpw', {
                method: 'POST',
                headers: {
                "content-type": "application/json"
                },
                body: JSON.stringify(dataString),
            }).then((response) => response.json())
                .then((data) => {
                    if (data.message === 'good') {
                        console.log(data.message);
                        alert('처리되었습니다.')
                        document.location.href = "/user/mypage?userid="+userid.value;
                    } else {
                        alert("서버 장애로 비밀번호 변경에 실패했습니다.");
                    }
                });
        }
    }

});