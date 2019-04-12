<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 취소 내역</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
div {
	text-align: center;
	padding-top: 15px;
	padding-bottom: 10px;
}
</style>
</head>
<body>
<form action="Admin?command=delivery_update" method="post">
	<div>
		<h3>운송장 번호 등록</h3>
		<hr>
		<label for="dno">운송장 번호</label>
		<input type="text" name="dno" id="dno">
		<input type="hidden" name="saleid" value="${saleid}">
		<br>
		<br>
		<button class="btn" type="submit">등록</button>
	</div>	
</form>	
</body>
</html>