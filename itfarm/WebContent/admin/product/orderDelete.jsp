<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>	
	<div id="wrap" align="center">
		<h1>상품 삭제 - 관리자 페이지</h1>
		<form action="Admin?command=product_delete" method="post">
			<table>
				<tr>
					<td><c:choose>
							<c:when test="${empty product.productImg}">
								<img src="upload/noimage.gif">
							</c:when>
							<c:otherwise>
								<img src="images/product/${product.productImg}">
							</c:otherwise>
						</c:choose></td>
					<td>
						<table>
							<tr>
								<th style="width: 80px">상 품 명</th>
								<td>${product.name}</td>
							</tr>
							<tr>
								<th>가 격</th>
								<td>${product.price}원</td>
							</tr>
							<tr>
								<th>카테고리</th>
								<td><div style="height: 220px; width: 100%">
								<c:choose>
							    <c:when test="${product.category == 1}">
							        <c:set var="sensor" value="센서"/>
							    </c:when>
							    <c:when test="${product.category == 2}">
							        <c:set var="sensor" value="원격제어"/>
							    </c:when>
							    <c:when test="${product.category == 3}">
							        <c:set var="sensor" value="알림"/>
							    </c:when>
							</c:choose>
										<c:out value="${sensor}"></c:out></div></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br> <input type="hidden" name="productNum" value="${product.productNum}">
			<input type="submit" value="삭제"> <input type="button"
				value="목록" onclick="location.href='Admin?command=product_list'">
		</form>
	</div>	
	</article>
</section>
	
</body>
</html>