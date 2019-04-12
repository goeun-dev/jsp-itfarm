<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITFARM - 예약하기</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body.css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
/* 결제방법 알아내는 메소드 */
function pay() {
	var payments = document.getElementsByName('payment');
	var payment_value; // 여기에 선택된 radio 버튼의 값이 담기게 된다.
	for(var i=0; i<payments.length; i++) {
	    if(payments[i].checked) {
	        payment_value = payments[i].value;
	    }
	}
	/* 결제 방법에 따라 폼 전송 경로 다르게 함 */
	// 카드 결제
	if (payment_value == 2) {
		var IMP = window.IMP; // 생략가능
		var phone1 = "${loginUser.phone1}";
		var phone2 = "${loginUser.phone2}";
		var phone3 = "${loginUser.phone3}";
		var email1 = "${loginUser.email1}";
		var email2 = "${loginUser.email2}";
		var name = "${loginUser.name}";
		var total = $("input[type=hidden][name=price]").val();
		var expName = "${title}";
		
		IMP.init(''); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명: '+expName,
		    amount : total,
		    buyer_email : email1+'@'+email2,
		    buyer_name : name,
		    buyer_tel : phone1+'-'+phone2+'-'+phone3,
			buyer_addr : '서울특별시 강남구 삼성동',
			buyer_postcode : '123-456',
			m_redirect_url : 'product/orderSuccess.jsp',
		}, function(rsp) {
			if (rsp.success) {
				var msg = '결제가 완료되었습니다.';
				msg += '고유ID : ' + rsp.imp_uid;
				msg += '상점 거래ID : ' + rsp.merchant_uid;
				msg += '결제 금액 : ' + rsp.paid_amount;
				document.form1.action='Experience?command=reservation_ok';
				document.form1.submit();
			} else {
				var msg = '결제가 중단되었습니다. ';
				msg += rsp.error_msg;
			}
			alert(msg);
		});
	}	
	
	// 휴대폰 결제
	else if (payment_value == 3) {
		var IMP = window.IMP; // 생략가능
		var phone1 = "${loginUser.phone1}";
		var phone2 = "${loginUser.phone2}";
		var phone3 = "${loginUser.phone3}";
		var email1 = "${loginUser.email1}";
		var email2 = "${loginUser.email2}";
		var name = "${loginUser.name}";
		var total = $("input[type=hidden][name=price]").val();
		var expName = "${title}";
		
		IMP.init('imp67298177'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		IMP.request_pay({
		    pg : 'danal', 
		    pay_method : 'phone', 
		    merchant_uid : 'merchant_' + new Date().getTime(), //상점에서 관리하시는 고유 주문번호를 전달
		    name : '주문명: '+expName,
		    amount : total,
		    buyer_email : email1+'@'+email2,
		    buyer_name : name,
		    buyer_tel : phone1+'-'+phone2+'-'+phone3,
		    buyer_addr : '서울특별시 강남구 삼성동',
		    buyer_postcode : '123-456'
		}, function(rsp) {
		    if ( rsp.success ) {
		    	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
		    	jQuery.ajax({
		    		url: "experience/reservationOk.jsp",
		    		type: 'POST',
		    		dataType: 'json',
		    		data: {
			    		imp_uid : rsp.imp_uid
			    		//기타 필요한 데이터가 있으면 추가 전달
		    		}
		    	}).done(function(data) {
		    		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
		    		if ( everythings_fine ) {
		    			var msg = '결제가 완료되었습니다.';
		    			msg += '\n고유ID : ' + rsp.imp_uid;
		    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		    			msg += '\결제 금액 : ' + rsp.paid_amount;
		    			msg += '카드 승인번호 : ' + rsp.apply_num;
		    			
		    			alert(msg);
		    		} else {
		    			//[3] 아직 제대로 결제가 되지 않았습니다.
		    			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
		    		}
		    	});
		    } else {
		        var msg = '결제가 중단되었습니다. ';
		        msg += rsp.error_msg;
		        alert(msg);
		    }
		});
	} else {
		document.form1.action='Experience?command=reservation_ok';
		document.form1.submit();
	}
}
</script>
<style>
.numip input[type=number] {
	height: 40px;
	font-size: 25px;
	width: 47px;
}

input.hinput[type=text] {
	background-color: lightgrey;
	display: inline-block;
	height: 50px;
	font-size: 40px;
	width: 200px;
	color: red;
	padding: 0;
	margin: 0;
	border: 0px;
}

input.hinput[type=text]:focus {
	background-color: lightgrey;
	display: inline-block;
	outline: none;
	padding: 0;
	margin: 0;
}
.ui-datepicker{ font-size: 12px; width: 17%; }
.ui-datepicker select.ui-datepicker-month{ width:30%; font-size: 11px; }
.ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 11px; }
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>
	<h2>예약하기</h2>
	<hr>
	<h3>예약하는 상품</h3>
	<hr>
	<form name="form1" method="post">
	<!-- <form action="ReservationOk" method="post" name="form1" accept-charset="utf-8"> -->
		<div class="form notf">
			<table class=" tb table content1">
				<tr class="main1">
					<td class="td1">상품정보</td>
					<td class="td2">예약일자</td>
					<td class="td3">인원</td>
					<td class="td4">상품금액</td>
				</tr>
				<tr class="sub1">
					<td class="product"><br>
						<div class="box1">
							<img class="box1" src="${img}">
							<input type="hidden" value="${img}" name="imgPath">
							
							<input type="hidden" value="${title}" name="expName">
						</div>
						<div class="box2">
							<span class="title">${title}</span><span class="prod"><br>
								(상품번호:${prodCode })</span><br> <span class="prod">${addr}</span> <br>
						</div></td>
					<td class="date"><br>
					 <p>${eDate}</p>
					<input type="hidden"name="eDate" value="${eDate}">
					
					</td>
					<td align="right" class="numip"><br> 
					성&nbsp;&nbsp;&nbsp;인: &nbsp; ${adultNum}
					<input type="hidden" name="adultNum" value="${adultNum}"> 명 
					<br>
					어린이:&nbsp;&nbsp;${childNum}
					<input type="hidden" name="childNum" value="${childNum}"> 명   <br> <br>
					</td>
					<td class="price5" align="right"><br> 성인: <fmt:formatNumber value="${adultPrice}" type="number" pattern="#,##0"/> 원
						<br> 어린이: <fmt:formatNumber value="${childPrice}" type="number" pattern="#,##0"/> 원</td>
				</tr>
				<tr class="final">
					<td></td>
					<td>최종 결제 금액</td>
					<td align="right">
					<c:set var="child" value="${adultPrice * adultNum}"></c:set>
					<c:set var="adult" value="${childPrice * childNum}"></c:set>
					<c:set var="price" value="${child +adult}"></c:set>
					<input type="hidden" value="${price}" name="price">
					<fmt:formatNumber value="${child +adult}" type="number" pattern="#,##0"/></td>
					<td>&nbsp;원</td>
				</tr>
			</table>
		</div>
		<h3>예약자 정보</h3>
		<hr>
		<div class="form">
			<table class="table userinfo">
				<tr>
					<td class="num">예약자명</td>
					<td><div>${mVo.name}</div>
					</td>
				</tr>
				<tr>
					<td class="num">연락처</td>
					<td><div>${mVo.phone1} - ${mVo.phone2} - ${mVo.phone3}</div>
					<%-- <input type="text" name="phone1" maxlength="3"
						value="${mVo.phone1}" required> - <input type="text"
						name="phone2" maxlength="4" value="${mVo.phone2}" required>
						- <input type="text" name="phone3" maxlength="4"
						value="${mVo.phone3}" required> --%></td>
				</tr>
				<tr>
					<td class="num">이메일</td>
					<td><div>${mVo.email1} @ ${mVo.email2}</div>
					<%-- <input type="text" placeholder="이메일" name="email1"
						value="${mVo.email1}" required> @ <input type="text"
						placeholder="이메일" name="email2" value="${mVo.email2}" required> --%>
					</td>
				</tr>
			</table>
		</div>
		<h3>결제 정보 입력</h3>
		<hr>
		<div class="form">
			<table class="table css_tabs">
				<tr>
					<td class="num">결제수단</td>
					<td class="num2">
						<input type="hidden" name="member" value="${mVo.userid}"> 
						<input type="hidden" name="prodcode" value="${prodCode}"> 
						<input type="hidden" value="${adultPrice}"> 
						<input type="hidden" value="${childPrice}">
						<div id="css_tabs">
							<input id="tab1" type="radio" name="payment" value="1" checked="checked" /> 
								<label for="tab1">무통장 입금</label> 
							<input id="tab2" type="radio" name="payment" value="2" /> 
								<label for="tab2">카드 결제</label> 
							<input id="tab3" type="radio"name="payment" value="3" /> 
								<label for="tab3">휴대폰 결제</label>

							<div class="tab1_content tdiv">
								<h4>무통장 입금 안내</h4>
								<p>
									* 가상계좌 입금기한은 예약일로 부터 3일 입니다. 기간내 미입금시 자동 취소 됩니다.<br> *
									무통장입금 시 일부 은행(농협 및 국민은행)의 경우 ATM기기 입금이 불가할 수 있습니다. 이 경우 은행 창구
									또는 인터넷 뱅킹을 이용해 주시기 바랍니다.
								</p>
								입금자명: <input type="text"> 
								&nbsp;&nbsp; 입금은행: 
								<select	id="bank" name="bank">
									<option value="bank">국민은행: 000-00000-00000 (주)아이티팜</option>
									<option value="bank">신한은행: 000-00000-00000 (주)아이티팜</option>
									<option value="bank">농협은행: 000-00000-00000 (주)아이티팜</option>
								</select>
							</div>
							<div class="tab2_content tdiv">
								<h4>카드 결제 안내</h4>
								<p>
									<b>* [결제하기]</b> 버튼 클릭시, 신용카드 결제 화면으로 연결되어 결제정보를 입력하실 수 있습니다.
									<!-- 최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다. -->
									<br> ! 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
								</p>
							</div>
							<div class="tab3_content tdiv">
								<h4>휴대폰 결제 안내</h4>
								<p><b>* [결제하기]</b> 버튼 클릭시, 휴대폰 결제 화면으로 연결되어 결제정보를 입력하실 수 있습니다.</p>
								<p>! 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>
							</div>
						</div></td>

				</tr>
			</table>
			<input type="hidden" name="userName" value="${mVo.name}">
			<input type="hidden" name="phone1" value="${mVo.phone1}">
			<input type="hidden" name="phone2" value="${mVo.phone2}">
			<input type="hidden" name="phone3" value="${mVo.phone3}">
			<input type="hidden" name="email1" value="${mVo.email1}">
			<input type="hidden" name="email2" value="${mVo.email2}">
			
		</div>
		<div class="btn-cnt">
			<a href="#" onclick="history.back()"><button class="button alt" onclick="history.back()">이전으로</button></a>
			<a href="#" onclick="pay()"><button
					class="button special" type="button"  onclick="pay()">결제하기</button></a>
		</div>
	</form>
	<jsp:include page="../footer.jsp" flush="false" />
	
</body>
</html>