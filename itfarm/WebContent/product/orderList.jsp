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
<title>ITFARM - 구매 내역</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body_1.css" />
<style type="text/css">
</style>
<script type="text/javascript">
function popup(url, w, h, name, option) {
    var pozX, pozY;
    var sw = screen.availWidth;
    var sh = screen.availHeight;
    var scroll = 0;
    if (option == 'scroll') {
        scroll = 1;
    }
    pozX = (sw - w) / 2;
    pozY = (sh - h) / 2;
    window.open(url, name, "location=0,status=0,scrollbars=" + scroll + ",resizable=1,width=" + w + ",height=" + h + 
    ",left=" + pozX + ",top=" + pozY);
}
</script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>
	<section>
	<div class="h2div"><h3>주문/배송 조회</h3></div>
	<hr>
	<br>
	<table class="content1 table" id="row">
		<tr class="main1">
			<td class="td7">주문번호</td>
			<td class="td1">상품정보</td>
			<!-- <td class="td1">수량</td> -->
			<td class="td2">주문금액</td>
			<td class="td2">결제수단</td>
			<td class="td6">상태</td>
			<td class="td6">취소/확인</td>
		</tr>
		<c:forEach var="orderList" items="${orderList}">
		${emp}
		<tr class="sub1">
			<td rowspan="1" class="displaynone">
				${orderList.pDate}<br>${orderList.saleid}<br>
				<a href="Product?command=order_detail&saleid=${orderList.saleid}">주문상세보기</a>
			</td>
			<td>
				<div class="box1">
					<img class="box1" src="images/product/${orderList.productImg}">
				</div>
				<div class="box2">
				<a href="Product?command=order_detail&saleid=${orderList.saleid}">${orderList.name} 
				<c:if test="${orderList.cnt != 1}"> 외 ${orderList.cnt - 1}개</c:if></a>
				</div>
			</td>
			<%-- <td>
				${orderList.num}
			</td> --%>
			<td>
				<fmt:formatNumber value="${orderList.unitPrice}" type="number" pattern="#,##0"/> 원
			</td>
			<td>${orderList.month}</td>
			<td><%-- <c:choose>
					    <c:when test="${orderList.deliveryStatus == 1}">
					        결제완료
					    </c:when>
					    <c:when test="${orderList.deliveryStatus == 2}">
					        배송중
					    </c:when>
					    <c:when test="${orderList.deliveryStatus == 3}">
					        배송완료
					    </c:when>
				</c:choose><br> --%>
				${orderList.delivery}
			</td>
			<td><c:choose>
					    <c:when test="${orderList.deliveryStatus == 1}">
					        <button class="btn btn-default cancel" onclick="location.href='Product?command=order_refundform&id=${orderList.saleid}';">
				&nbsp;&nbsp;&nbsp;주문취소&nbsp;&nbsp;&nbsp;</button>
					    </c:when>
					    <c:when test="${orderList.deliveryStatus == 2}">
					        <button class="btn btn-default cancel" 
					        onclick="popup('Product?command=delivery_no&saleid=${orderList.saleid}',300,200,'팝업1','scroll');">
				&nbsp;&nbsp;&nbsp;운송장 번호&nbsp;&nbsp;&nbsp;</button>
					        <button class="btn btn-default cancel" 
					        onclick="location.href='Product?command=order_refund&id=${orderList.saleid}&status=3';">
				&nbsp;&nbsp;&nbsp;수령확인&nbsp;&nbsp;&nbsp;</button>
					    </c:when>
					    
					    <c:when test="${orderList.deliveryStatus == 3}">
							<c:if test="${orderList.prodNo < 7}">
							<button class="btn btn-default btn-sm cancel" 
					        onclick="location.href='Product?command=order_returnform&id=${orderList.saleid}&status=3';">
				&nbsp;&nbsp;&nbsp;교환/반품신청&nbsp;&nbsp;&nbsp;</button>
							</c:if>
							배송일자: ${orderList.addrDetail}
							${orderList.prodNo}
					    </c:when>
					    
				</c:choose><br>
			</td>
		</tr>
		</c:forEach>
	</table>
	</section>
	
						
	<br>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>