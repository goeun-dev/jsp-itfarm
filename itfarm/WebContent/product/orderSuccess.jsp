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
<title>ITFARM - 구매완료</title>
<link rel="stylesheet" href="../assets/css/main.css" />
<link rel="stylesheet" href="../assets/css/body_1.css" />
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
	<jsp:include page="../sub/subHeader.jsp" flush="false" />
	<div>
		<h3>구매완료</h3>
		<hr>
		<p>구매가 완료되었습니다.</p>
		<button onclick="history.go(-2);">목록으로 돌아가기</button>
		<button onclick="location.href='../Product?command=order_list&status=1'">
			구매 내역 확인하기
		</button>
	</div>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>