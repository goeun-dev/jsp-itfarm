<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원관리</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<style type="text/css">
.tlabel {  padding-right: 5px; font-weight: 600;}
</style>
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
	   alert('삭제할 회원을 선택하세요.');
	   return;
	  }
	}
function search() {
	if (document.search_form.searchCategory.value == 0){
		alert("구분을 선택해주세요.");
		return false;
	} else {
		document.search_form.action='Admin?command=member_list';
		document.myForm.submit();
	}
}
</script>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>	
	<div class="left-loc">
	<a href="Admin?command=index">홈</a> 
	<span> > </span> 
	<a href="Admin?command=member_list&status=1">회원목록</a>
	</div>
	<div id="wrap" align="center">
		<h5>회원 목록</h5>
		
		<div class="search_div">
		<form name="search_form" class="search_form" method="post">
			<label class="tlabel">구분</label>
			<select name="searchCategory">
				<c:choose>
					    <c:when test="${searchCategory == 1}">
					        <c:set var="name" value="selected"/>
					    </c:when>
					    <c:when test="${searchCategory == 2}">
					        <c:set var="userid" value="selected"/>
					    </c:when>
				</c:choose>
				<option value="0">선택</option>
				<option value="1" <c:out value="${name}"></c:out>>성명</option>
				<option value="2" <c:out value="${userid}"></c:out>>아이디</option>
			</select>
			<input type="text" name="searchName" value="${searchName}">			
			<input type="hidden" name="status" value="1">			
			<button class="btn btn-secondary btn-sm" type="submit" onclick="search()">검색</button>
		</form>
		</div>
				
		<table class="list table table-bordered table-sm">
			<tr>
				<th class="chk">
				<input type="checkbox"  name="checkAll" >
				</th>
				<th>이름</th>
				<th>아이디</th>
				<!-- <th>비밀번호</th> -->
				<th>이메일</th>
				<th>전화번호</th>
				<th>우편번호</th>
				<th>도로명 주소</th>
				<th>상세주소</th>
				<th>가입일자</th>
			</tr>
			<form name="form1" method="post" action="Admin?command=member_delete" id="checkList">
			<c:forEach var="member" items="${memberList}">
			${emp}
				<tr class="record">
					<td class="chk"><input type="checkbox" name="checkOne" value="${member.userid}"></td>
					<td>${member.name}</td>
					<td>${member.userid}</td>
					<%-- <td>${member.pwd}</td> --%>
					<td>${member.email1}</td>
					<td>${member.phone1}</td>
					<td>${member.zipNo}</td>
					<td>${member.roadAddr}</td>
					<td>${member.addrDetail}</td>
					<td>${member.regDate}</td>
				</tr>
			</c:forEach>
			</form>
		</table>	
			<button class="btn btn-outline-secondary btn-sm" type="button" onclick="checkDel();">
				선택 회원 탈퇴
			</button>
	</div>	
	</article>
</section>
</body>
</html>