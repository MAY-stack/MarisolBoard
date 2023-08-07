window.onload = () => {

	let btn_submit = document.querySelector('#btn_submit');

	btn_submit.onclick = async () => {

		let password = document.querySelector('#password');
		let userid = document.querySelector('#userid');

		var checkString = { "userid" : userid.value,
							"password" : password.value };

 		await fetch("/user/pwCheck", { //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
            method: 'POST',
            headers: {
                "content-type": "application/json"
            },
            body: JSON.stringify(checkString)
        }).then((response) => response.json())
            .then((data) => {
                    if(data.message == "good") {
						console.log(data.message);
						document.location.href = '/user/setpw?userid=' +userid.value;
                        } else if (data.message == "bad"){
						alert('비밀번호가 일치하지 않습니다.');
						return false;
					}
            }).catch((error) => {
                alert('시스템 장애로 정보를 확인하지 못했습니다.');
                console.log("error = " + error);
            });

	}

}