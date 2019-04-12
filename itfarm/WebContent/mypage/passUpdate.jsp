<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="script/member.js"></script>
<title>IT FARM - 비밀번호 변경</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="assets/css/join.css">
<script type="text/javascript" src="member.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />

	<section>
		<div class="container">
			<h1>비밀번호 변경</h1>
			<p>변경 할 비밀번호를 입력하세요.</p>
			<hr>
			<form action="Member?command=member_passupdate" method="post"
				name="frm" class="login-form">
				<label for="pwd"><b>현재 비밀번호 입력</b></label> <br>
				<div class="input-align">
					<input type="password" name="pwd1" placeholder="현재 비밀번호 입력">
				</div>

				<br> <label for="pwd"><b>변경할 비밀번호 입력</b></label> <span
					class="desc">&nbsp;&nbsp;영문소문자, 숫자, 특수문자 중 두가지 이상 조합 / 4~16자</span>
				<div class="input-align">
					<input type="password" placeholder="변경할 비밀번호" id="pwd" name="pwd"
						onkeyup="passRgex(event)" required> <span id="keyinfo1"></span>
				</div>

				<label for="pwd_check"><b>변경할 비밀번호 재입력</b></label>
				<div class="input-align">
					<input type="password" placeholder="변경할 비밀번호 재입력" id="pwd_check"
						name="pwd_check" onblur="passCheck2()" onkeyup="passCheck2(event)"
						required> <span id="keyinfo3"></span><br>
					<p style="color: red">${message}</p>
				</div>

				<br>
				<button type="button" class="cancelbtn"
					onclick="location.href='Member?command=member_mypage'">취소</button>
				<button class="login-button" type="submit" value="변경하기"
					onclick=" return joinCheck()" id="btn_login">변경하기</button>
				<br> <br> <br>
			</form>
			<br> <br>
		</div>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>