<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<link rel="stylesheet" type="text/css" href="assets/css/admin_index.css">
</head>
<body>
	<section class="main">
		<jsp:include page="sidebar.jsp" flush="false" />
		<article>
			<h3></h3>
			<span>(이번달 현황)</span><br>
			<%-- <table class="tb11">
				<tr>
					<td>
					<h4>판매수익
					</h4>
					<h2>84,000원 <span>3건</span></h2>
					</td>
					<td>
					<h4>예약수익
					</h4>
					<h2>84,000원 <span>3건</span></h2>
					</td>
					<td>
					<h4>총수익
					</h4>
					<h2>84,000원 <span>3건</span></h2>
					</td>
					<td>
					<h4>가입자수
					</h4>
					<h2>${mem}명 <span></span></h2>
					</td>
				</tr>
			</table> --%>
			<br>
			<h4>주문 현황</h4>
			<table class="tb22">
				<tr>
					<td colspan="2">
					<c:forEach var="sts0" items="${sts0}">
					<b>주문완료</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
					<td colspan="2">
					<c:forEach var="sts0" items="${sts1}">
					<b>결제완료</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>

				</tr>
				<tr>
					<td colspan="2">
					<c:forEach var="sts0" items="${sts2}">
					<b>배송중</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
					<td colspan="2">
					<c:forEach var="sts0" items="${sts3}">
					<b>배송완료</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
				</tr>

			</table>
			
			<table class="tb33" style='margin: 0px 0px 0px 1%;'>
				<tr>
					<td>
					<c:forEach var="sts0" items="${sts4}">
					<b>취소완료</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
					<td colspan="1">
					<c:forEach var="sts0" items="${sts5}">
					<b>반품요청</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
				</tr>

				<tr>
					<td colspan="1">
					<c:forEach var="sts0" items="${sts6}">
					<b>반품완료</b>
					<span>${sts0.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
					<td colspan="1">
					<c:forEach var="sts7" items="${sts7}">
					<b>반품취소</b>
					<span>${sts7.category} 건</span>
					<p>
					<fmt:formatNumber value="${sts7.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
				</tr>

			</table>
			<br><br><br><br>
			<h4 class="index_h3">예약 현황</h4>
			<table class="tb22">
				<tr>
					<td colspan="2">
					<c:forEach var="rs" items="${rs}">
					<b>예약완료</b>
					<span>${rs.expName} 건</span>
					<p>
					<fmt:formatNumber value="${rs.price}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
					<td colspan="2">
					<c:forEach var="rsc" items="${rsc}">
					<b>예약취소</b>
					<span>${rsc.expName} 건</span>
					<p>
					<fmt:formatNumber value="${rsc.price}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
					</td>
				</tr>
			</table>
			<table class="tb33" style='margin: 0px 0px 0px 1%;'>
				<tr>
					<td colspan="1">
					<c:forEach var="rs" items="${rs}">
					<b>가입현황</b>
					<span>${mem} 명</span>
					<p>
					${mem} 명
					</p>
					</c:forEach>
					</td>
				</tr>
			</table>

		</article>
	</section>
</body>
</html>