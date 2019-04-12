<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<link rel="stylesheet" href="assets/css/experiencelist.css" />
<title>농업체험조회</title>
<style type="text/css">
.imgs {
	width: 15%;
}
</style>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>	
	<div class="left-loc">
	<a href="Admin?command=index">홈</a> 
	<span> > </span> 
	<a href="">체험목록</a>
	</div>
		<div id="wrap" align="center">
		<h5>체험 목록</h5>
		<div class="">
		<form action="Admin?command=experience_list" method="post">
			<select class='area' name="searchSidoCode"
				onchange="this.form.submit()">
				<c:choose>
					    <c:when test="${category == 1}">
					        <c:set var="sensor" value="selected"/>
					    </c:when>
					    <c:when test="${category == 2}">
					        <c:set var="control" value="selected"/>
					    </c:when>
					    <c:when test="${category == 3}">
					        <c:set var="notice" value="selected"/>
					    </c:when>
				</c:choose>
				<option value='' selected>${sdName}</option>
				<option value='6490000'>제주도‎</option>
				<option value='6290000'>광주광역시</option>
				<option value='6270000'>대구광역시‎</option>
				<option value='6440000'>충청남도</option>
				<option value='6430000'>충청북도</option>
				<option value='6420000'>강원도</option>
				<option value='6480000'>경상남도</option>
				<option value='6470000'>경상북도</option>
				<option value='6410000'>경기도</option>
				<option value='6260000'>부산광역시‎</option>
				<option value='6450000'>전라북도</option>
				<option value='6460000'>전라남도</option>
			</select>
			<input type="hidden" value="1" name="pageNo">
		</form>
		</div>
		<table class="list table table-bordered table-sm">
			<tr>
				<!-- <th>
				<input type="checkbox"  name="checkAll" >
				</th> -->
				<th>체험번호</th>
				<th>체험명</th>
				<th>가격(성인)</th>
				<th>가격(어린이)</th>
				<th>마을명</th>
				<th>지역명</th>
			</tr>
			<c:forEach var="exList" items="${exList}">
			${emp}
				<tr class="record">
					<%-- <td class="chk"><input type="checkbox" name="checkOne" value="${exList.prodCode}"></td> --%>
					<td>${exList.prodCode}</td>
					<td><a href="Admin?command=experience_detail&prodCode=${exList.prodCode}&imgPath=${exList.imgPath}">${exList.title}</a></td>
					<td align="right">
						<fmt:formatNumber value="${exList.adultPrice}" type="number" pattern="#,##0"/> 원
					</td>
					<td align="right">
						<fmt:formatNumber value="${exList.childPrice}" type="number" pattern="#,##0"/> 원
					</td>
					<td>${exList.villageName}</td>
					<td>${exList.sidoName}</td>
				</tr>
			</c:forEach>
		</table>
			<div class="page">
			<form  action="Admin?command=experience_list" method="post" name="paging">
			<input type="hidden" name="searchSidoCode" value="6290000">
				<ul>
					<!-- <li><a href="#"><</a></li> -->
					<li><input value="<"  type="button"></li>
				<c:forEach var="pageCount" items="${pageCount}">
					<%-- <li><input value="${pageCount}" name="pageNo" type="text"  onclick="document.paging.submit()" readonly ></li> --%>
					<li><a href="Admin?command=experience_list&searchSidoCode=${searchSidoCode}&pageNo=${pageCount}">${pageCount}</a></li>
				</c:forEach>
					<li><input value=">"  type="button"></li>
				</ul>
			</form>
			</div>
		</div>	
	</article>
</section>
</body>
</html>