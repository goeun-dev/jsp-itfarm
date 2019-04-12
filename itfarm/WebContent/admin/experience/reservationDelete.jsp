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
		<form action="Admin?command=reservation_delete" method="post">
			<table>
				<tr>
					<td>${reservation.expid}</td>
					<td>
						<table>
							<tr>
								<th style="width: 80px">회원 아이디</th>
								<td>${reservation.userid}</td>
							</tr>
							<tr>
								<th>가 격</th>
								<td>${reservation.price}원</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br> <input type="hidden" name="expid" value="${reservation.expid}">
			<input type="submit" value="삭제"> <input type="button"
				value="목록" onclick="location.href='Admin?command=reservation_list'">
		</form>
	</div>	
	</article>
</section>
</body>
</html>