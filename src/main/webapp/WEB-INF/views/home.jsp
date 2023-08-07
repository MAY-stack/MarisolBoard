<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page session="false" %> --%>
<html>
<head>
	<title>Home</title>
<% //세션 확인
	String userid = (String)session.getAttribute("userid");
	if (userid != null)
		{response.sendRedirect("/board/list");}
	else response.sendRedirect("/user/login");
%>
<script>
	document.location.href="/";
</script>
</head>
<body>

</body>
</html>
