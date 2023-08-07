window.onload = () => {
 let btn_logout = document.querySelector('#btn_logout');
 btn_logout.onclick = () => {
 	logout();
 }
}
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