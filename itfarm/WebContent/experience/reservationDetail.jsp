<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 예약내역 상세</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/reservation.css" />

</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>
	<h2>예약내역</h2>
	<hr>
	<h3>예약정보</h3>
	<hr>
	<table class="content1 table table-bordered ">
		<tr class="main1">
			<td class="title">상품명</td>
			<td>인원수</td>
			<td>상품금액</td>
			<td>결제금액</td>
		</tr>
		<tr class="sub1">
			<td><div class="box1">
					<img class="box1" src="${reservation.imgPath}">
				</div>
				<div class="box2">
					${reservation.expName}(${reservation.prodcode})
				</div></td>
			<td>성인: ${reservation.adultNum}명, 어린이: ${reservation.childNum}명</td>
			<td>성인: <fmt:formatNumber value="${adultPrice}" type="number" pattern="#,##0"/>원, 
			어린이: <fmt:formatNumber value="${childPrice}" type="number" pattern="#,##0"/>원</td>
			<td><fmt:formatNumber value="${reservation.price}" type="number" pattern="#,##0"/>원</td>
		</tr>
	</table>

	<h3>결제정보</h3>
	<hr>
	<table class="content2 table table-bordered ">
		<tr>
			<td class="main2">예약번호</td>
			<td>${reservation.expid}</td>
		</tr>
		<tr>
			<td class="main2">예약자명</td>
			<td>${loginUser.name}</td>
		</tr>
		<tr>
			<td class="main2">연락처</td>
			<td>${loginUser.phone1}-${loginUser.phone2}-${loginUser.phone3}</td>
		</tr>
		<tr>
			<td class="main2">결제일자</td>
			<td>${reservation.rDate}</td>
		</tr>
		<tr>
			<td class="main2">결제수단</td>
			<td>${reservation.paymentName}</td>
		</tr>
	</table>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>