<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 스마트팜 상품 보기</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/productlist.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
<script src="application.js" type="text/javascript"></script>
</head>
<style>
.strong {font-weight: bold;}
</style>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<section class="sm">
	
	<section1><div class="bar">제품목록</div></section1>
	<div class="experience">
		<hr>
		<form  class='area' action="Product?command=product_list" method="get">
		
		<select name="category" 
			onchange="this.form.submit()">
			<c:choose>
					    <c:when test="${category == 1}">
					        <c:set var="sensor" value="selected"/>
					    </c:when>
					    <c:when test="${category == 2}">
					        <c:set var="control" value="selected"/>
					    </c:when>
					    <c:when test="${category == 3}">
					        <c:set var="notice" value="selected"/>
					    </c:when>
				</c:choose>
			<option value=''>카테고리 선택</option>
			<option value='1' <c:out value="${sensor}"></c:out>>센서</option>
			<option value='2' <c:out value="${control}"></c:out>>원격제어</option>
			<option value='3' <c:out value="${notice}"></c:out>>알림</option>
		</select>
		
		  
		<select onchange="if(this.value) location.href=(this.value);">
			<c:choose>
						<c:when test="${order == 1}">
							<c:set var="o1" value="selected"/>
						</c:when>
						<c:when test="${order == 2}">
							<c:set var="o2" value="selected"/>
						</c:when>
						<c:when test="${order == 3}">
							<c:set var="o3" value="selected"/>
						</c:when>
						<c:when test="${order == 4}">
							<c:set var="o4" value="selected"/>
						</c:when>
			</c:choose>
		 	
			<option value="">조건선택</option>
			<option value="Product?command=product_list&category=${category}&order=1"${o1}>신상품</option>
			<option value="Product?command=product_list&category=${category}&order=2"${o2}>낮은가격</option>
			<option value="Product?command=product_list&category=${category}&order=3"${o3}>높은가격</option>
			<option value="Product?command=product_list&category=${category}&order=4"${o4}>인기순</option>
		</select>
		<input type="hidden" name="command" value="product_list">
		<input type="hidden" name="order" value="${order}">		
		</form><br>
               
		 <div id="content">
		  <h3 class="rank-h3">급상승 인기상품</h3>
            <dl id="rank-list">
                <dd>
                    <ol>
                    	<c:set var="rankNum" value="0"></c:set>
                        <c:forEach var = "rank" items = "${rankList}">
                        <c:set var="rankNum" value="${rankNum+1}"></c:set>
                        <li>${rankNum}. ${rank.name}</li>
                        </c:forEach>
                    </ol>
                </dd>
            </dl>
        </div>
		 
		<div id="main">
			<div class="inner">
				<!-- Boxes -->
				<div class="thumbnails">
				<c:forEach var="product" items="${productList}">
					<div class="box">
						<a href="Product?command=product_detail&productNum=${product.productNum}" class="image fit">
						<img src="images/product/${product.productImg}" 
								width=300px height=250px /></a>
						<div class="inner">
							<h3>
							${product.name}
							</h3>
							<p><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/>원</p>
							<c:choose>
								    <c:when test="${product.count == 0}">
								        <p>품절</p>
								    </c:when>
							</c:choose>
							<!-- <a href="Product?command=product_detail&productNum=${product.productNum}" class="button fit">상세보기</a> -->
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
		
		<div class="page">
			<ul>
				<li><a href="#"><</a></li>
				<li><a href="#">1</a></li>
							<!-- <li><a href="#">2</a></li>
				<li><a href="#">3</a></li>
				<li><a href="#">4</a></li>
				<li><a href="#">5</a></li> -->
				<li><a href="#">></a></li>
			</ul>
		</div>
	</div>
	</section>
	
	<jsp:include page="../footer.jsp" flush="false" />

<script type="text/javascript">
            $(function() {
            var count = $('#rank-list li').length;
            var height = $('#rank-list li').height();

            function step(index) {
                $('#rank-list ol').delay(2000).animate({
                    top: -height * index,
                }, 500, function() {
                    step((index + 1) % count);
                });
            }

            step(1);
        });
        </script>

</body>
</html>