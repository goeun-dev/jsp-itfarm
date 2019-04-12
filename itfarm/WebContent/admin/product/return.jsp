<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 반품신청내역</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/body_1.css" />
<link rel="stylesheet" href="assets/css/refund.css" />
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
	<div class="divWrap">
		<h3>반품 신청</h3>
		<hr>
		<form action="Product?command=order_return" method="post">
		<input type="hidden" name="id" value="${id}">
		<input type="hidden" name="status" value="4">
	
		<table class="rtable table">
		<c:forEach var="od" items="${orderList}" begin="0" end="0"> 
		<tr class="rtitle">
			<td colspan="4">
			주문번호: ${od.saleid}</td>
		</tr>
		<tr class="rtitle">
			<th>주문자</th>
			<th>주문명</th>
			<th>결제금액</th>
			<th>결제수단</th>
		</tr>
		<tr>
			<td>
				<div class="rdiv">
				${od.name} <br>
				</div>
			</td>
			<td>
				<div class="rdiv">
				${od.pname} 
				<c:forEach var="odp" items="${orderList}" varStatus="status">
				<c:set var="sum1" value="${odp.unitPrice * odp.num}"></c:set>
				<c:set var="sum2" value="${sum2 + sum1}"></c:set>
				<c:if test="${status.last}">
				<c:if test="${odp.cnt != 0}">
				외 
				${odp.cnt}
				개 상품
				</c:if>
				</c:if>
				</c:forEach>
				<br>
				</div>
			</td>
			<td>
				<div class="rdiv">
				<fmt:formatNumber value="${sum2}" type="number" pattern="#,##0"/> 원
				 <br>
				</div>
			</td>
			<td>
				<div class="rdiv">
				${od.delivery} <br>
				</div>
			</td>
		</tr>
		</c:forEach>
		<tr class="rtitle">
			<td  colspan="4">반품 신청 상품</td>
		</tr>
		<c:forEach var="orderList" items="${orderList}">
		<tr>
			<td  colspan="4">
			<div class="notice">
				<img class="rimg" src="images/product/${orderList.productImg}"> 
				${orderList.pname}
				${orderList.num} 개
				<fmt:formatNumber value="${orderList.unitPrice}" type="number" pattern="#,##0"/>원
				<fmt:formatNumber value="${orderList.unitPrice * orderList.num}" type="number" pattern="#,##0"/>원
			</div>
			</td>
		</tr>
		</c:forEach>
		<c:forEach var="odd" items="${orderList}" begin="0" end="0">
		<tr class="rtitle">
			<td  colspan="4">반품 사유</td>
		</tr>
		<tr>
			<td  colspan="4">
				${odd.gprice}
			</td>
		</tr>
		
		<c:if test="${odd.payment == 1}">
		<tr class="rtitle">
			<td  colspan="4">입금받을 계좌</td>
		</tr>
		<tr>
			<td  colspan="4">
				<div class="rdiv">
				${odd.month}
				</div>
			</td>
		</tr>
		</c:if>
		</c:forEach>
		</table>
		<br>
		<c:forEach var="sale" items="${orderList}" begin="0" end="0"> 
		<button type="button" onclick="location.href='Product?command=order_refund&id=${sale.saleid}&status=6'" class="btn">승인하기</button>
		<button type="button" onclick="location.href='Product?command=order_refund&id=${sale.saleid}&status=7'" class="btn">거절하기</button>
		</c:forEach>
		</form>
		<br>
	</div>
</body>
</html>