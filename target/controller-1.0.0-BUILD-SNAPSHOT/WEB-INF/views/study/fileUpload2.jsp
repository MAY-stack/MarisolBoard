<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비동기식|파일 업로드 예제</title>

</head>
<body>
<script>
	const FileUpload = async () => {
		
		const formData = new FormData(FileForm);
		
		await fetch('/board/fileUpload2', { //fetch('url', {보낼 데이터});
			//key-value 
			method: 'POST',
			body: formData
		}).then((response) => response.text())	//stream 형태...
		  .then((data) => {
			  if(data == 'good')				  
				  alert("파일 전송이 성공했습니다.")
			  else
				  alert("서버 장애로 파일 전송이 실패했습니다.");	
	  	}).catch((error) => console.log("error =" + error));
		
	}
</script>

<form id="FileForm" enctype=multipart/form-data method="post">
	주인공 : <input type="text" name="painter">
	<input type="file" name="fileUpload" multiple><br>	<!-- 파일을 열고 정보를 읽는 역할까지 함 -->
	<input type="button" onclick="FileUpload()" value="파일전송">
	
</form>
</body>
</html>