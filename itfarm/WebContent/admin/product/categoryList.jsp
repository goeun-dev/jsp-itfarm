<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품관리</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script>
function allCheckFunc( obj ) {
		$("[name=checkOne]").prop("checked", $(obj).prop("checked") );
}

/* 체크박스 체크시 전체선택 체크 여부 */
function oneCheckFunc( obj )
{
	var allObj = $("[name=checkAll]");
	var objName = $(obj).attr("name");

	if( $(obj).prop("checked") )
	{
		checkBoxLength = $("[name="+ objName +"]").length;
		checkedLength = $("[name="+ objName +"]:checked").length;

		if( checkBoxLength == checkedLength ) {
			allObj.prop("checked", true);
		} else {
			allObj.prop("checked", false);
		}
	}
	else
	{
		allObj.prop("checked", false);
	}
}

$(function(){
	$("[name=checkAll]").click(function(){
		allCheckFunc( this );
	});
	$("[name=checkOne]").each(function(){
		$(this).click(function(){
			oneCheckFunc( $(this) );
		});
	});
});
function checkDel() {
	  var chkFirList = document.getElementsByName('checkOne');
	  var arrFir = new Array();
	  var cnt = 0;
	  for ( var idx = chkFirList.length - 1; 0 <= idx; idx--) {
	   if (chkFirList[idx].checked) {
	    arrFir[cnt] = chkFirList[idx].value;
	    cnt++;
	   }
	  }
	  
	  if (arrFir.length != 0) {
	   document.form1.submit();
	  } else {
	   alert('삭제할 상품을 선택하세요.');
	   return;
	  }
	}
</script>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>
	<div class="left-loc">
	<a href="">홈</a> 
	<span> > </span> 
	<a href="">상품목록</a>
	</div>
	<div id="wrap" align="center">
		<h5>상품 목록</h5>
		<div class="search_div">
		<form action="Admin?command=product_search" class="search_form" method="post">
			<label>제품명</label>
			<input type="text" name="searchName" value="${searchName}">
			<br>
			<label>카테고리</label>
			<select name="searchCategory">
				<c:choose>
						<%-- <c:when test="${searchCategory == null}">
					        <c:set var="sctgry" value="전체"/>
					    </c:when> --%>
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
				<option value="">전체</option>
				<option value="1" <c:out value="${sensor}"></c:out>>센서</option>
				<option value="2" <c:out value="${control}"></c:out>>원격제어</option>
				<option value="3" <c:out value="${notice}"></c:out>>알림</option>
			</select>
			<br>
			<button class="btn btn-secondary btn-sm" type="submit">검색</button>
		</form>
		</div>
		
		<table class="list table table-bordered table-sm">
			<tr>
				<th class="chk">
				<input type="checkbox"  name="checkAll" >
				</th>
				<th>번호</th>
				<th>이미지</th>
				<th>이름</th>
				<th>카테고리</th>
				<th>가격</th>
				<th>수량</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<form name="form1" method="post" action="Admin?command=product_chkdelete" id="checkList">
			<c:forEach var="product" items="${productList}">
				<tr class="record">
					<td class="chk"><input type="checkbox" name="checkOne" value="${product.productNum}"></td>
					<td>${product.productNum}</td>
					<td><img style="width: 30px; height: 30px;" src="images/product/${product.productImg}"></td>
					<td><a href="ProductUpdate?productNum=${product.productNum}">${product.name}</a></td>
					<td>
					<c:choose>
					    <c:when test="${product.category == 1}">
					        <c:set var="ctgry" value="센서"/>
					    </c:when>
					    <c:when test="${product.category == 2}">
					        <c:set var="ctgry" value="원격제어"/>
					    </c:when>
					    <c:when test="${product.category == 3}">
					        <c:set var="ctgry" value="알림"/>
					    </c:when>
					</c:choose><c:out value="${ctgry}"></c:out> </td>
					<td>${product.price} 원</td>
					<td>${product.count} 개</td>
					<td><a href="ProductUpdate?productNum=${product.productNum}">상품 수정</a>
					</td>
					<td><a href="Admin?command=product_deleteform&productNum=${product.productNum}">상품 삭제</a>
					</td>
				</tr>
			</c:forEach>
			</form>
		</table>
			<button class="btn btn-outline-secondary btn-sm" type="button" onclick="location.href='ProductWrite'">
				상품 등록
			</button>
			<button class="btn btn-outline-secondary btn-sm" type="button" onclick="checkDel();">
				선택 상품 삭제
			</button>
	</div>		
	</article>
</section>
	
</body>
</html>