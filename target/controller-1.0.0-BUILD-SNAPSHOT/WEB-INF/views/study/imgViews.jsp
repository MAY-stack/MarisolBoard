<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여러 이미지 미리보기</title>
</head>
<body>

<script>

	const previewFiles = () => {
		
		const prewview = document.querySelector('#preview');
		const files = document.querySelector('input[type=file]').files;	//여러개의 파일이기 때문에 배열 자체를 받음
		
		const readAndPreview = (file) => {
			
			//if문 내에 정규식 사용//
			if(/\.(jpe?g|png|gif)$/i.test(file.name)) { //이미지의 확장자가 맞으면
				
				const reader = new FileReader();
			
				reader.addEventListener('load', function(){
					
					let image = new Image();	//<img... >형태의 element 만들어짐
					image.height = 100;
					image.title = file.name;
					image.src = this.result;	//this : reader
					preview.appendChild(image);	//append : 생성한 객체를 끼워 넣을 때 사용 preview의 자식 클래스가 됨
					
				});
				
				reader.readAsDataURL(file);		//text file -> 다른 메소드 사용
				
			}
			
		} 
		
		if(files)	//: 유사 배열
		//정식 배열 : let a = [1, 2, 3, 4, 5] 또는 let a = new Array();
		/*정식 배열은 객체에서 제공하는 메소드를 사용 할 수 있는 반면,
		유사배열은 사용할 수 없음. 유사배열도 배열 객체에서 사용할 수 있게끔 해주는 방법
		[]--> Array.prototype */
		//prototype: 새로운 객체 생성 시 자기자신 타입과 함께 프로토타입이 같이 생성 됨 
			[].forEach.call(files, readAndPreview); //files의 원소 개수만큼 readAndPreview 메소드 실행을 반복
		
	}
	
</script>

<input type="file" id="browse" onchange="previewFiles()" multiple><br>	<!-- multiple: 여러개 파일을 선택 하게 할 수 있는 옵션 -->
<div id="preview"></div> 


</body>
</html>