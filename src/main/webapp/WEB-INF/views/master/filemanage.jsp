<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 파일 관리 | MARISOLBOARD</title>
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css">
<style>

.topBanner {
       max-width: 300px;
       height: auto;
       display: block; 
       margin: 0 auto;
}

/* .InfoTable {
      border-collapse: collapse;
      border-top: 3px solid #168;
      width: 80%;  
      margin-left: auto; 
      margin-right: auto;
      font-size: 150%
    }  
    .InfoTable th {
      color: #168;
      background: #f0f6f9;
      text-align: center;
    }
    .InfoTable th, .InfoTable td {
      padding: 10px;
      border: 1px solid #ddd;
    }
    .InfoTable th:first-child, .InfoTable td:first-child {
      border-left: 0;
    }
    .InfoTable th:last-child, .InfoTable td:last-child {
      border-right: 0;
    }
    .InfoTable tr td:first-child{
      text-align: center;
    }
    .InfoTable caption{caption-side: top; }
 */
.menubar {
    width: 100%;
    height:auto;
    background-color: rgba(88, 88, 88); 
    position: fixed;
    top: 0;
    left:0;
    right:0;
    text-align: center;
}

.menubar a:link, a:visited, a:active { 
	color: white; 
	text-weight: 700;
}

.menubar a { 
    display:block; 
    text-decoration: none;

}

.menubar .main_menu > li {
    float:left;
    width:20%;
    height: 100%;
    line-height: 50px;
    list-style: none;
    font-weight: bold;
    position: relative;
    margin: 0px,0px,0px,0px;
    
}

.menubar .main_menu > li > a:hover {
    background-color: #f0f6f9;
    color: #168; 
	text-weight: bold;
}

.main {
/* 	position: relative;
	top: 200px;
	width: 80%;
	height: auto;
	margin: auto; */

}
table tr td {
	width:800px;
	text-align:center;
	height: 200px;
	border:none;
    background-color: white;
	
}

table tr{
	height: 50px;
	font-size:18pt;
}
table tr td {
	font-size:15pt;
    background-color: white;
}
table th {
	text-align:center;
	font-size:18pt;
}

</style>
<script>
	const deleteFileList = async () => {
		await fetch('/master/fileDelete',{
			method: 'GET'			
		}).then((response) => response.json())
		.then((data) => {
			let result = '';
			for(const i in data){
				result += data[i].org_filename + "...파일 삭제<br>";
			}
			result += "<br>" + ${count} +"개 파일 삭제 완료";
			
			fileDeleteList.innerHTML = result;
		})
	}
</script>
</head>
<body>
	<div class="menubar">
	    
	    <ul class="main_menu">
			<li><a href='/board/list?page=1'>게시글 목록</a></li>
			<li><a href='/master/sysmanage'>관리자 메뉴</a></li>
			<li><a href='/master/sysinfo'>시스템 정보</a></li>
			<li><a href='/master/filemanage'>첨부파일 관리</a></li>
	    </ul>  
	
	</div>

<div id="main" style="vertical-align: middle; padding-top:60px;">
	<h1 align="center">🌈Marisol Board📋</h1>
	<h2 align="center" >첨부파일 관리</h2>

	<div class="main">
		<table>
			<tr>
				<td style="text-align:center">
					<span style="font-size:150%; font-weight:700;">삭제가 필요한 파일 : ${count} 개</span>&nbsp;&nbsp;<input type="button" id="btn-delete" value="파일 삭제" class="botton xsamll" onclick="deleteFileList()">
				</td>
			</tr>
			<tr>	
				<td>
					<div id="fileDeleteList" style="width:50%; height:auto; margin:auto;">
				</td>
			</tr>
			</div>
		</table>   		
   	</div>

	<footer id="footer" style="padding:30px 0 40px 0;">
		<div class="inner">
			<!-- <section>
						<h2>Get in touch</h2>
						<ul class="icons">
							<li><a href="#" class="icon brands style2" ><img src="\resources\images\icons\github_logo_icon_248225.png" style="width:45px; vertical-align: middle;"><span class="label">GitHub</span></a></li>
							<li><a href="#" class="icon brands style2"><img src="\resources\images\icons\tistory_logo_icon_249387.png" style="width:40px; vertical-align: middle;"><span class="label">Tistory</span></a></li>
						</ul>
					</section> -->
			<ul class="copyright"  align="center">
				<li> 2023년 대한상공회의소 서울기술교육센터 기업프로젝트 S/W 개발자 과정</li>
				<li>교육생: <a href="#">성민경</a></li>
			</ul>
		</div>
	</footer>
</div>	

</body>
</html>