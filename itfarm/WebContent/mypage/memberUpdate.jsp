<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty loginUser}">
	<jsp:forward page='Login' />
</c:if>
<!DOCTYPE HTML>
<html>
<head>
<title>IT FARM - 회원 정보 수정</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<script type="text/javascript" src="member.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/join.css">
<script src="<c:url value="script/member.js" />"></script>
<script language="javascript">
</script>

<!-- ------------------------------------------주소 api------------------------------------------ -->
<script language="javascript">
	// opener관련 오류가 발생하는 경우 아래 주석을 해지하고, 사용자의 도메인정보를 입력합니다. ("팝업API 호출 소스"도 동일하게 적용시켜야 합니다.)
	//document.domain = "abc.go.kr";

	function goPopup() {
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
		var pop = window.open("member/jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}

	function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.frm.roadAddrPart1.value = roadAddrPart1;
		document.frm.addrDetail.value = addrDetail;
		document.frm.zipNo.value = zipNo;
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<section>
		<form action="Member?command=member_update" method="post" id="form" name="frm">
			<div class="container">
				<h1>회원 정보 수정</h1>
				<p>회원 정보를 수정하세요.</p>
				<hr>

				<label for="name"><b>이름</b></label>
				<div class="input-align">
					<input type="text" name="name" value="${mVo.name}" readonly="readonly">
				</div>

				<label for="userid"><b>아이디</b></label>
				<div class="input-align">
					<input type="text" name="userid" value="${mVo.userid}" readonly="readonly">
				</div>

				<!-- <label for="pwd"><b>패스워드</b></label>
				<span class="desc">&nbsp;&nbsp;영문소문자, 숫자, 특수문자 중 두가지 이상 조합 / 4~16자</span>
				<div class="input-align">
					<input type="password" placeholder="패스워드" id="pwd" name="pwd" onkeyup="passRgex(event)" required> 
					<span id="keyinfo1"></span>
				</div>

				<label for="pwd_check"><b>패스워드 재입력</b></label>
				<div class="input-align">
					<input type="password" placeholder="패스워드 재입력" id="pwd_check" name="pwd_check" onblur="passCheck2()" onkeyup="passCheck2(event)" required> 
					<span id="keyinfo3"></span>
				</div> -->

				<label for="phone"><b>휴대전화</b></label>
				<div class="input-align"> 
					<input type="text" name="phone1" maxlength="3" value="${mVo.phone1}" required> - 
					<input type="text" name="phone2" maxlength="4" value="${mVo.phone2}" required> - 
					<input type="text" name="phone3" maxlength="4" value="${mVo.phone3}" required> 
				</div>

				<label for="email"><b>이메일</b></label>
				<div class="input-align email">
					<input type="text" placeholder="이메일" name="email1" value="${mVo.email1}" required>@ 
					<input type="text" placeholder="이메일" name="email2" value="${mVo.email2}" required>
				</div>
				
				<label for="address"><b>주소</b></label>
				<div class="input-align">
					<div id="list"></div>
					<div id="callBackDiv">
						우편번호<br> 
						<input type="text" value="${mVo.zipNo}" id="zipNo" name="zipNo" readonly onClick="javascript:alert('주소 검색 버튼을 이용하세요.')" required /> 
						<input type="button" onClick="goPopup();" value="주소 검색" /> 
						<br>
						도로명주소
						<input type="text" style="width: 100%" id="roadAddrPart1" name="roadAddrPart1" value="${mVo.roadAddr}" onClick="javascript:alert('주소 검색 버튼을 이용하세요.')" readonly required /> 
						<br>
						상세주소
						<input type="text" style="width: 100%" id="addrDetail" name="addrDetail" value="${mVo.addrDetail}" required />
					</div>
				</div>		
				<br><br>
				<div class="clearfix">
					<button type="button" class="cancelbtn" onclick="location.href='Member?command=member_mypage'">취소</button>
					<button type="submit" class="signupbtn" onclick="joinCheck()">수정</button>
				</div>
			</div>
		</form>
	</section>

	<jsp:include page="../footer.jsp" flush="false" />

</body>
</html>




