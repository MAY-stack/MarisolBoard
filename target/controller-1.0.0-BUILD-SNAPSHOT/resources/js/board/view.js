//게시글의 댓글 및 좋아요싫어요 보여주기
window.onload = startupPage = async () => {
	
	// 댓글 정보 가져와서 보여주기(replyList call
	var seqno = document.querySelector('#seqno');
	const data = { seqno: seqno.value };

	await fetch('/board/reply?option=L', {
		method: 'POST',
		headers: {"content-type":"application/json"},
		body: JSON.stringify(data)		
	}).then((response) => response.json())
		.then((data) => replyList(data))
		.catch((error)=> {
			console.log("error = " + error);
			alert("시스템 장애로 댓글을 가져오지 못했습니다.");
	});
	
	//좋아요 싫어요 보여주기
	var likeCnt = document.querySelector('#likeCnt');
	var dislikeCnt = document.querySelector('#dislikeCnt'); 
	
	var myLikeCheck = document.querySelector('#myLikeCheck'); 
	var myDislikeCheck = document.querySelector('#myDislikeCheck'); 
	
	var likeClick = document.querySelector('#likeClick');
	var disLikeClick = document.querySelector('#disLikeClick');
	
	var myChoice = document.querySelector('#myChoice');
	
	var username = document.querySelector('#username');		

	//게시글의 좋아요 싫어요 갯수 표시
	like.innerHTML = likeCnt.value;
	dislike.innerHTML = dislikeCnt.value;

	//선택된 항목 배경색 보여주기
	if(myLikeCheck.value == "Y") likeClick.style.backgroundColor="skyblue";
	else if(myDislikeCheck.value == "Y") disLikeClick.style.backgroundColor="skyblue";

	//선택 항목에 대한 안내문구
	if(myLikeCheck.value == "Y") myChoice.innerHTML = username.value + "님은 좋아요♥를 선택하셨네요."; 
		else if(myDislikeCheck.value == "Y") myChoice.innerHTML = username.value + "님은 싫어요♡를 선택하셨네요."; 
		else if(myLikeCheck.value == "N" && myDislikeCheck.value == "N") myChoice.innerHTML = username.value + "님은 아직 선택을 안하셨네요.";
}

window.addEventListener('load', () => {
//-- 좋아요 싫어요 처리 Start--//

	var seqno = document.querySelector('#seqno');

	var likeCnt = document.querySelector('#likeCnt').value;
	var dislikeCnt = document.querySelector('#dislikeCnt').value; 

	var myLikeCheck = document.querySelector('#myLikeCheck').value; 
	var myDislikeCheck = document.querySelector('#myDislikeCheck').value; 

	var likeClick = document.querySelector('#likeClick');
	var disLikeClick = document.querySelector('#disLikeClick');

	var myChoice = document.querySelector('#myChoice');

	var username = document.querySelector('#username').value;	

	// 좋아요 처리하는 6가지 경우
	likeClick.onclick = () => { 	
		console.log("??");
		if(myLikeCheck == "Y" && myDislikeCheck == "N") {
			alert("좋아요를 취소합니다."); 
			var checkCnt = 1;  //likeCnt --;
			myLikeCheck = "N";
			sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
			document.querySelector('#likeClick').style.backgroundColor="#d2d2d2";
		}else if(myLikeCheck == "N" && myDislikeCheck =="Y") {
			alert("싫어요가 취소되고 좋아요가 등록됩니다.");
			var checkCnt = 2; // likeCnt ++ , dislikeCnt --
			myLikeCheck = "Y";
			myDislikeCheck = "N";
			sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
			document.querySelector('#likeClick').style.backgroundColor="skyblue";
			document.querySelector('#disLikeClick').style.backgroundColor="#d2d2d2";
		} else if(myLikeCheck == "N" && myDislikeCheck =="N") {
			alert("좋아요를 선택 했습니다.")
			var checkCnt = 3; //likeCnt ++
			myLikeCheck = "Y";
			sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
			document.querySelector('#likeClick').style.backgroundColor="skyblue";
		}
		if(myLikeCheck == "Y") document.querySelector('#myChoice').innerHTML = username + "님은 좋아요♥를 선택하셨네요."; 
		else if(myDislikeCheck == "Y") document.querySelector('#myChoice').innerHTML = username + "님은 싫어요♡를 선택하셨네요."; 
		else if(myLikeCheck == "N" && myDislikeCheck == "N") document.querySelector('#myChoice').innerHTML = username + "님은 아직 선택을 안하셨네요.";

	}

	// 싫어요 처리하는 6가지 경우

	disLikeClick.onclick = () => {	
		if(myDislikeCheck == "Y" && myLikeCheck =="N") {
			alert("싫어요를 취소합니다."); 
			var checkCnt = 4; // dislikeCnt --
			myDislikeCheck = "N";
			sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
			document.querySelector('#disLikeClick').style.backgroundColor="#d2d2d2"; 
		} else if(myDislikeCheck = "N" && myLikeCheck =="Y") {
			alert("좋아요가 취소되고 싫어요가 등록됩니다.");
			var checkCnt = 5; //likeCnt -- , dislikeCnt ++            
			myLikeCheck = "N";            
			myDislikeCheck = "Y";
			sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
			document.querySelector('#likeClick').style.backgroundColor="#d2d2d2"; 
			document.querySelector('#disLikeClick').style.backgroundColor="skyblue";
		} else if(myDislikeCheck = "N" && myLikeCheck =="N") {
			alert("싫어요를 선택했습니다.");
			var checkCnt = 6; //dislikeCnt ++
			myDislikeCheck = "Y";
			sendDataToServer(myLikeCheck,myDislikeCheck,checkCnt);
			document.querySelector('#disLikeClick').style.backgroundColor="skyblue";
		}
		if(myLikeCheck == "Y") document.querySelector('#myChoice').innerHTML = username + "님은 좋아요♥를 선택하셨네요."; 
		else if(myDislikeCheck == "Y") document.querySelector('#myChoice').innerHTML = username + "님은 싫어요♡를 선택하셨네요."; 
		else if(myLikeCheck == "N" && myDislikeCheck == "N") document.querySelector('#myChoice').innerHTML = username + "님은 아직 선택을 안하셨네요.";
	}
	
});

//좋아요 싫어요 데이터 서버로 보내기
const sendDataToServer = async (myLike, myDislike, checkCount) => {

	let seqno = document.querySelector('#seqno');
	let userid = document.querySelector('#userid');
	let myLikeCheck = myLike;
	let myDislikeCheck = myDislike;
	const checkCnt = checkCount;
	
	var queryString = {"seqno":seqno.value,
						"userid":userid.value,
						"mylikecheck":myLikeCheck,
						"mydislikecheck":myDislikeCheck,
						"checkCnt": checkCnt,
						};
	await fetch("/board/likeCheck", { //JSON --> MAP 타입일 경우 contentType를 반드시 입력...
		method: 'POST',
		headers: {
			"content-type": "application/json"
		},
		body: JSON.stringify(queryString)	
	}).then((response) => response.json())
	  .then((data)=> {			  
		like.innerHTML = data.likeCnt;
		dislike.innerHTML = data.dislikeCnt;
	}).catch((error)=> {
		console.log("error = " + error);
	});	
}

//-- 댓글 처리 부분 Start--//
//댓글 리스트 생성
const replyList = (data) => {

	var session_userid = document.querySelector('#userid');
	const jsonInfo = data;
	
	let replyList = document.querySelector('#replyList');
	replyList.innerHTML = "";
	
	var result = "";
	for(const i in jsonInfo){
		
		let elm = document.createElement('div'); //<div></div>
		elm.setAttribute("id", "s" + data[i].replyseqno); //<div id='s3'></div>
		elm.setAttribute("style", "font-size: 0.8em"); //<div id='s3' style='font-size: 0.8em'></div>
		
		let result = "";

		result += "작성자 : " + jsonInfo[i].replywriter;
						
		if(jsonInfo[i].userid == session_userid.value) {
			result += "[<a href=" + "'javascript:replyModify(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>수정</a> | " ;
			result += "<a href=" + "'javascript:replyDelete(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer;'>삭제</a>]" ;
		}
		
		result += "&nbsp;&nbsp;" + jsonInfo[i].replyregdate
		result += "<div style='width:90%; height: auto; border-top: 1px solid gray; overflow: auto;'>";
		result += "<pre id='c" + jsonInfo[i].replyseqno + "'>" + jsonInfo[i].replycontent + "</pre></div>";
		result += "<br>";
		
		elm.innerHTML = result;
		replyList.appendChild(elm);
		
	}
	
}
	
	
//댓글 등록 수정 삭제

window.addEventListener('load', () => {

	var seqno = document.querySelector('#seqno');
	var session_userid = document.querySelector('#userid');
	var username = document.querySelector('#username');

	//댓글 등록
	btn_reply.onclick= async () => { //form 데이터 전송 --> 반드시 serialize()를 해야 한다.
		
		const replycontent = document.querySelector('#replycontent');
		
		if(replycontent.value == '') {
			alert("댓글을 입력하세요."); 
			replycontent.focus();
			return false;
		}

		const data = {			
			replywriter: replywriter.value, 
			replycontent: replycontent.value,
			userid: userid.value,
			seqno: seqno.value,			
		}
		
		await fetch('/board/reply?option=I', {
			method: 'POST',
			headers: {"content-type":"application/json"},
			body: JSON.stringify(data)		
		}).then((response) => response.json())
			.then((data) => replyList(data))
			.catch((error)=> {
				console.log("error = " + error);
				alert("시스템 장애로 댓글 등록을 실패했습니다.");
		});
		
		replycontent.value = '';
	
	}
	
	//댓글 작성 취소
	btn_reply_cancle.onclick = () => { 
		if(confirm("정말로 취소 하시겠습니까?") == true) { 
			replycontent.value = ''; 
			replycontent.focus(); 
		}
	}

});
	
//댓글 삭제
const replyDelete = async (replyseqno) => { 

	var seqno = document.querySelector('#seqno');
	if(confirm("정말로 삭제하시겠습니까?") == true) {

		const data = { replyseqno: replyseqno, seqno: seqno.value };
		
		await fetch('/board/reply?option=D',{
			method: 'POST',
			headers: {"content-type": "application/json"},
			body: JSON.stringify(data)
		}).then((response) => response.json())
			.then((data) => replyList(data))
			.catch((error) => {
				console.log("error =" + error);
				alert("서버 장애로 댓글 삭제를 실패했습니다.");
		});
	
	}

}

//댓글 수정
const replyModify = (replyseqno) => {

	const modifyReplyContent = document.querySelector('#c' + replyseqno);
	var session_userid = document.querySelector('#userid');
	var strReplyList = "작성자 : " + session_userid.value + "&nbsp;"
					+ "<input type='button' id='btn_replyModify' value='수정'>"
					+ "<input type='button' id='btn_replyModifyCancel' value='취소'>"
					+ "<input type='hidden' name='replyseqno' value='" + replyseqno + "'>"
					+ "<input type='hidden' name='seqno' value='seqno.value'>"
					+ "<input type='hidden' id='writer' name='replywriter' value='session_username.value'>"
					+ "<input type='hidden' id='uerid' name='userid' value='session_userid.value'><br>"
					+ "<textarea id='modify_replycontent' name='replycontent' cols='80' rows='5' maxlength='150' placeholder='글자수:150자 이내'>" + modifyReplyContent.innerHTML + "</textarea><br>";
	
	let elm = document.createElement('div');
	elm.innerHTML = strReplyList;
	
	let parentDiv = document.querySelector('#s' + replyseqno).parentNode;
	parentDiv.insertBefore(elm, document.querySelector('#s' + replyseqno));
	document.querySelector('#s' + replyseqno).style.display = 'none';
	
	const btnReplyModify = document.querySelector('#btn_replyModify');
	const btnReplyModifyCancel = document.querySelector('#btn_replyModifyCancel');
	
	//댓글 수정 등록
	btnReplyModify.onclick = async ()=> {
	
		const data = {
			replyseqno: replyseqno,
			replycontent: modify_replycontent.value
		};
		
		await fetch('/board/reply?option=U',{
		
			method: 'POST',
			headers: {
				"content-type": "application/json"
			},
			body: JSON.stringify(data)
		}).catch((error) => {
			console.log("error = " + error);
			alert("서버 장애로 댓글 수정이 실패했습니다.");
		});
		
		document.querySelector('#replyList').innerHTML = '';
		startupPage();				
		
	}
	
	//댓글 수정 취소
	btnReplyModifyCancel.addEventListener('click',()=> {
		if(confirm("정말로 취소하시겠습니까?") == true){
			document.querySelector('#replyList').innerHTML = '';
			startupPage();	
		}
	});
	
}
//-- 댓글 처리 End--//

//-- 버튼 동작 처리 --//
window.addEventListener('load', () => {
	
	//수정 삭제
	var seqno = document.querySelector('#seqno');
	var page = document.querySelector('#page');
	var keyword = document.querySelector('#keyword');
	var userid = document.querySelector('#userid');
	var modify_authority = document.querySelector('#modify_authority');

	btn_modify.onclick = () => {	//#btn_modify에 대해 click이 발생하면 function을 실행 하도록 함		
		if(modify_authority.value == "true")		// 수정권한이 있는 경우	
			document.location.href="/board/modify?seqno=" + seqno.value + "&page=" + page.value + "&keyword="+ keyword.value;	//수정 화면으로 이동
		else alert_invalid();
	}
	btn_delete.onclick = () => {
		if(modify_authority.value == "true"){	// 수정권한이 있는 경우
			if(confirm("정말로 삭제하시겠습니까?")) document.location.href="/board/delete?seqno=" + seqno.value;
		} else alert_invalid();
	}
		
	//권한 없는 사용자의 요청
	function alert_invalid(){
		var msg;
		alert('수정/삭제 권한이 없습니다.');	
	}

	/*******************이전글/다음글 이동*******************************/
	
	btn_preV.onclick = () => {		
		let pre_seq = document.querySelector('#pre_seq').value;
		let preV_PageNum = document.querySelector('#preV_PageNum').value;
		if(pre_seq == 0)		// 이전 글이 없는 경우
			alert('이전 글이 없습니다.');
		else document.location.href='/board/view?seqno=' + pre_seq + '&page=' + preV_PageNum + '&keyword=' + keyword;	//이전글(최근 글)로 이동
	}

	btn_nextV.onclick = () => {		
		let next_seq = document.querySelector('#next_seq').value;
		let nextV_PageNum = document.querySelector('#nextV_PageNum').value;
		if(next_seq == 0)		// 이전 글이 없는 경우
			alert('다음 글이 없습니다.');
		else document.location.href='/board/view?seqno=' + next_seq + '&page=' + nextV_PageNum + '&keyword=' + keyword;	//이전글(최근 글)로 이동
	}
});