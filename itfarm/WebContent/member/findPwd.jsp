<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="script/member.js"></script>
<title>IT FARM - 비밀번호 찾기</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<!-- <link rel="stylesheet" type="text/css" href="assets/css/join.css"> -->
<link rel="stylesheet" type="text/css" href="assets/css/password.css">


</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />

	<section>
	<div class="container">
		<h1>비밀번호 찾기</h1>
		<p>사용자 이름이나 계정에 연결된 이메일 주소를 사용해서 비밀번호를 재설정할 수 있도록 도와 드리겠습니다.</p>
		<hr>
		
			<form action="login.do" method="post" name="frm" class="login-form">
				<label for="uname"><b>이름</b></label> <br>
				<div class="input-align">
				<input class="login-input" type="text" name="name" placeholder="이름 입력">
				</div> 
				<br> 
				<label for="uname"><b>아이디</b></label> <br>
				<div class="input-align">
				<input class="login-input" type="text" name="name" placeholder="아이디 입력">
				</div> 
				<br> 
				<label for="psw"><b>이메일</b></label>
				<br>
				<div class="input-align"> 
				<input type="text" name="phone1" maxlength="3" value="" onblur="phCheck()" required> @
				<input type="text" name="phone2" maxlength="4" value="" onblur="phCheck()" required> 
				</div>
				<br><br>
				<button type="button" class="cancelbtn" onclick="location.href='Member?command=member_loginform'">취소</button>
				<button class="" type="submit" value="아이디 찾기" onclick=" return loginCheck()" id="btn_login">비밀번호 찾기</button>
				<br>
				<p style="color: red">${message}</p>
				<br>
				<br>
			</form>
			<br><br>
		</div>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>