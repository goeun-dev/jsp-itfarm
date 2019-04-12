<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 사이트맵</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/sub_map1.css" />
</head>
<body>
	<jsp:include page="header.jsp" flush="false" />
	<section class="sm">
	<h2>사이트맵</h2>
	<hr>
	<div class="sitemap">
		<ul>
			<li><h3>
					<a href="sub/smartfarm.jsp">스마트팜</a>
				</h3></li>
			<li><a href="sub/smartfarm.jsp">소개</a></li>
		</ul>
		<ul>
			<li>
				<h3>
					<a href="Product?command=product_list&category=&order=1">제품구매</a>
				</h3>
			</li>
			<li><a href="Product?command=product_list&category=1&order=1">센서</a></li>
			<li><a href="Product?command=product_list&category=2&order=1">원격제어</a></li>
			<li><a href="Product?command=product_list&category=3&order=1">알림</a></li>
		</ul>
		<ul>
			<li><h3>
					<a href="Experience?command=experience_list">농업체험</a>
				</h3></li>
			<li><a href="sub/sub_city.jsp">체험소개</a></li>
			<li><a href="Experience?command=experience_list">체험목록</a></li>
			<li><a href="board/BoardList.jsp">체험후기</a></li>
		</ul>
		<ul>
			<li><h3>
					<a href="board2/BoardList.jsp">고객센터</a>
				</h3></li>
			<li><a href="center/faq.jsp">FAQ</a></li>
			<li><a href="board2/BoardList.jsp">문의하기</a></li>
		</ul>
		
		<ul>
			<li><h3>
					<a href="Member?command=member_mypage">마이페이지</a>
				</h3></li>
			<li><a href="Member?command=member_mypage">마이페이지</a></li>
		</ul>
		
	</div> 
	</section>
	<br>
	<br>
	<br>
	<jsp:include page="footer.jsp" flush="false" />
</body>
</html>