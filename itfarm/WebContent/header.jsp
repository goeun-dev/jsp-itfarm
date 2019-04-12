<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
<header id="header">

	<a href="index.jsp"><img id="logo" src="images/logo_1.png"></a>
	<nav>
		<ul>
			<div class="dropdown">
				<a href="sub/smartfarm.jsp"><strong>스마트팜</strong></a>
			</div>
			<div class="dropdown">
				<a href="Product?command=product_list&category=&order=1"><strong>제품구매</strong></a>
			</div>
			<div class="dropdown">
				<a href="Experience?command=experience_list"><strong>농업체험</strong></a>
				<div class="dropdown-content">
					<a href="sub/sub_city.jsp">체험소개</a> 
					<a href="Experience?command=experience_list">체험목록</a>  
					<a href="board/BoardList.jsp">체험후기</a>
				</div>
			</div>
			
			<div class="dropdown">
				<a href="board2/BoardList.jsp"><strong>고객센터</strong></a>
				<div class="dropdown-content">
					<a href="center/faq.jsp">FAQ</a>
					 <a href="board2/BoardList.jsp">문의하기</a> 
				</div>
			</div>
			<%
			if ((session.getAttribute("isAdmin") == "1")) {
			%>
			<div class="dropdown">
				<a href="Admin?command=index"><strong>관리자페이지</strong></a>
			</div>
			<%
			}
			%>
			<%
				if (session.getAttribute("loginUser") != null) 
				{
			%>
			
			<div class="dropdown">
			<a href="#"><strong>${loginUser.name}님</strong></a>
				<div class="dropdown-content">
					<a href="Member?command=member_mypage&userid=${loginUser.userid}">마이페이지</a>
					<a href="Member?command=member_logout">로그아웃</a>
				</div>
			</div>
			
			<%
				} 
			%>
			
			<%
				if (session.getAttribute("loginUser") == null) // 로그인이 안되었을 때
				{
			%>
			<li><a href="Member?command=member_loginform" title="로그인" ><i class="fas fa-lock"></i></a></li>
			<%
				} else // 로그인 했을 경우
				{
			%>
			
			<%
				}
			%> 
						
			<div class="dropdown">
			<a href="sitemap.jsp" title="사이트맵"><i class="fas fa-sitemap"></i></a>
			</div>
		</ul>
	</nav>
</header>