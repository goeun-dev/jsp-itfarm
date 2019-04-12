<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원관리</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>	
	<div class="left-loc">
	<a href="Admin?command=index">홈</a> 
	<span> > </span> 
	<a href="Admin?command=member_list&status=2">탈퇴회원조회</a>
	</div>
	<div id="wrap" align="center">
		<h5>탈퇴 회원 조회</h5>
		
		<%-- <div class="search_div">
		<form action="Admin?command=product_search" class="search_form" method="post">
			<label>구분</label>
			<select name="searchCategory">
				<c:choose>
					    <c:when test="${searchCategory == 1}">
					        <c:set var="sensor" value="selected"/>
					    </c:when>
					    <c:when test="${searchCategory == 2}">
					        <c:set var="control" value="selected"/>
					    </c:when>
					    <c:when test="${searchCategory == 3}">
					        <c:set var="notice" value="selected"/>
					    </c:when>
				</c:choose>
				<option value="">선택</option>
				<option value="1" <c:out value="${sensor}"></c:out>>성명</option>
				<option value="2" <c:out value="${control}"></c:out>>아이디</option>
			</select>
			<input type="text" name="searchName" value="${searchName}">
			<label for="dmem">탈퇴회원 제외</label>
			<input type="checkbox" id="dmem">
			<button class="btn btn-secondary btn-sm" type="submit">검색</button>
		</form>
		</div> --%>
				
		<table class="list table table-bordered table-sm">
			<tr>
				<th>이름</th>
				<th>아이디</th>
			</tr>
			<form name="form1" method="post" action="Admin?command=member_delete" id="checkList">
			<c:forEach var="member" items="${memberList}">
			${emp}
				<tr class="record">
					<td>${member.name}</td>
					<td>${member.userid}</td>
					
				</tr>
			</c:forEach>
			</form>
		</table>	
	</div>	
	</article>
</section>
</body>
</html>