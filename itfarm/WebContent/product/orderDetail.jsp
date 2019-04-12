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
<title>ITFARM - 구매내역 상세</title>
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
	<h2>구매내역</h2>
	<hr>
	<h3>구매정보</h3>
	<hr>
	<table class="content1 table table-bordered ">
		<tr class="main1">
			<td class="title">상품정보</td>
			<td>개수</td>
			<td>가격</td>
			<td>결제금액</td>
		</tr>
		<c:forEach var="orderList" items="${orderList}">
		<tr class="sub1">
			<td><div class="box1">
					<img class="box1" src="images/product/${orderList.productImg}">
				</div>
				<div class="box2">
					${orderList.pname}
				</div></td>
			<td>${orderList.num} 개</td>
			<td><fmt:formatNumber value="${orderList.unitPrice}" type="number" pattern="#,##0"/>원</td>
			<td><fmt:formatNumber value="${orderList.unitPrice * orderList.num}" type="number" pattern="#,##0"/>원</td>
			<c:set var="sum1" value="${orderList.unitPrice * orderList.num}"></c:set>
			<c:set var="sum2" value="${sum2 + sum1}"></c:set>
		</tr>
		</c:forEach>
		<tr class="sub1">
			<td></td>
			<td></td>
			<td></td>
			<td>총 
			<fmt:formatNumber value="${sum2}" type="number" pattern="#,##0"/>원</td>
		</tr>
	</table>
	<h3>배송지 정보</h3>
	<hr>
	<c:forEach var="order" items="${orderList}" begin="0" end="0">
	<table class="content2 table table-bordered ">
		<tr>
			<td class="main2">이름</td>
			<td>${order.name}</td>
		</tr>
		<tr>
			<td class="main2">연락처</td>
			<td>${order.phone}</td>
		</tr>
		<tr>
			<td class="main2">배송지 정보</td>
			<td>${order.zipNo} ${order.roadAddr} ${order.addrDetail}</td>
		</tr>
		<!-- <tr>
			<td class="main2">기타 말</td>
			<td></td>
		</tr> -->
	</table>
	<h3>결제정보</h3>
	<hr>
	<table class="content2 table table-bordered ">
		<tr>
			<td class="main2">주문번호</td>
			<td>${order.saleid}</td>
		</tr>
		<tr>
			<td class="main2">구매자명</td>
			<td>${loginUser.name}</td>
		</tr>
		<tr>
			<td class="main2">연락처</td>
			<td>${loginUser.phone1}-${loginUser.phone2}-${loginUser.phone3}</td>
		</tr>
		<tr>
			<td class="main2">결제일자</td>
			<td>${order.pDate}</td>
		</tr>
		<tr>
			<td class="main2">결제수단</td>
			<td><c:choose>
				<c:when test="${order.payment == 1}">
					<p>무통장 결제</p>
				</c:when>
				<c:when test="${order.payment == 2}">
					<p>신용카드 결제</p>
				</c:when>
				<c:when test="${order.payment == 3}">
					<p>휴대폰 결제</p>
				</c:when>
			</c:choose></td>
		</tr>
	</table>
	</c:forEach>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>