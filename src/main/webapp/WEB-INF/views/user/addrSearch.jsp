<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>우편번호 검색 | MARISOLBOARD</title>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="\resources\css\MarisolBoard.css" />
	<script>
		const addrCheck = (zipcode, newaddr) => {
			window.opener.document.getElementById("zipcode").value = zipcode;
			window.opener.document.getElementById("addr1").value = newaddr;
			window.close();
		}
	</script>

	<style>
		table {
			width: 900px;
		}
		
		table th{
			text-align: center;
			padding: 5px 0 5px 0;
			font-weight:600;
		}


	</style>

</head>

<body>
	<div id="main">
		<div class="table-wrapper">
		<!-- Header -->
		<header id="header" style="width: 900px; margin:0 0 0 0; padding:0 0 0 0;" align="center">
			<div class="inner" align="left">
				<!-- Logo -->
				<a href="/board/list?page=1;" class="logo">
					<span class="title">🌈MARISOLBOARD</span>
				</a>
			</div>
		</header>
		<h2 align="center" style="margin-bottom:30px;">우편번호검색</h2>

		<table align="center">
			<tr>
				<th>우편번호</th>
				<th>주소</th>
				<th>선택</th>
			</tr>
			<tbody>
				<c:if test="${list != null}">
					<c:forEach items="${list}" var="list">
						<tr onMouseover="this.style.background='lightgray';" onmouseout="this.style.background='white';">
							<td style="text-align:center;">${list.zipcode}</td>
							<td style="text-align:left;">${list.province}${list.road}${list.building}<br>${list.oldaddr}
							</td>
							<td>
								<div align="center">
									<input type="button" class="xsmall" value="선택" onclick="addrCheck('${list.zipcode}','${list.province}${list.road}${list.building}');">
								</div>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${list == ''}">
					<tr>
						<td colspan="3" style="text-align: center;">검색된 주소가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<div>
			<p align="center">${pageListView} </p>
		</div>
	</div><!--table-wrapper End-->
	</div>
</body>
</html>