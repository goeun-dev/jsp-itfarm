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
<title>ITFARM - 주문취소</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
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
	<jsp:include page="../header.jsp" flush="false" />
	<div class="divWrap">
		<h3>주문 취소</h3>
		<hr>
		<form action="Product?command=order_refund" method="post">
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
		<tr>
			<td  colspan="4">
				<div>
				* 고객 수령 후 7일이 경과된 상품은 변심에 의한 반품/교환이 불가능 합니다.
				</div>
			</td>
		</tr>
		<tr class="rtitle">
			<td  colspan="4">주의사항</td>
		</tr>
		<tr>
			<td  colspan="4">
				<div class="notice">
				* 휴대폰 또는 카드로 결제한 주문은 자동으로 환불되고, 무통장입금으로 결제한 주문은 입력한 환불 계좌를 통해 환불됩니다.<br>
				* 환불은 접수 후 1~2일(주말, 공휴일 제외) 후에 완료됩니다. 단, 카드 승인 취소는 카드사에 따라 3~7일이 소요될 수 있습니다.<br>
				</div>
			</td>
		</tr>
		<c:forEach var="odd" items="${orderList}" begin="0" end="0">
		<c:if test="${odd.payment == 1}">
		<tr class="rtitle">
			<td  colspan="4">입금받으실 계좌</td>
		</tr>
		<tr>
			<td  colspan="4">
				<div class="rdiv">
				은행 
				<select name="bank" class="form-control">
				<option value="신한은행">신한은행</option>
				<option value="국민은행">국민은행</option>
				<option value="농협은행">농협은행</option>
				<option value="우리은행">우리은행</option>
				</select>
				계좌번호 <input name="account" class="form-control">
				예금주 <input name="acName" class="form-control">
				</div>
			</td>
		</tr>
		<tr>
			<td  colspan="4">
				<div>
				* 계좌번호는 숫자만 입력해주세요.
				</div>
			</td>
		</tr>
		</c:if>
		</c:forEach>
		</table>
		<button type="button" onclick="history.back();" class="btn btn-light">돌아가기</button>
		<button type="submit" class="btn">주문취소</button>
		</form>
	</div>
	
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>