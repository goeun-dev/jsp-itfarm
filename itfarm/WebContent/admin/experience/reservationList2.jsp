<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String[] stAy = request.getParameterValues("status");
String[] pyAy = request.getParameterValues("payment");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>예약관리</title>
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
	   alert('취소할 예약을 선택하세요.');
	   return;
	  }
	}
function search() {
	
}
$(document).ready(function(){
	/* chk = document.getElementsByName("status1"); */
	<%
	if (stAy != null) {
		for (String val : stAy) {
			out.println("$(\"input:checkbox[id='s"+val+"']\").attr(\"checked\", true);");
			System.out.println("$(\"input:checkbox[id='"+val+"']\").prop(\"checked\", true);");
		}
	} 
	%>
	<%
	if (pyAy != null) {
		for (String p : pyAy) {
			out.println("$(\"input:checkbox[id='p"+p+"']\").attr(\"checked\", true);");
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
	<a href="">예약목록</a>
	</div>
		<div id="wrap" align="center">
		<h5>예약 목록</h5>
		<div class="search_div">
		<form action="Admin?command=reservation_search" class="search_form" method="post">
			<label class="tlabel">결제일자</label>
			<input type="date" class="date" id="startDate" name="startDate" 
			value="${startDate}" onchange="selectDate()"> -
			<input type="date" class="date" id="endDate" name="endDate" onclick="selectEndDate()"
			value="${endDate}">
			<br>
			<label class="tlabel">아이디</label>
			<input type="text" name="searchUserid" value="${searchUserid}">
			<br>
			<label class="tlabel">체험명</label>
			<input type="text" name="searchExpName" value="${searchExpName}">
			<br>
			<label class="tlabel">결제방법</label>
			<label for="p1">무통장입금</label>
			<input type="checkbox" id="p1" name="payment" value="1">
			<label for="p2">카드결제</label>
			<input type="checkbox" id="p2" name="payment" value="2">
			<label for="p3">휴대폰결제</label>
			<input type="checkbox" id="p3" name="payment" value="3">
			<br>
			<label class="tlabel">예약상태</label>
			<label for="s1">결제완료</label>
			<input type="checkbox" id="s1" name="status" value="1">
			<label for="s2">예약취소</label>
			<input type="checkbox" id="s2" name="status" value="2">
			<br>
			<button class="btn btn-secondary btn-sm" type="submit" onclick="search();">검색</button>
		</form>
		</div>
		
		<div class="btn-group">
		<button class="btn btn-outline-secondary btn-sm" type="button" onclick="checkDel();">
				일괄 예약 취소
		</button>
		</div>
		
		<table class="list">
			<tr>
				<th>
				<input type="checkbox"  name="checkAll" >
				</th>
				<th>번호</th>
				<th>체험명</th>
				<th>아이디</th>
				<th>체험일자</th>
				<th>결제일자</th>
				<th>인원(성인)</th>
				<th>인원(아이)</th>
				<th>결제금액</th>
				<th>결제방법</th>
				<th>상태</th>
			</tr>
			<form name="form1" method="post" action="Admin?command=reservation_chkdelete" id="checkList">
			<c:forEach var="reservation" items="${rList}">
			${emp}
				<tr class="record">
					<td class="chk">	
					<!-- 체험일자가 지났으면 취소버튼 없애기 -->
					<c:set var="now" value="<%=new java.util.Date()%>" />
					<c:set var="sysDate"><fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></c:set>
					<input type="checkbox" name="checkOne" value="${reservation.expid}" 
					<c:if test="${reservation.eDate <= sysDate || reservation.status == 2}">disabled</c:if>>
					</td>
					<td>${reservation.expid}</td>
					<td><a href="Admin?command=reservation_updateform&expid=${reservation.expid}">${reservation.expName}</a></td>
					<td>${reservation.userid}</td>
					<td>${reservation.eDate}</td>
					<td>${reservation.rDate}</td>
					<td  align="right">${reservation.adultNum} 명</td>
					<td  align="right">${reservation.childNum} 명</td>
					<td  align="right">
					<fmt:formatNumber value="${reservation.price}" type="number" pattern="#,##0"/>
					 원</td>
					<td>
					<c:choose>
						<c:when test="${reservation.payment == 1}">
						무통장 입금
						</c:when>
						<c:when test="${reservation.payment == 2}">
						카드결제
						</c:when>
						<c:when test="${reservation.payment == 3}">
						휴대폰 결제
						</c:when>
					</c:choose>
					</td>
					<td>
					<c:choose>
						<c:when test="${reservation.status == 1}">
						결제완료
						</c:when>
						<c:when test="${reservation.status == 2}">
						예약취소
						</c:when>
					</c:choose>
					</td>
				</tr>
			</c:forEach>
			</form>
		</table>
		
			<!-- <a href="ProductWrite">상품 등록</a> -->
			<!-- <a href="#" onclick="checkDel();">선택 예약 취소</a> -->
	</div>	
	</article>
</section>
	
</body>
</html>