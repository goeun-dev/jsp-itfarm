<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title>IT FARM</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	
	<!-- ==================내용 시작================== -->
	<section id="intro" class="main style1 dark fullscreen">
		<div class="content">
			<header>
				<h2>SMART FARM</h2>
			</header>
			<p>
				미래농업 사회에서 중요시 될<strong> 스마트팜</strong>이 궁금하다면 클릭하세요.
			</p>
			<br> <input type="button"
				onclick="location.href='sub/smartfarm.jsp'" class="btn1"
				value="Click"> <br> <br> <br> <br> <a
				href="#one" class="button style2 down">More</a>

		</div>
	</section>

	<section id="one" class="main style2 right dark fullscreen">
		<div class="content box style2">
			<header>
				<h2>제품구매</h2>
			</header>
			<p>더욱 편리하고 손쉬운 농업을 경험해보세요.</p>
			<input type="button" class="btn2" value="Click"
				onclick="location.href='Product?command=product_list&category='">
		</div>
		<a href="#two" class="button style2 down anchored">Next</a>
	</section>

	<section id="two" class="main style2 left dark fullscreen">
		<div class="content box style2">
			<header>
				<h2>농업체험</h2>
			</header>
			<p>도시를 벗어나 새로운 농촌체험을 경험해보세요.</p>
			<input type="button" class="btn2" value="Click"
				onclick="location.href='ExperienceList'">
		</div>
		<a href="#work" class="button style2 down anchored">Next</a>
	</section>

	<section id="work" class="main style2 right dark fullscreen">
		<div class="content box style2">
			<header>
				<h2>고객센터</h2>
			</header>
			<p>보다 더 나은 서비스를 위한 고객센터 입니다.</p>
			<input type="button" class="btn2" value="Click">
		</div>
		<a href="#event" class="button style2 down anchored">Next</a>
	</section>

	<jsp:include page="footer.jsp" flush="false" />

</body>
</html>