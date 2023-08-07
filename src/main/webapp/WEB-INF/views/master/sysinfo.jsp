<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 시스템 정보 | MARISOLBOARD</title>
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
    .InfoTable caption{caption-side: top; } */

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
	position: relative;
	top: 200px;
	width: 80%;
	height: auto;
	margin: auto;

}

table {
	width:800px;
	text-align:center;
	border:2px solid lightgray;
	
}

table tr{
	height: 50px;
	font-size:18pt;
}
table tr td {
	font-size:15pt;
}
table th {
	text-align:center;
	font-size:18pt;
}

</style>

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
<div id="main" style="padding-top:60px;">	
	<h1 align="center" >🌈Marisol Board📋</h1>
	<div class="inner">
		<h2 align="center" >시스템 정보🔧</h2>
	 	<div class="devInfo" align="center">
	   		<table class="InfoTable">
	   			<tr style='font-weight:700;'><th>항목</th><th>내용</th></tr>
	   			<tr><td style='font-weight:500;' >웹애플리케이션 서버 버전</td><td><%=application.getServerInfo() %></td>
	   			<tr><td style='font-weight:500' >서블릿 버전</td><td><%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></td>
	   			<tr><td style='font-weight:500' >JSP 버전</td><td><%= JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion() %></td>
	   			<tr><td style='font-weight:500' >스프링프레임워크 버전</td><td><%=org.springframework.core.SpringVersion.getVersion() %></td>
	   		</table>
	   	</div>	
   	</div>
</div>
</body>
</html>