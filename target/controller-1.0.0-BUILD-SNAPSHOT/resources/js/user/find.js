window.onload = () => {
	let username = document.querySelector('#username');
    let telno = document.querySelector('#telno');

    let showMaskingId = document.querySelector('#showMaskingId');
    let btn_find = document.querySelector('#btn_find');

    btn_find_id.onclick = findInfo = async () => {
        var maskingId = "";
        var findDataString = { "username" : username.value,
                                "telno" : telno.value };

        console.log(findDataString);

        await fetch("/user/find", { //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
            method: 'POST',
            headers: {
                "content-type": "application/json"
            },
            body: JSON.stringify(findDataString)
        }).then((response) => response.json())
            .then((data) => {
                    if(data.message == "good") {
                        maskingId = data.userid;
                        console.log(maskingId);           
                        } else if (data.message == "bad"){
                        alert('정보가 일치하는 회원이 없습니다.');
                        }
            }).catch((error) => {
                alert('시스템 장애로 아이디를 확인하지 못했습니다.');
                console.log("error = " + error);
            });

        showMaskingId.innerHTML = maskingId;

        console.log(maskingId);

        let result = document.querySelector('#result');        
    }

    let userid_pw = document.querySelector('#userid_pw');
    let username_pw = document.querySelector('#username_pw');
    let telno_pw = document.querySelector('#telno_pw');
    let btn_reset_pw = document.querySelector('#btn_reset_pw');
    let showMaskingEmail = document.querySelector('#showMaskingEmail');
    btn_reset_pw.onclick = resetPw = async () => {
	
        var findDataString = { "userid" : userid_pw.value,
                                "username" : username_pw.value,
                                "telno" : telno_pw.value };

        console.log(findDataString);

        await fetch("/user/resetpw", { //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
            method: 'POST',
            headers: {
                "content-type": "application/json"
            },
            body: JSON.stringify(findDataString)
        }).then((response) => response.json())
            .then((data) => {
                if(data.message == "good") {
                        alert('가입시 입력한 메일로 임시비밀번호가 발급되었습니다.');
                        showMaskingEmail.style.display = 'inline-block';
                        showMaskingEmail.innerHTML = data.email;
                        console.log(data.email);
                    } else if (data.message == "bad"){
                        alert('정보가 일치하는 회원이 없습니다.');
                    }
            }).catch((error) => {
                alert('시스템 장애로 비밀번호를 확인하지 못했습니다.');
                console.log("error = " + error);
            });

        
    }
}