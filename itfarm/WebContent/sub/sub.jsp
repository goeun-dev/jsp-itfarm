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
<link rel="stylesheet" href="../assets/css/main.css" />

<link rel="stylesheet" type="text/css" href="../assets/css/join.css">


</head>
<body>
<!-- ======================헤더====================== -->
	<header id="header">
		<a href="../index.jsp"><img id="logo" src="../images/logo_1.png"></a>
		<nav>
			<ul>
				<li><a href="smartfarm.jsp"><strong>스마트팜</strong></a></li>
				<li><a href="sub.jsp"><strong>제품구매</strong></a></li>
				<div class="dropdown">
					<a href="#work"><strong>도시농업체험</strong></a>
					<div class="dropdown-content">
						<a href="#">체험소개</a> <a href="#">예약하기</a> <a href="#">예약확인</a> <a
							href="#">체험후기</a>
					</div>
				</div>
				<div class="dropdown">
					<a href="#work"><strong>고객센터</strong></a>
					<div class="dropdown-content">
						<a href="#">FAQ</a> <a href="#">제품문의</a> <a href="#">설치문의</a> <a
							href="#">예약문의</a>
					</div>
				</div>
				<li><a href="#event"><strong>이벤트</strong></a></li>
				<li><a href="content"><strong>사이트맵</strong></a></li>
				<li><a href="../Login"><strong>로그인</strong></a></li>
			</ul>
		</nav>
	</header>
<!-- ======================헤더 끝====================== -->

	<section>
		<h4>서브페이지 테스트 FARM</h4>
		<p>ITFARM의 다양한 혜택과 서비스를 누리세요.</p>
		<a href="smartfarm.jsp">test</a>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>