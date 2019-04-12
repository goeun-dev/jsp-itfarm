<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="script/product.js"></script>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>	
	<div id="wrap" align="center">
		<h1>상품 수정 - 관리자 페이지</h1>
		<form method="post" enctype="multipart/form-data" name="frm">
			<input type="hidden" name="code" value="${product.productNum}"> 
			<input type="hidden" name="nonmakeImg" value="${product.productImg}">
			<table>
				<tr>
					<td><c:choose>
							<c:when test="${empty product.productImg}">
								<img src="upload/noimage.gif">
							</c:when>
							<c:otherwise>
								<img src="http://216230029.hyw.ac.kr:8080/images/product/${product.productImg}">
							</c:otherwise>
						</c:choose></td>
					<td>
						<table>
							<tr>
								<th style="width: 80px">상품명</th>
								<td><input type="text" name="name" value="${product.name}"
									size="80"></td>
							</tr>
							<tr>
								<th>가 격</th>
								<td><input type="text" name="price"
									value="${product.price}"> 원</td>
							</tr>
							<tr>
								<th>수 량</th>
								<td><input type="number" name="count" value="${product.count}"> 개</td>
							</tr>
							<tr>
								<th>사 진</th>
								<td><input type="file" name="pictureUrl"><br>
									(주의사항 : 이미지를 변경하고자 할때만 선택하시오)</td>
							</tr>
							<tr>
					<th>카테고리</th>
					<td>
						<select name="category">
							<c:choose>
							    <c:when test="${product.category == 1}">
							        <c:set var="sensor" value="selected"/>
							    </c:when>
							    <c:when test="${product.category == 2}">
							        <c:set var="control" value="selected"/>
							    </c:when>
							    <c:when test="${product.category == 3}">
							        <c:set var="notice" value="selected"/>
							    </c:when>
							</c:choose>
							<option value="1" <c:out value="${sensor}"></c:out>>센서</option>
							<option value="2" <c:out value="${control}"></c:out>>원격제어</option>
							<option value="3" <c:out value="${notice}"></c:out>>알림</option>
						</select>
					</td>
				</tr>
						</table>
					</td>
				</tr>
			</table>
			<br> 
			<input type="submit" value="수정" onclick="return productCheck()"> 
			<input type="reset" value="다시작성"> 
			<input type="button" value="목록" onclick="location.href='Admin?command=product_list'">
		</form>
	</div>	
	</article>
</section>
	
</body>
</html>