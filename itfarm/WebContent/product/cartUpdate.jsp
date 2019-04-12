<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 수량 변경</title>
<script type="text/javascript" src="script/member.js"></script>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/join.css" />
<style type="text/css">
input.cancel {
	padding: 0;
	border-radius: 8px;
	background-color: white;
	border: 1px solid #333;
	color: #333;
	font-size: 13px;
	width: 140px;
}
form {
	text-align: center;
}
.button {
	background-color: #A8CEA4;
	border-radius: 4px;
	border: 0;
	color: #ffffff !important;
	cursor: pointer;
	display: inline-block;
	font-weight: 400;
	height: 2.85em;
	line-height: 2.95em;
	padding: 0 1.5em;
	text-align: center;
	text-decoration: none;
	white-space: nowrap;
}

.button:hover {
	background-color: #B6D7A8;
}
</style>
</head>
<body>
	<form action="Product?command=cart_update" method="post" name="frm">
	<h3>수량 변경</h3>
	<hr> 
		<div class="input-align">
		
		<input id="id" name="id" type="hidden" class="pnum list_num" value="${id}">
		<input name="count" type="hidden" class="pnum list_num" value="${product.count}">
		<input id="num" name="num" type="number" class="pnum list_num" value="${num}" min="1">
		
		</div>
		
		<br><br>
		
		<button type="submit" class="button" >변경</button>
		
	</form>
</body>
</html>