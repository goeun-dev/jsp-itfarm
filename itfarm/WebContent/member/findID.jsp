<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="script/member.js"></script>
<title>IT FARM - 아이디 찾기</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<!-- ----------탭 레이아웃 부트스트랩---------- -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="assets/css/join.css">
<style type="text/css">
button {
    height: 50px;
    color: white;
    border: none;
    cursor: pointer;
    width: 50%;
    opacity: 0.9;
    background: #ddd;
    border-radius: 0;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />

	<section>
		<div class="container">
			<h1>아이디 찾기</h1>
			<p>가입 시 입력한 정보를 작성해주세요.</p>
			<hr>

			<ul class="nav nav-tabs">
				<li class="active"><a data-toggle="tab" href="#phone">휴대전화로 찾기</a></li>
				<li><a data-toggle="tab" href="#email">이메일로 찾기</a></li>
			</ul>

			<div class="tab-content">
				<!-- 휴대전화로 찾기 -->
				<div id="phone" class="tab-pane fade in active">
					<br>
					<form action="FindId" method="post" name="frm" class="login-form">
						<label for="uname"><b>이름</b></label> <br>
						<div class="input-align">
							<input class="login-input" type="text" name="name" placeholder="이름을 입력해주세요." required>
						</div>

						<br> <label for="phone"><b>휴대전화</b></label>
						<div class="input-align">
							<input type="text" name="phone1" maxlength="3" required> - 
							<input type="text"	name="phone2" maxlength="4" required> - 
							<input type="text" name="phone3" maxlength="4" required>
						</div>
						<br> <br>
						<button type="button" class="cancelbtn" onclick="location.href='Member?command=member_loginform'">취소</button>
						<button class="login-button" type="submit" value="아이디 찾기" onclick=" return loginCheck()" id="btn_login">아이디 찾기</button>
						<br>
						<p style="color: red">${message}</p>
						<br> <br>
					</form>
				</div>

				<!-- 이메일로 찾기 -->
				<div id="email" class="tab-pane fade">
					<br>
					<form action="FindId" method="post" name="frm" class="login-form">
						<label for="uname"><b>이름</b></label> <br>
						<div class="input-align">
							<input class="login-input" type="text" name="name"
								placeholder="이름을 입력해주세요." required>
						</div>

						<br> <label for="psw"><b>이메일</b></label> <br>
						<div class="input-align email">
							<input type="text" placeholder="이메일을 입력해주세요." name="email1"
								value="${mVo.email1}" required>@ <input type="text"
								placeholder="" name="email2" value="${mVo.email2}" required>
						</div>
						<br> <br>
						<button type="button" class="cancelbtn" onclick="location.href='Member?command=member_loginform'">취소</button>
						<button class="login-button" type="submit" value="아이디 찾기"
							onclick=" return loginCheck()" id="btn_login">아이디 찾기</button>
						<br>
						<p style="color: red">${message}</p>
						<br> <br>
					</form>
				</div>
			</div>
		</div>
		<br> <br>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>