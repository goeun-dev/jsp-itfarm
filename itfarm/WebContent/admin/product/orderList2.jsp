<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String[] stAy = request.getParameterValues("status1");
String[] pyAy = request.getParameterValues("pay");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문관리</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<style type="text/css">
.date {
	border: 1px solid #a5a5a5;
}
.tlabel {width: 5%; text-align: right; padding-right: 5px; font-weight: 600;}
</style>
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
	   alert('취소할 주문을 선택하세요.');
	   return;
	  }
}
function selectDate() {
	var startDate = document.getElementById("startDate").value;
	var endDate = document.getElementById("endDate");
	endDate.setAttribute("min", startDate);
}
function selectEndDate(){
	var startDate = document.getElementById("startDate").value;
	var endDate = document.getElementById("endDate");
	if (startDate == null || startDate == "") {
		alert("시작날짜를 선택하세요.");
	}
}
function popup(url, w, h, name, option) {
    var pozX, pozY;
    var sw = screen.availWidth;
    var sh = screen.availHeight;
    var scroll = 0;
    if (option == 'scroll') {
        scroll = 1;
    }
    pozX = (sw - w) / 2;
    pozY = (sh - h) / 2;
    window.open(url, name, "location=0,status=0,scrollbars=" + scroll + ",resizable=1,width=" + w + ",height=" + h + 
    ",left=" + pozX + ",top=" + pozY);
}

function search() {
	
}
$(document).ready(function(){
	/* chk = document.getElementsByName("status1"); */
	<%
	if (stAy != null) {
		for (String val : stAy) {
			out.println("$(\"input:checkbox[id='"+val+"']\").attr(\"checked\", true);");
			System.out.println("$(\"input:checkbox[id='"+val+"']\").prop(\"checked\", true);");
		}
	} 
	%>
	<%
	if (pyAy != null) {
		for (String p : pyAy) {
			out.println("$(\"input:checkbox[id='a"+p+"']\").attr(\"checked\", true);");
			System.out.println("$(\"input:checkbox[id='a"+p+"']\").prop(\"checked\", true);");
		}
	} 
	%>
});
</script>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>		
	<div class="left-loc">
	<a href="">홈</a> 
	<span> > </span> 
	<a href="">주문목록</a>
	</div>
	<div id="wrap" align="center">
		<h5>주문 목록</h5>
		<div class="search_div">
		<form action="Admin?command=order_list" class="search_form" method="post">
			<label class="tlabel">주문기간</label>
			<input type="date" class="date" id="startDate" name="startDate" 
			value="${startDate}" onchange="selectDate()"> -
			<input type="date" class="date" id="endDate" name="endDate" onclick="selectEndDate()"
			value="${endDate}" >
			<br>
			<label class="tlabel">아이디</label>
			<input type="text" name="searchName" value="${searchName}">
			<br>
			<label class="tlabel">결제방법</label>
			<label for="a1">무통장입금</label>
			<input type="checkbox" id="a1" name="pay" value="1">
			<label for="a2">카드결제</label>
			<input type="checkbox" id="a2" name="pay" value="2">
			<label for="a3">휴대폰결제</label>
			<input type="checkbox" id="a3" name="pay" value="3">
			<br>
			<label class="tlabel">주문상태</label>
			<label for="0">주문완료</label>
			<input type="checkbox" id="0" name="status1" value="0">
			<label for="1">결제완료</label>
			<input type="checkbox" id="1" name="status1" value="1">
			<label for="2">배송중</label> 
			<input type="checkbox" id="2" name="status1" value="2">
			<label for="3">배송완료</label>
			<input type="checkbox" id="3" name="status1" value="3">
			<label for="4">주문취소</label>
			<input type="checkbox" id="4" name="status1" value="4">
			<label for="5">반품신청</label>
			<input type="checkbox" id="5" name="status1" value="5">
			<label for="6">반품완료</label>
			<input type="checkbox" id="6" name="status1" value="6">
			<label for="7">반품취소</label>
			<input type="checkbox" id="7" name="status1" value="7">
			<br>
			<button class="btn btn-secondary btn-sm" type="submit" onclick="search();">검색</button>
		</form>
		</div>
		
		<div class="btn-group">
		<button class="btn btn-outline-secondary btn-sm" type="button" onclick="checkDel();">
				일괄 주문 취소
		</button>
		</div>
		
		<table class="list table table-bordered table-sm">
			<tr>
				<th class="chk">
				<input type="checkbox"  name="checkAll" >
				</th>
				<th>주문번호</th>
				<th>상품정보</th>
				<th>구매자</th>
				<th>결제날짜</th>
				<th>결제방법</th>
				<th>결제금액</th>
				<th>주문상태</th>
				<th></th>
			</tr>
			<form name="form1" method="post" 
			action="Admin?command=order_chkdelete" id="checkList">
			<c:forEach var="sale" items="${sList}">
			${emp}
				<tr class="record">
					<td class="chk">
					<input type="checkbox" name="checkOne" value="${sale.saleid}"
					<c:if test="${sale.deliveryStatus == 4}">disabled</c:if>>
					</td>
					<td>${sale.saleid}</td>
					<td><a href="ProductUpdate?productNum=${sale.saleid}">${sale.name} 외 ${sale.cnt} 개 상품</a></td>
					<td>${sale.userid}</td>
					<td>${sale.pDate}</td>
					<td>
					<c:choose>
						<c:when test="${sale.payment == 1}">
						무통장 입금
						</c:when>
						<c:when test="${sale.payment == 2}">
						카드결제
						</c:when>
						<c:when test="${sale.payment == 3}">
						휴대폰 결제
						</c:when>
					</c:choose>
					</td>
					<td  align="right">
					<fmt:formatNumber value="${sale.unitPrice}" type="number" pattern="#,##0"/> 원
					</td>
					<td>
					${sale.delivery}
					</td>
					<td>
					<c:choose>
						<c:when test="${sale.deliveryStatus == 1}">
					        <a href="Admin?command=delivery_form&saleid=${sale.saleid}"
							onclick="popup(this.href,400,250,'운송장 번호 등록','scroll'); return false;">
							등록하기</a>
					    </c:when>
					    <c:when test="${sale.deliveryStatus == 0}">
					        <a href="Product?command=order_refund&id=${sale.saleid}&status=1">
							입금확인</a>
					    </c:when>
					    <c:when test="${sale.deliveryStatus == 2}">
					        ${sale.deliveryNo}
					    </c:when>
					    <c:when test="${sale.deliveryStatus == 3}">
					        ${sale.deliveryNo}
					    </c:when>
					    <c:when test="${sale.deliveryStatus == 4}">
					        -
					    </c:when>
					    <c:when test="${sale.deliveryStatus == 5}">
					         <a href="Admin?command=order_returnform&id=${sale.saleid}"
							onclick="popup(this.href,900,600,'반품 신청 내역','scroll'); return false;">
							승인/거절 하기</a>
					    </c:when>
					</c:choose>
					</td>
				</tr>
			</c:forEach>
			</form>
		</table>
		
			<!-- <a href="ProductWrite">상품 등록</a>
			<a href="#" onclick="checkDel();">선택 상품 삭제</a> -->
	</div>
	</article>
</section>
	
</body>
</html>