<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 농업체험</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/experiencelist.css" />
<style type="text/css">
.imgs {
	width: 15%;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
<section1><div class="bar">체험목록</div></section1>
		<div class="experience">			
			
			
			
			<hr>
			<form action="Experience?command=experience_list" method="post">
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
			<div id="main">
			
				<div class="inner">
				<p>'${sdName}' 지역에 총 ${exLength}개의 상품이 있습니다.</p>
					<!-- Boxes -->
					<div class="thumbnails">${lengthZero}
					<form action="Experience?command=experience_detail">
					<c:forEach var="exList" items="${exList}">
						<div class="box">
							<a href="Experience?command=experience_detail&prodCode=${exList.prodCode}&imgPath=${exList.imgPath}" class="image fit"><img src="${exList.imgPath}"
								width=300px height=250px /></a>
							<div class="inner">
								<h3>${exList.title}&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;${exList.villageName}</h3>
								<p>어린이: <fmt:formatNumber value="${exList.childPrice}" type="number" pattern="#,##0"/> 원</p>
								<p>성인: <fmt:formatNumber value="${exList.adultPrice}" type="number" pattern="#,##0"/> 원</p>
								<p>${exList.sidoName}</p>
								<input type="hidden" name="imgPath" value="${exList.imgPath}"> <!-- onchange="this.form.submit() -->
								<!-- <a href="Experience?command=experience_detail&prodCode=${exList.prodCode}&imgPath=${exList.imgPath}" class="button fit">상세보기</a>-->
							</div>
						</div>
					</c:forEach>
					</form>
					</div>

				</div>
			</div>
			</form>
			<div class="page">
			<form  action="Experience?command=experience_list" method="post" name="paging">
			<input type="hidden" name="searchSidoCode" value="6290000">
				<ul>
					<!-- <li><a href="#"><</a></li> -->
					<li><input value="<"  type="button"></li>
				<c:forEach var="pageCount" items="${pageCount}">
					<%-- <li><input value="${pageCount}" name="pageNo" type="text"  onclick="document.paging.submit()" readonly ></li> --%>
					<li><a href="Experience?command=experience_list&searchSidoCode=${searchSidoCode}&pageNo=${pageCount}">${pageCount}</a></li>
				</c:forEach>
					<li><input value=">"  type="button"></li>
				</ul>
			</form>
			</div>
		</div>

	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>