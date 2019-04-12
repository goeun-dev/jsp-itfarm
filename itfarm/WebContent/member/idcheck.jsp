<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 아이디 중복 확인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript" src="script/member.js"></script>

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
</style>
</head>
<body>
	<form action="IdCheck" method="get" name="frm">
	<h3>중복 확인</h3>
	<hr> 
		<div class="input-align">
		<!-- <label for="userid"><b>입력 아이디</b></label> -->
		<input type="hidden" name="userid" value="${userid}" style="background: white; font-size: 1.5em;" readonly="readonly"> 
		</div>
		<c:if test="${result == 1}">
			<script type="text/javascript">
				opener.document.frm.userid.value = "";
			</script>
			${userid}는 이미 사용 중인 아이디입니다.
			<br><br>
			<input type="button" value="다른 아이디 입력하기" class="btn" onclick="self.close();">
		</c:if>
		<c:if test="${result==-1}">
		${userid}는 사용 가능한 아이디입니다.
		<br><br>
		<input type="button" value="사용하기" class="btn" onclick="idok('${userid}')" >
		</c:if>
	</form>
</body>
</html>