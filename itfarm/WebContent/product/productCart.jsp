<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<title>ITFARM - 장바구니</title>


<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body_1.css" />
<link rel="stylesheet" href="assets/css/cart.css" />
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="script/cart.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<section>
		<br>
		<h3>장바구니</h3>
		<p>구매하실 상품을 확인하세요.</p>
		<hr>
		<!-- <p class="small">* 장바구니에 담긴 상품은 7일 동안 보관됩니다.</p> -->
<br>
		<table class="content1 table">
			<tr class="main1">
				<td class="td1">
				<input type="checkbox"  name="checkAll" >
				</td>
				<td class="td2">상품명</td>
				<td class="td3">판매가</td>
				<td class="td4">수량</td>
				<td class="td5">합계</td>
				<!-- <td class="td6">배송비</td> -->
				<td class="td7">선택</td>
			</tr>

			<c:set var = "sum1" value = "0" />
			<c:set var = "sum2" value = "0" />
			<form name="form1" method="post" id="checkList">
			
			<c:forEach var="cart" items="${cartList}">
			${cartEmpty}
			<tr class="sub1">
				<td><input type="checkbox" name="checkOne" id="${cart.id}" 
				value="${cart.id},${cart.pid},${cart.num},${cart.count},${cart.pname}"  
				<c:if test="${cart.count == 0}">
				disabled 
				</c:if> class="chk-hidden"></td>
				<td>
					<div class="box1 cont">
						<c:if test="${cart.count == 0}">
							<img class="box1 image" src="images/product/${cart.pimg}">
							<div class="middle">
								<div class="text">품절</div>
							</div>
						</c:if>
						<c:if test="${cart.count != 0}">
						<img class="box1" src="images/product/${cart.pimg}">
						</c:if>
					</div>
					<div class="box2">
						<a href="Product?command=product_detail&productNum=${cart.pid}">${cart.pname}</a>
					</div>
				</td>
				<td id="pprice"><fmt:formatNumber value="${cart.pprice}" type="number" pattern="#,##0"/>원</td>
				<td>
					<div class="numbox1">
						<input id="num" name="num" type="text" class="pnum list_num" value="${cart.num}" id="count${cart.id}" readonly>
						<c:set var= "sum1" value="${cart.pprice * cart.num}"/>
						<c:set var= "sum2" value="${sum2 + sum1}"/>
					</div>
					<div class="numbox2">
						<input id="id" type="hidden" class="pnum list_num" value="${cart.id}">
						<a href="#" onclick="update${cart.id}()" class="abtn2 button2">변경</a>
						<script type="text/javascript">
						function update${cart.id}() {
							//var count = document.getElementById(count${cart.id}).value;
							var popupX = (window.screen.width / 2) - (200 / 2);
							// 만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
							var popupY= (window.screen.height /2) - (300 / 2);
							// 만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
							var url = "Product?command=cart_updateform&id=" + ${cart.id}+"&num="+${cart.num}+"&productNum="+${cart.pid};
							window.open(url, "_blank_1",
											"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=270");
						}
						</script>
					</div>
				</td>
				<td><fmt:formatNumber value="${sum1}" type="number" pattern="#,##0"/>원</td>
				
				<%-- <td><fmt:formatNumber value="2500" type="number" pattern="#,##0"/>원</td> --%>
				<td>
					<a href="#" onclick="buy2(${cart.id})" class="abtn2 button2">구매</a><br>
					<a href="Product?command=cart_deleteone&id=${cart.id}" class="abtn2 button2">삭제</a>
				</td>
			</tr>
			</c:forEach>
			</form>
		</table>
		<p>${cartEmpty}</p>
		<p class="small left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		&nbsp;&nbsp;&nbsp;&nbsp;
		* 7만원 이상 구매시 무료배송입니다.</p><br>
		<hr>
		<div class="btn2">
		<a href="#" onclick="checkDel();" class="left abtn button2">선택상품 삭제하기</a>
			<a  href="Product?command=cart_delete	"  class="right abtn button2">장바구니 비우기</a>
		</div>
		<br><br>
		<table  class="content1">
			<tr>
				<td>총 상품금액</td>
				<td>총 배송비</td>
				<td>총 결제금액</td>
			</tr>
			<tr>
				<td><p><span id="tprice"><%-- <c:out value="${sum2}"/> --%>
				<fmt:formatNumber value="${sum2}" type="number" pattern="#,##0"/>
				</span> 원 </p></td>
				<td><p>+
				<c:choose>
				    <c:when test="${sum2>=70000}">
				        <c:set var="del" value="0"/>
				    </c:when>
				    <c:when test="${sum2==0}">
				        <c:set var="del" value="0"/>
				    </c:when>
				    <c:when test="${sum2<70000}">
				        <c:set var="del" value="2500"/>
				    </c:when>
				</c:choose>
				 
				<fmt:formatNumber value="${del}" type="number" pattern="#,##0"/>원</p></td>
				<td><p>=
				<c:set var="total" value="${sum2 + del}"/> 
				<fmt:formatNumber value="${total}" type="number" pattern="#,##0"/>원</p></td>

			</tr>
			
		</table>

		<div class="btn">
			<a href="Product?command=product_list&category=" class="abtn button2">쇼핑계속하기</a>
			<a href="#" onclick="buy();" class="abtn button">구매하기</a>			
		</div>
<br><br>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>