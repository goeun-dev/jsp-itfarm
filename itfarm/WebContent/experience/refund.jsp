<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 환불</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body_1.css" />
<style>
.a {
	color: #fff;
	text-decoration: none;
}
div {
text-align: center;
}
</style>

</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<div>
		<h3>예약 취소</h3>
		<hr>
		<p>예약을 취소 하시겠습니까?</p>
		<form action="Experience?command=reservation_refund" method="post">
		<input type="hidden" name="id" value="${id}">
		<button type="button" onclick="history.back();">돌아가기</button>
		<button type="submit">취소하기</button>
		</form>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>