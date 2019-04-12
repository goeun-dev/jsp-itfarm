<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML>
<html>
<head>
<title>IT FARM - 회원가입</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="assets/css/join.css">
<script src="<c:url value="script/member.js" />" ></script>

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


<style>
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />

	<section>
		<form action="Member?command=member_join" method="post" id="form" name="frm">
			<div class="container">
				<h1>회원가입</h1>
				<p>아래 빈칸을 채워주세요. * 표시는 필수 입력 값 입니다.</p>
				<hr>

				<label for="name"><b>이름*</b></label>
				<div class="input-align">
					<input type="text" placeholder="이름" name="name" required> 
				</div>

				<label for="userid"><b>아이디*</b></label> 
				<span class="desc">&nbsp;&nbsp;영문소문자, 숫자 사용 가능 / 4~16자</span>
				<div class="input-align">
					<input type="text" placeholder="아이디" name="userid" size="20" id="userid" maxlength="16" onblur="joinidCheck()" required> 
					<input type="hidden" name="reid" size="20"> 
					<input type="button" value="중복 체크" onclick="idCheck(400,200,'중복확인','scroll')" style="width: 20%"> 
					<input type="text" name="idchk" class="idchk" value="" readonly="readonly"> 
				</div>

				<label for="pwd"><b>패스워드*</b></label> 
				<span class="desc">&nbsp;&nbsp;영문소문자, 숫자, 특수문자 중 두가지 이상 조합 / 4~16자</span>
				<div class="input-align">
					<input type="password" placeholder="패스워드" id="pwd" name="pwd" maxlength="16" onblur="passCheck()" onkeyup="passRgex(event)" required> 
					<span id="keyinfo1"></span>
				</div>

				<label for="pwd_check"><b>패스워드 재입력*</b></label>
				<div class="input-align">
					<input type="password" placeholder="패스워드 재입력" id="pwd_check" name="pwd_check" maxlength="16" onkeyup="passCheck2(event)" required> 
					<span id="keyinfo3"></span>
				</div>

				<label for="phone"><b>휴대전화*</b></label>
				<div class="input-align">
					<input type="text" placeholder="휴대전화" name="phone1" maxlength="3" required onkeydown="showKeyCode(event)"> - 
					<input type="text" name="phone2" maxlength="4" required onkeydown="showKeyCode(event)"> -
					<input type="text" name="phone3" maxlength="4"  required onkeydown="showKeyCode(event)"> 
				</div>

				<label for="email"><b>이메일*</b></label>
				<div class="input-align email">
					<input type="text" placeholder="이메일" name="email1" required>@ 
					<input type="text" placeholder="이메일" name="email2" required>
				</div>
				
				<label for="address"><b>주소*</b></label>
				<div class="input-align">
					<div id="list"></div>
					<div id="callBackDiv">
						우편번호<br> 
						<input type="text" id="zipNo" name="zipNo" readonly onClick="javascript:alert('주소 검색 버튼을 이용하세요.')" required /> 
						<input type="button" onClick="goPopup();" value="주소 검색" /> <br>
						도로명주소
						<input type="text" style="width: 100%" id="roadAddrPart1" name="roadAddrPart1" readonly
							onClick="javascript:alert('주소 검색 버튼을 이용하세요.')" required /> <br>
						상세주소
						<input type="text" style="width: 100%" id="addrDetail" name="addrDetail" required />
					</div>
				</div>
				<br>
				<br>
				<div class="clearfix">
					<button type="button" class="cancelbtn" onclick="location.href='index.jsp'">취소</button>
					<button type="submit" class="signupbtn" onclick="joinCheck()">회원가입</button>
				</div>
			</div>
		</form>
	</section>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>
