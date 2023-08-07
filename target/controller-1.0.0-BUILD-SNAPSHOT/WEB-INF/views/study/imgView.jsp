<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 보기</title>
</head>

<body>
<script>
	const previewFile = () => {
		
		const preview = document.querySelector('img');
		const file = document.querySelector('input[type=file]').files[0];	//file 객체는 files 라는 배열을 가지고 있음 각 원소가 파일 1개 임
		const reader = new FileReader();	//자바스크립트의 내장 객체를 가져와서 사용
		
		//reader에 대한 이벤트 리스너
		reader.addEventListener('load', () => {
			preview.src = reader.result;
			console.log("preview.src = "+ preview.src);
		});
		
		if(file) reader.readAsDataURL(file); //if(file) 파일이 존재한다면, file의 정보를 읽어오라..
		
		
	}
</script>

<input type="file" onchange="previewFile()"><br>
<img src="" style="width:400px; height:auto;">

</body>
</html>