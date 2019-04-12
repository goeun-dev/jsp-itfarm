<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>

<!DOCTYPE HTML>
<html>
<head>
<title>IT FARM - 탈퇴하기</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<script type="text/javascript" src="member.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/join.css">
<script type="text/javascript">

function deleteCheck() {
	
	if (document.frm.pwd.value.length == 0) {
		alert("비밀번호를 입력하세요.");
		frm.pwd.focus();
		location.href = " "; 
		return false;
		}
	
<%-- <% if(msg != null){%>
alert(	"<%= msg %>");
return false;
<%}%> --%>
	return true;
}

</script>
</head>

<body>
	<jsp:include page="../header.jsp" flush="false" />
	<section>
	<div id="status">
		<form action="Member?command=member_delete" method="post" name="frm" class="login-form">
				<div class="input-align">
				<h1>ITFARM 탈퇴</h1>
				<hr> 
					<p>${mVo.userid}님 탈퇴하시겠습니까? 본인확인을 위해 비밀번호를 한 번 더 입력해주세요.<br>
					<!-- 회원 탈퇴시 아래 내용을 확인해주세요.<br> -->

					<!-- 올리브영 이용약관 동의 철회 시 고객님께서 보유하셨던 쿠폰은 모두 삭제되며, 재가입 시 복원이 불가능합니다.<br>
					올리브영 이용약관 동의 철회 시에는 올리브영 서비스만 이용할 수 없게 되며, CJ ONE 웹사이트를 포함한 다른 CJ ONE 제휴 브랜드의 웹사이트 서비스는 이용하실 수 있습니다.<br>
					올리브영 이용약관 동의 철회 시에도 CJ ONE 멤버십 서비스 및 타 제휴 브랜드의 이용을 위해 회원님의 개인정보 및 거래정보는 CJ ONE 회원 탈퇴 시까지 보존됩니다.<br>
					올리브영 이용약관 동의를 철회한 후에라도 해당 약관에 다시 동의하시면 서비스를 이용할 수 있습니다.<br>
					진행 중인 전자상거래 이용내역(결제/배송/교환/반품 중인 상태)이 있거나 고객상담 및 이용하신 서비스가 완료되지 않은 경우 서비스 철회 하실 수 없습니다. -->
					</P>
				</div>

				<label for="pwd">비밀번호</label> 
				<input id="pwd" name="pwd" type="password" size="20" placeholder="비밀번호 입력" maxlength="16">
				<input type="text" name="userid" value="${mVo.userid}" readonly="readonly" style="background: white; color:white;">
				<p style="color: red">${msg}</p>
				<div class="clearfix">
					<button type="submit" class="signbtn"  onclick="deleteCheck()">탈퇴</button>
					<button type="button" class="cancelbtn" onclick="location.href='Member?command=member_mypage'">취소</button>
				</div>
		</form>
	</div>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />

</body>
</html>
