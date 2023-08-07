<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 예제</title>

</head>
<body>
<script>
function FileUpload(){
	document.FileForm.action = "/board/fileUpload";
	document.FileForm.submit();
}
</script>

<form name="FileForm" enctype=multipart/form-data method="post">
	주인공 : <input type="text" name="painter">
	<input type="file" name="fileUpload" multiple><br>	<!-- 파일을 열고 정보를 읽는 역할까지 함 -->
	<input type="button" onclick="FileUpload()" value="파일전송">
	
</form>
</body>
</html>