<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 상품 상세보기</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/productdetail.css" />
<script type="text/javascript">
function mySubmit(index) {
	if (document.myForm.num.value == 0){
		alert("수량을 입력해주세요");
		return false;
	} else {
		if (index ==1){
			document.myForm.action='Product?command=cart_add';
		}
		if (index ==2){
			document.myForm.action='Product?command=product_buyform';
		}
	}
	document.myForm.submit();
}

/* count */	
var num = 1;
var countEl = document.myForm.getElementById("num");
function plus() {
	num++;
	countEl.value = num;
	//plus(document.form1); 
}
function minus() {
	if (count > 1) {
		num--;
		countEl.value = num;
	}
}

function my_calc(item, item_count, item_sum) {

	if (item_count.value == "")
		var count = 0;
	else
		var count = item_count.value;

	item_sum.value = eval(item.value) * eval(count);

	my_total(document.myForm);

}

function my_total(f) {
	var totalS = eval(f.intro_sum.value);
	f.total.value = totalS.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

</script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<!-- <section><div class="bar">제품구매</div></section> -->
	<div class="content">
		<section>제품구매</section>
		<div class="info_l">
			<img class="img1" src="images/product/${product.productImg}" alt="main">
		</div>
		
		<div class="info_r">
		
		<form name="myForm" method="post" autocomplete="off">
			<div class="name">${product.name}</div>
			<br>
			<p class="pd">판매가격</p>
			<input type="hidden" name="intro" value="${product.price}">
			<div class="price"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/>원</div>
		
			<p class="pd">수량 </p>&nbsp;
			<input type="number" name="num"
							onclick="my_calc(this.form.intro, this.form.num, this.form.intro_sum)"
							placeholder="0" id="intro_count" min="1" max="${product.count}" width="5px" onkeyup="my_calc(this.form.intro, this.form.num, this.form.intro_sum)"> 개
			<input type="hidden" name="intro_sum" size=6 readonly value="0">
			<br><br>
			<input type="hidden" value="${loginUser.userid}" name="mid">
			<input type="hidden" value="${product.productNum}" name="pid">
			<input type="hidden" value="${product.count}" name="count">
			<input type="hidden" value="${product.productImg}" name="img">
			<input type="hidden" value="${product.name}" name="name">
			<input type="hidden" value="${product.price}" name="price">
			 <!-- onchange="this.form.submit() -->
			<!-- <a id="cart" href="#" onclick="'return info_chk1(this.form);'"><button class="button special">장바구니</button></a>
			<a id="buy" href="#"onclick="'return info_chk2(this.form);'"><button class="button special">구매하기</button></a> -->
			<p class="pd">부가정보</p><p class="p1"><fmt:formatNumber value="${product.count}" type="number" pattern="#,##0"/>개 구매 가능</p> 
			<br><br>
			<p class="pd">총 상품금액</p><p class="p1">
			<input type="text" class="hinput" name="total" value="0" readonly> 원</p>
			<br>
			<c:choose>
				<c:when test="${product.count == 0}">
				<p class="pd">품절된 상품 입니다.</p>
				</c:when>
				<c:when test="${product.count != 0}">
				<a href="#" type="button" onclick="mySubmit(1)" class="button special">장바구니</a>
				<a href="#" type="button" onclick="mySubmit(2)" class="button special">구매하기</a>
				</c:when>
			</c:choose>
		</form>
		</div>
	</div>

	<div class="subprice"></div>

	<div class="subimg">
	<h5>제품설명</h5>
	<hr>
		${fn:replace(product.description, cn, br)}
	</div>
	<div class="button2">
		<a href="#" onclick="history.back();"><button class="button alt">목록으로</button></a>
	</div>
	
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>