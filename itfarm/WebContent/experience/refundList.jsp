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
<title>ITFARM - 예약 리스트</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body_1.css" />
<style type="text/css">
/* table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    text-align: left;
    padding: 8px;
}

tr:nth-child(even){background-color: #f2f2f2} */
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>
	<section>
	<div class="h2div"><h2>예약취소내역</h2></div>
	<hr>
	<br>
	<table class="content1 table">
		<tr class="main1">
			<td class="td1">상품정보</td>
			<td class="td2">체험일자</td>
			<td class="td3">결제일자</td>
			<td class="td4">인원</td>
			<td class="td5">결제금액</td>
			<td class="td6">상태</td>
		</tr>
		<c:forEach var="reservation" items="${rList}">
		${emp}
		<tr class="sub1">
			<td>
				<div class="box1">
					<img class="box1" src="${reservation.imgPath}">
				</div>
				<div class="box2">
					<a href="Experience?command=reservation_detail&expid=${reservation.expid}&prodcode=${reservation.prodcode}">${reservation.expName}</a>(${reservation.prodcode})
				</div>
			</td>
			<td>${reservation.eDate}</td>
			<td>${reservation.rDate}</td>
			<td><div>어린이: ${reservation.childNum} 명</div> 
				<div>성인: ${reservation.adultNum} 명</div></td>
			<td><fmt:formatNumber value="${reservation.price}" type="number" pattern="#,##0"/>원</td>
			<td>취소완료</td>
		</tr>
		</c:forEach>
	</table>
	</section>
	<br>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>