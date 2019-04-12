<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="script/reservation.js"></script>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>		
		<div id="wrap" align="center">
		<h1>예약 수정 - 관리자 페이지</h1>
		<form method="post" action="Admin?command=reservation_update" name="frm">
			<input type="hidden" name="expid" value="${reservation.expid}">
			<input type="hidden" name="nonmakeImg" value="${reservation.expid}">
			<table>
				<tr>
					<th style="width: 80px">예약번호</th>
					<td>${reservation.expid}</td>
				</tr>
				<tr>
					<th style="width: 80px">체험명</th>
					<td>${reservation.expName}</td>
				</tr>
				<tr>
					<th style="width: 80px">결제수단</th>
					<td>${reservation.payment}</td>
				</tr>
				<tr>
					<th style="width: 80px">상품코드</th>
					<td>${reservation.prodcode}</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>${reservation.userid}</td>
				</tr>
				<tr>
					<th style="width: 80px">인원수(성인)</th>
					<td><input type="number" name="adultNum" value="${reservation.adultNum}">
						명</td>
				</tr>
				<tr>
					<th style="width: 80px">인원수(어린이)</th>
					<td><input type="number" name="childNum" value="${reservation.childNum}"
						size="80">명</td>
				</tr>
				<tr>
					<th style="width: 80px">체험일자</th>
					<td><input type="text" name="eDate" value="${reservation.eDate}"
						size="80"></td>
				</tr>
				<tr>
					<th style="width: 80px">결제일자</th>
					<td><input type="text" name="rDate" value="${reservation.rDate}"
						size="80"></td>
				</tr>
				<tr>
					<th style="width: 80px">가격</th>
					<td><input type="text" name="price" value="${reservation.price}"
						size="80"></td>
				</tr>
			</table>
			<br> 
			<input type="submit" value="수정" onclick="return reservationCheck()"> 
			<input type="reset" value="다시작성"> 
			<input type="button" value="목록"	onclick="location.href='Admin?command=reservation_list'">
		</form>
	</div>
	</article>
</section>
	
</body>
</html>