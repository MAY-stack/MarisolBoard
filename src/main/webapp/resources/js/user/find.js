window.onload = () => {

    let find_id_tab = document.querySelector('#find_id_tab');
    let find_pw_tab = document.querySelector('#find_pw_tab');

    
 /*   find_pw_tab.onclick= () =>{
        let find_pw_box = document.querySelector('#find_pw_box');
        let find_id_box = document.querySelector('#find_id_box');
        find_pw_box.setAttribute("style", "'margin: top -5px; padding-top: 30px;'");
        find_id_box.setAttribute("style", "'display:none; margin: top -5px; padding-top: 30px;'");
        }
*/
	// let username = document.querySelector('#username');
    // let telno = document.querySelector('#telno');

    // let find_id_result = document.querySelector('#find_id_result');
    // let btn_find_id = document.querySelector('#btn_find_id');

    // btn_find_id.onclick = findInfo = async () => {
    //     var result = "";
    //     var findDataString = { "username" : username.value,
    //                             "telno" : telno.value };

    //     console.log(findDataString);

    //     await fetch("/user/find", { //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
    //         method: 'POST',
    //         headers: {
    //             "content-type": "application/json"
    //         },
    //         body: JSON.stringify(findDataString)
    //     }).then((response) => response.json())
    //         .then((data) => {
    //                 if(data.message == "good") {
    //                     result = data.userid;
    //                     console.log(result);           
    //                     } else if (data.message == "bad"){
    //                     alert('정보가 일치하는 회원이 없습니다.');
    //                     }
    //         }).catch((error) => {
    //             alert('시스템 장애로 아이디를 확인하지 못했습니다.');
    //             console.log("error = " + error);
    //         });

    //     find_id_result.innerHTML = result;

    //     console.log(result);

                
    // }
    
    let userid_pw = document.querySelector('#userid_pw');
    let username_pw = document.querySelector('#username_pw');
    let telno_pw = document.querySelector('#telno_pw');
    let btn_reset_pw = document.querySelector('#btn_reset_pw');
    let find_pw_result = document.querySelector('#find_pw_result');
    
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
                        //showMaskingEmail.style.display = 'inline-block';
                        //showMaskingEmail.style.display = 'inline-block';
                        find_pw_result.innerHTML = "이메일 주소 : " + data.email;
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