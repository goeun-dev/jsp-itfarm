<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="script/member.js"></script>
<title>IT FARM - 로그인</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />

<!-- ********************login css 추가*********************** -->
<link rel="stylesheet" type="text/css" href="assets/css/login.css">


</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />

	<section>
		<h4>로그인</h4>
		<p>ITFARM의 다양한 혜택과 서비스를 누리세요.</p>
		<div class="container">
			<form action="Member?command=member_login" method="post" name="frm" class="login-form">
				<label for="uname"><b>아이디</b></label> <br> <input
					class="login-input" type="text" name="userid" placeholder="아이디 입력"
					value="${userid}"> <br> <label for="psw"><b>비밀번호</b></label>
				<br> <input class="login-input" type="password"
					placeholder="비밀번호 입력" name="pwd"> <br>
				<button class="login-button" type="submit" value="로그인"
					onclick=" return loginCheck()" id="btn_login">로그인</button>
				<br>
				<!-- <input class="login-check" type="checkbox"	name="remember">아이디 기억하기 -->
				<p style="color: red">${message}</p>
				<br>
				<div class="login-line"></div>
				<br>
			</form>
			<button class="button special" type="submit" value="회원 가입" onclick="location.href='Member?command=member_term'">회원가입</button>
			<button class="button alt" type="submit" value="아이디/비밀번호 찾기" onclick="location.href='Member?command=member_findid'">아이디찾기</button>
			<button class="button alt" type="submit" value="아이디/비밀번호 찾기" onclick="location.href='Member?command=member_findpwd'">비밀번호찾기</button>

			<br><br>
		</div>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>