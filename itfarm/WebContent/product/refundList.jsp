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
<title>ITFARM - 취소 내역</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body_1.css" />
<style type="text/css">
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>
	<section>
	<div class="h2div"><h3>취소내역 조회</h3></div>
	<hr>
	<br>
	<table class="content1 table" id="row">
		<tr class="main1">
			<td class="td7">주문번호</td>
			<td class="td1">상품정보</td>
			<!-- <td class="td1">수량</td> -->
			<td class="td2">결제수단</td>
			<td class="td2">주문금액</td>
			<td class="td6">상태</td>
		</tr>
		<c:forEach var="orderList" items="${orderList}">
		${emp}
		<tr class="sub1">
			<td rowspan="1" class="displaynone">
				${orderList.pDate}<br>${orderList.saleid}<br>
				<%-- <a href="Product?command=order_detail&saleid=${orderList.saleid}">주문상세보기</a> --%>
			</td>
			<td>
				<div class="box1">
					<img class="box1" src="images/product/${orderList.productImg}">
				</div>
				<div class="box2">
				<a href="#">${orderList.name} 
				<c:if test="${orderList.cnt != 1}"> 외 ${orderList.cnt - 1}개</c:if></a>
				</div>
			</td>
			<td>${orderList.month}</td>
			<td>
				<fmt:formatNumber value="${orderList.unitPrice}" type="number" pattern="#,##0"/> 원
			</td>
			<td>${orderList.delivery}<br>
			</td>
		</tr>
		</c:forEach>
	</table>
	</section>
	<br>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>