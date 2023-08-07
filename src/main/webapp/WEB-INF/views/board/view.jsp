<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- JSTL 사용을 위한 태그 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%//세션 확인
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	 		if(userid == null)response.sendRedirect("/user/login");	//userid가 null이면 로그인 페이지로 보냄
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/resources/css/MarisolBoard.css"> <!-- CSS stylesheet 적용 -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- jQuery 라이브러리 사용 -->
	<script src="/resources/js/board/view.js"></script>
	<!-- Scripts -->
	<script src="/resources/js/css/jquery.min.js"></script>
	<script src="/resources/js/css/browser.min.js"></script>
	<script src="/resources/js/css/breakpoints.min.js"></script>
	<script src="/resources/js/css/util.js"></script>
	<script src="/resources/js/css/main.js"></script>
	<style>
		/****좋아요/싫어요*****/
		.likeClick {
			padding: 5px 5px 2px 2px;
			height: 50px;
			text-align: center;
			font-weight: 600;
			line-height: normal;
			text-decoration: none;
			display: inline-block;
			border-radius: 10px;
		}

		#like a, #dislike a {
			transition: border-bottom-color 0.2s ease, color 0.2s ease;
			text-decoration: none;
			color: #585858;
			border-bottom: none;
		}

		table {
			width: 800px;
		}

		table tbody tr {
			border: none;
			height: 45px;
		}

		table.view tr {
			padding: 50px 0 50px 0;
		}

		table tbody tr:nth-child(2n + 1) {
			background-color: white;
		}

		td:nth-child(1) {
			width: 15%;
			font-weight: 700;
		}

		input[type="button"].x-small {
			font-size: 0.5em;
			width: 60px;
			height: 30px;
		}

		.button.xsmall{
			height: 40px;
		}
		
		#btn_reply, #btn_reply_cancle{
			height:35px;
		}


	</style>

	<title>글 상세보기 | MARISOLBOARD</title>

</head>

<body class="is-preload">
	<div id="wrapper">
		<!-- Header -->
		<header id="header">
			<div class="inner">
				<!-- Logo -->
				<a href="/board/list?page=1" class="logo">
					<span class="title">🌈MARISOLBOARD</span>
				</a>
				<!--top-menu-->
				<div align="right" class="menu">
					<c:if test="${role == 'MASTER' }">
						<a href="/master/sysmanage" style="display: inline-block; align-content: end; font-weight:500;">관리자메뉴</a> &nbsp;
					</c:if>
					<a href="/board/write">글쓰기</a> &nbsp;
					<a href="/user/mypage?userid=<%=userid%>">마이페이지</a> &nbsp;					
					<a href="" id="btn_logout">로그아웃</a>
				</div>
			</div>
		</header>
		<!-- Main -->
		<div id="main" align="center">
			<div class="inner">
				<h2 style="margin-bottom: 20px;">글 상세보기</h2>
				<table id="writer_menu" style="width: 900px;">
					<tr>
						<td style="width: 50%;">
							<a href="/board/list?page=${page}&keyword=${keyword}" style="font-weight:500;">＜목록</a>
						</td>
						<td style="width: 50%;">
							<div align="right">
								<span class="like_a"id="btn_modify" style="">수정</span>
								<span>&nbsp;</span> 
								<span class="like_a" id="btn_delete" style="font-weight:500; border-bottom: dotted 1px rgba(88, 88, 88, 0.5);">삭제</span>
							</div>
						</td>
					</tr>
				</table>
				
				<input type="hidden" name="modify_authority" id="modify_authority" value="${modify_authority }">
				
				<div style="width:900px; border: lightgray 1px solid; height:auto; margin:5px 0 30px 0; padding: 30px 0 30px 0;">
					<table class="view">
						<tr>
							<td> 작성자 </td>
							<td style="width:400px;">
								<div class="alt" id="writer">${view.writer}</div>
							</td>
							<td style="font-weight: 700;">
								작성일
							</td>
							<td>
								<div class="field">${view.regdate}</div>
							</td>
						</tr>
						<tr>
							<td> 제목 </td>
							<td colspan="3" style="text-align: left;">
								<div class="alt" id="title">${view.title}</div>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<pre style="min-height:400px; text-align:left; font-weight:400; font-size:13pt; border: 1px solid lightgray;">${view.content}</pre>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<div class="likeForm min inner" style="width:50%; height:auto; margin:auto;">
									<!-- 좋아요/싫어요 display likeForm -->
									<span id='like'></span>&nbsp;&nbsp;<button id="likeClick" class="likeClick">&nbsp
										Like❤️</button>
									<button id="disLikeClick" class="likeClick">&nbsp;
										dislike🖤</button>&nbsp;&nbsp;<span id="dislike"></span><br>
									<span id='myChoice' style="text-align:center; font-weight:400; color:#747474;"></span>
								</div><!-- 좋아요/싫어요 display likeForm END-->
							</td>
						</tr>
						<tr>
							<td colspan="4">첨부파일&nbsp;
								<span style="font-size:12pt; font-weight:400; color:#585858;">
								(파일의 이름을 클릭하면 파일을 다운로드 하실 수 있습니다.)</span>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<div class="uploadedFile"
									style="font-weight:500; width:800px; min-height:100px; border:solid 1px lightgray;"
									align="center">
									<c:if test="${fileListView != null}">
										<c:forEach items="${fileListView}" var="fileView">
											<div class="alt" style="text-align:left; padding-left:10px; font-weight:300;">
												<a href="/board/filedownload?fileseqno=${fileView.fileseqno}" style="border-bottom:none;">
												${fileView.org_filename}</a>( ${fileView.filesize} Byte )
											</div>
										</c:forEach>
									</c:if>
									<c:if test="${fileListView == null}">
										<div class="alt" style="color:#969696; font-size: 12pt;">첨부파일이 없습니다.
										</div>
									</c:if>
								</div> <!-- uploadedFile End -->
							</td>
						</tr>
						<tr>
							<td colspan="4">
							</td>
						</tr>
					</table>		
				</div>
				
				<div class="bottom_btns" style="width:80%; margin:auto" align="center"> <!-- 처리 버튼 -->
					<button class="button primary xsmall" id="btn_preV">이전글</button>

					<button class="button primary xsmall" id="btn_nextV">다음글</button>
				</div> <!-- btn End -->
				
					<input type="hidden" name="userid" value="<%=userid%>"> <!-- 세션의 userid 정보 저장 -->
					<input type="hidden" name="page" id="page" value="${page}">
					<input type="hidden" name="keyword" id="keyword" value="${keyword}">
					<input type="hidden" name="seqno" id="seqno" value="${view.seqno}">
					<input type="hidden" name="pre_seq" id="pre_seq" value="${pre_seq}">
					<input type="hidden" name="preV_PageNum" id="preV_PageNum" value="${preV_PageNum}">
					<input type="hidden" name="seq" id="seq" value="${view.seq}">
					<input type="hidden" name="next_seq" id="next_seq" value="${next_seq}">
					<input type="hidden" name="nextV_PageNum" id="nextV_PageNum" value="${nextV_PageNum}">
					<input type="hidden" name="writer" id="writer" value="${view.userid}">
					<!-- 글작성자 -->
					<input type="hidden" name="likeCnt" id="likeCnt" value="${view.likecnt}">
					<!-- 글의 좋아요 개수 -->
					<input type="hidden" name="dislikeCnt" id="dislikeCnt" value="${view.dislikecnt}">
					<!-- 글의 싫어요 개수-->

					<input type="hidden" name="username" id="username" value="${username}">
					<!-- 접속 사용자 이름 -->
					<input type="hidden" name="myLikeCheck" id="myLikeCheck" value="${myLikeCheck}">
					<!-- 접속한 사용자의 싫어요여부 -->
					<input type="hidden" name="myDislikeCheck" id="myDislikeCheck" value="${myDislikeCheck}">
					<!-- 접속한 사용자의 싫어요여부 -->

					<input type="hidden" name="modify_authority" id="modify_authority" value="${modify_authority}">
					<!-- 접속한 사용자의 수정 권한 -->
				<!-- replyDiv start -->
				<div class="replyDiv"align="center" style="text-align: left;">
					<p style="margin:0; padding:0; font-size:15pt; font-weight:500;" align="left" >댓글</p>
					<div style="width:900px; border: lightgray 1px solid; height:auto; margin:5px 0 30px 0; padding: 0;">
						<form id="replyForm" name="replyForm" method="POST">
							<table class="reply">
								<tr>
									<td>작성자</td>
									<td>
										<input type="text" id="replywriter" name="replywriter" style="text-align:left; width:150px;"
											value="${username}" readonly>
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<textarea id='replycontent' style="min-height:100px;" name='replycontent' cols='80' rows='5' maxlength='150'
											placeholder='글자수:150자 이내'></textarea><br>
										<input type="hidden" id="seqno" name="seqno" value="${view.seqno}">
										<input type="hidden" id="userid" name="userid" value="${userid}">
									</td>
								</tr>
								<tr>
									<td colspan="2">
										<div align="center">
											<input type="button" id="btn_reply" class="button primary xsmall" value="등록">
											<input type="button" id="btn_reply_cancle" class="button xsmall" value="취소">
										</div>
									</td>
								</tr>								
							</table><!--reply class end-->
						</form>
					</div>
					<div id="replyList" style="width:100%; height:600px; overflow:auto;" align="center"></div>
				</div><!-- replyDiv End -->
			</div><!--inner div End-->
		</div> <!-- main div End -->
		<!--footer-->
		<footer id="footer" style="padding:30px 0 40px 0;">
			<div class="inner">
				<!-- <section>
							<h2>Get in touch</h2>
							<ul class="icons">
								<li><a href="#" class="icon brands style2" ><img src="\resources\images\icons\github_logo_icon_248225.png" style="width:45px; vertical-align: middle;"><span class="label">GitHub</span></a></li>
								<li><a href="#" class="icon brands style2"><img src="\resources\images\icons\tistory_logo_icon_249387.png" style="width:40px; vertical-align: middle;"><span class="label">Tistory</span></a></li>
							</ul>
						</section> -->
				<ul class="copyright" style="margin-top: 20px;" align="center">
					<li> 2023년 대한상공회의소 서울기술교육센터 기업프로젝트 S/W 개발자 과정</li>
					<li>교육생: <a href="#">성민경</a></li>
				</ul>
			</div>
		</footer>
	</div><!--wrapper div End-->

</body>
</html>