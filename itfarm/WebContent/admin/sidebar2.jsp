<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- <c:if test="${empty loginUser}">
	<jsp:forward page='Admin?command=index' />
</c:if> --%>
<!DOCTYPE html>
<html lang="en">
<head>
<title></title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="script/member.js"></script>
</head>
<body>
<%
if ((session.getAttribute("isAdmin") != "1")) {
%>
<script type="text/javascript">
alert('관리자 계정으로 로그인 후 이용해주세요.');
location.href='Member?command=member_loginform';
</script>
<%
}
%>
<nav>
<%
if (session.getAttribute("loginUser") == null) // 로그인이 안되었을 때
{
%> 
<form action="Member?command=member_login" method="post" name="frm" class="login-form">
<label>아이디</label>
<input type="text" name="userid" class="form-control login">
<label>패스워드</label>
<input type="password"  name="pwd" class="form-control login">
<button class="btn btn-outline-secondary btn-sm" type="submit"
onclick=" return loginCheck()">로그인</button>
</form>
<%
} else // 로그인 했을 경우  
{
%>
<p><span>${loginUser.name} (${loginUser.userid}) </span>님, 환영합니다. &nbsp;
<button class="btn btn-outline-secondary btn-sm" type="button"
onclick="location.href='Member?command=member_logout'">로그아웃</button>
<button class="btn btn-outline-secondary btn-sm" type="button"
onclick="location.href='index.jsp'">ITFARM으로 이동</button></p>

<%
}
%>
<hr> 
</nav>

<div class="sidenav">
	<a href="Admin?command=index"><img alt="로고" src="images/logo_1.png"></a>
  	<a href="Admin?command=index">관리자 페이지</a>
  	
  	<button class="dropdown-btn">회원관리
    	<i class="fa fa-caret-down"></i>
  	</button>
  	<div class="dropdown-container">
	  	<a href="Admin?command=member_list&status=1">가입회원관리</a>
	    <a href="Admin?command=member_list&status=2">탈퇴회원조회</a>
  	</div>
  
  	<a href="Admin?command=product_list">제품관리</a>
	<!-- <a href="#">제품카테고리관리</a> -->
    <a href="Admin?command=order_list">주문관리</a>
    <a href="Admin?command=experience_list">체험관리</a>
    <a href="Admin?command=reservation_list">예약관리</a>
  <button class="dropdown-btn">게시판관리 
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="Admin?command=board2_list">문의게시판관리</a>
    <a href="Admin?command=board_list">후기게시판관리</a>
  </div>
  <button class="dropdown-btn">통계 
    <i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="Admin?command=member_month&yyyy=2018">회원통계</a>
    <a href="Admin?command=order_total">상품통계</a>
    <a href="Admin?command=order_month">주문통계</a>
    <a href="Admin?command=exp_stats">체험상품통계</a>
    <a href="Admin?command=reserv_month">예약통계</a>
  </div>
</div>

<script>
/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var dropdownContent = this.nextElementSibling;
    if (dropdownContent.style.display === "block") {
      dropdownContent.style.display = "none";
    } else {
      dropdownContent.style.display = "block";
    }
  });
}
</script>
</body>
</html>


