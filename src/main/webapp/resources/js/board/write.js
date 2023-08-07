window.addEventListener('load', () => {	
	const fileZone = document.querySelector('#fileZone');
	const inputFile = document.querySelector('#input-file');
	
	//fileZone 클릭시 발생 이벤트 정의
	fileZone.addEventListener('click', (e) => {
		inputFile.click(e);	//inputFile 객체를 클릭하는 효과를 내줌		
	});
	
	//inputFile 클릭-> 파일탐색창 열어서 선택한 파일을 files에 할당
	inputFile.addEventListener('change', (e) => {
		const files = e.target.files;	//e.target 파일탐색창에서 선택하는 파일들의 정보 담김
		fileCheck(files);
	});
	
	/*마우스 이벤트 종류 - 시스템 내에 정해져 있음
	dragestart : 사용자가 객체를 드래그를하려고 시작할 떄 발생하는 이벤트
	dragevent : 대상 객체를 드래그하면서 마우스를 움직일 때 발생하는 이벤트
	dragenter : 마우스가 대상 객체의 위로 처음 진입할 때 발생하는 이벤트
	drageover : 드래그해서 마우스가 대상 객체의 영역 위에서 자리 잡고 있을 때 발생
	drop : 드래그가 끝나서 드래그하던 객체를 영역에 놓을때 발생
	dragleave : 드래그가 끝나서 마우스가 대상 객체의 위에서 벗어날 때 발생함
	dragend : 대상 객체를 드래그하다가 영역 외에서 마우스 버튼을 놓는 순간 발생함
	*/
	
	//fileZone으로 dragenter 이벤트 발생 시 처리하는 이벤트 핸들러 생성
	fileZone.addEventListener('dragenter', (e) => {
		e.stopPropagation();	//웹 브라우저 고유의 동작을 중단
		e.preventDefault();		//상위 객체들로 부터의 이벤트 전파를 중단
		fileZone.style.border = '2px solid #0b85a1';
	});
	//fileZone으로 dragover 이벤트 발생 시 처리하는 이벤트 핸들러 생성
	fileZone.addEventListener('dragover', (e) => {
		e.stopPropagation();
		e.preventDefault();
	});
	//fileZone으로 drop 이벤트 발생 시 처리하는 이벤트 핸들러 생성
	fileZone.addEventListener('drop', (e) => {
		e.stopPropagation();
		e.preventDefault();
		const files = e.dataTransfer.files; 	//dataTransfer : drag & drop으로 가져오는 객체의 데이터 
		fileCheck(files);
		
	});
	//fileZone으로 dragleave 이벤트 발생 시 처리하는 이벤트 핸들러 생성
	fileZone.addEventListener('dragleave', (e) => {
		e.stopPropagation();
		e.preventDefault();
		fileZone.style.border = 'solid #adadad';
	});
});

//-----파일 업로드-----//
var uploadCountLimit = 5; // 최대 업로드 가능한 파일 갯수
var fileCount = 0; // 파일 현재 필드 숫자 totalCount랑 비교값
var fileNum = 0; // 파일 고유넘버
var content_files = new Array(); // 첨부파일 배열
var rowCount=0;

const fileCheck = (files) => {
	
	//배열로 변환
	//var filesArr = Array.prototype.slice.call(files); //유사배열을 배열로 만들어줌
	//-->다음과 같이 쓸 수 있게 됨(ECMASript : ~2017y)
	let filesArr = Object.values(files); //ECMASript
	
	
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > uploadCountLimit) {
      	alert('파일은 최대 '+ uploadCountLimit+'개까지 업로드 할 수 있습니다.');
      	return;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }

	filesArr.forEach((file) => { 
		
		var reader = new FileReader();
		
		//파일 읽기
		reader.readAsDataURL(file);
		
		//파일읽기(reader.readAsDataURL(file))가 성공적으로 수행되고 난 후
		//파일읽기의 이벤트 핸들러를 통해 reader.onload 이벤트 핸들러 내의 콜백 함수가 비동기적으로 실행
		reader.onload = function (e) {
        	content_files.push(file);	//
		
        	if(file.size > 1073741824) { alert('파일 사이즈는 1GB를 초과할수 없습니다.'); return; }
	
    		rowCount++;
        	var row="odd";	//홀수
        	if(rowCount %2 ==0) row ="even";	//짝수
        	
        	//statusbar 객체 생성
        	let statusbar = document.createElement('div');	//객체 생성 <div> </div>
        	statusbar.setAttribute('class', "statusbar " + row); //객체의 속성 설정 <div class = "statusbar odd"></div> 
        	statusbar.setAttribute('id', 'file' + fileNum); //객체의 속성 설정 <div class = "statusbar odd"></div>
        	
        	//statubar 내의 파일 명
        	let filename = "<div class='filename' style='display:inline-block'>" + file.name + "</div>";
        
        	let sizeStr="";
        	let sizeKB = file.size/1024;
        	if(parseInt(sizeKB) > 1024){
        		var sizeMB = sizeKB/1024;
            	sizeStr = sizeMB.toFixed(2)+" MB";	//.toFix(2) : 소수점 뒷자리 2개
        	}else sizeStr = sizeKB.toFixed(2)+" KB";	        
        
        	let size = "<div class='filesize' style='display:inline-block' >" + sizeStr + "</div>";
        	
        	//statusbar의 삭제버튼
	        let btn_delete = "<div class='btn_delete' style='display:inline-block'><input type='button'  value='삭제' onclick=fileDelete('file" + fileNum + "')></div>";
	       
			//파일이름, 사이즈, 삭제버튼을 문자열로 합쳐서 넣어줌
	        statusbar.innerHTML = filename + size + btn_delete; 
		
			//합쳐진 문자열을 list에 계속 더해줌
			fileUploadList.appendChild(statusbar);
			
        	fileNum ++;

        	console.log(file);
      	};
    });
	const inputFile = document.querySelector('#input-file');
	inputFile.value = "";
	
	//----- 글 등록 처리 -----//
// 	const registerForm = async() => {
// 		//유효성 검사
// 		if(writer.value=='') { alert("이름을 입력하세요!!!"); writer.focus(); return false;  }
// 		if(title.value=='') { alert("제목을 입력하세요!!!");  title.focus(); return false;  }
// 		if(content.val=='') { alert("내용을 입력하세요!!!");  content.focus(); return false;  }
		
// 		let uploadURL = '';
// 		console.log(content_files.length);
		
// 		//파일첨부에 따라서 다른 url로 보냄
// 		if(content_files.length != 0)	//첨부된 파일 있을 경우 	
// 			uploadURL = '/board/fileUpload?kind=I';
// 		else 							//첨부된 파일 없을 경우
// 			uploadURL = '/board/write';

// 		let formData = new FormData(document.getElementById('WriteFrom'));
// 		for (let i = 0; i < content_files.length; i++) {  
// 				if(!content_files[i].is_delete) { 	//배열에 요소가 있을때
// 					formData.append("SendToFileList", content_files[i]);	//formData에 key-value 형태로 배열의 원소 데이터 추가
// 				}
// 		}
		/*
		$.ajax({
	        url: uploadURL,
	        type: "POST",
	        contentType:false,
	        processData: false,
	        cache: false,
	        enctype: "multipart/form-data",
	        data: formData,
	        xhr:function(){
	        	var xhr = $.ajaxSettings.xhr();
	        	xhr.upload.onprogress = function(e){
	        		var per = e.loaded * 100/e.total;
	        		setProgress(per);
	        	};
	        	return xhr;        	
	        },
	        success: function(data){
	        	alert("게시물이 등록되었습니다.\n게시물 목록 화면으로 이동합니다.");
				document.location.href='/board/list?page=1';	
	        },
	        error: function (xhr, status, error) {
	       	    	alert("서버오류로 게시물 등록이 실패하였습니다. 잠시 후 다시 시도해주시기 바랍니다.");
	       	     return false;
	       	}   
	       
	    }); 
		*/
}	

//----- 글 등록 처리 -----//
window.addEventListener('load', () => {

	btn_write.onclick = async () => {
		//유효성 검사
		if(writer.value=='') { alert("이름을 입력하세요!!!"); writer.focus(); return false;  }
		if(title.value=='') { alert("제목을 입력하세요!!!");  title.focus(); return false;  }
		if(content.val=='') { alert("내용을 입력하세요!!!");  content.focus(); return false;  }
		
		let uploadURL = '';
		
		//파일첨부에 따라서 다른 url로 보냄
		if(content_files.length != 0)	//첨부된 파일 있을 경우 	
			uploadURL = '/board/fileUpload?kind=I';
		else 							//첨부된 파일 없을 경우
			uploadURL = '/board/write';
	
		let formData = new FormData(document.getElementById('WriteFrom'));
		for (let i = 0; i < content_files.length; i++) {  
				if(!content_files[i].is_delete) { 	//배열에 요소가 있을때
					formData.append("SendToFileList", content_files[i]);	//formData에 key-value 형태로 배열의 원소 데이터 추가
				}
	    }
	    
		await fetch(uploadURL, {
			method:'POST',
			body:formData,
		}).then((response) => response.json())
		  .then((data) => {
			  if(data.message == "good"){
				  alert("게시물이 정상적으로 등록되었습니다.");
				  document.location.href="/board/list?page=1";
			  }
		  }).catch((error) => {
	          alert('시스템 장애로 게시물 등록을 실패했습니다.');
	          console.log((error) => console.log('error=' + error));
	          return;
	    });
	}
});

const fileDelete = (fileNum) => {
    var no = fileNum.replace(/[^0-9]/g, "");
    content_files[no].is_delete = true;	//.is_delete 객체가 삭제 되었는지 확인하는 boolean 타입 담는 내장 객체
    
    document.querySelector('#'+fileNum).remove();
	fileCount --;
}