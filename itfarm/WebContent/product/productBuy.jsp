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
<title>ITFARM - 제품구매</title>
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/body.css" />
<script type="text/javascript" src="script/cart.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
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
		var total = $("input[type=hidden][name=total]").val();
		
		IMP.init(''); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명: 결제테스트',
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
				msg += '카드 승인번호 : ' + rsp.apply_num;
				// 결제 완료시 폼전송 
				document.form1.action = 'Product?command=product_buy';
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
		var total = $("input[type=hidden][name=total]").val();
		
		IMP.init(''); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		IMP.request_pay({
		    pg : 'danal', 
		    pay_method : 'phone', 
		    merchant_uid : 'merchant_' + new Date().getTime(), //상점에서 관리하시는 고유 주문번호를 전달
		    name : '주문명: 결제테스트',
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
		    		url: "product/orderSuccess.jsp",
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
		    	// 결제 완료시 폼전송 
				document.form1.action = 'Product?command=product_buy';
				document.form1.submit();
		    } else {
		    	var msg = '결제가 중단되었습니다. ';
		        msg += rsp.error_msg;
		        alert(msg);
		    }
		});
	} else {
		document.form1.action='Product?command=product_buy';
		document.form1.submit();
	}

}
</script>
<!-- ------------------------------------------주소 api------------------------------------------ -->
<script>
	function goPopup() {
		var pop = window.open("member/jusoPopup.jsp", "pop",
				"width=570,height=420, scrollbars=yes, resizable=yes");

		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
		//var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}

	function jusoCallBack(roadAddrPart1, addrDetail, zipNo) {
		// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
		document.form1.roadAddrPart1.value = roadAddrPart1;
		document.form1.addrDetail.value = addrDetail;
		document.form1.zipNo.value = zipNo;
	}
	
	function checkForm(){
        var chk1=document.form1.delinfo.checked;    
        if(chk1){
        	$("input[type=text][name=name]").val("${loginUser.name}");
        	$("input[type=text][name=phone1]").val("${loginUser.phone1}");
        	$("input[type=text][name=phone2]").val("${loginUser.phone2}");
        	$("input[type=text][name=phone3]").val("${loginUser.phone3}");
        	$("input[type=text][name=zipNo]").val("${loginUser.zipNo}");
        	$("input[type=text][name=roadAddrPart1]").val("${loginUser.roadAddr}");
        	$("input[type=text][name=addrDetail]").val("${loginUser.addrDetail}");
        } 
        if(!chk1){
        	$("input[type=text][name=name]").val("");
        	$("input[type=text][name=phone1]").val("");
        	$("input[type=text][name=phone2]").val("");
        	$("input[type=text][name=phone3]").val("");
        	$("input[type=text][name=zipNo]").val("");
        	$("input[type=text][name=roadAddrPart1]").val("");
        	$("input[type=text][name=addrDetail]").val("");
        } 
    }
</script>
<style type="text/css">
.hiddenchk {
	display: hidden;
	width: 0px;
}
</style>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>
	<h2>구매하기</h2>
	<hr>
	<h3>구매하는 상품</h3>
	<hr>
	<form name="form1" method="post" id="checkList">
		<div class="form notf">
			<table class=" tb table content1">
				<tr class="main1">
					<td class="td3 hiddenchk">
						<!-- <input type="checkbox"  name="checkAll" > -->
					</td>
					<td class="td1">상품정보</td>
					<td class="td2">판매가</td>
					<td class="td3">수량</td>
					<td class="td3">구매가</td>
				</tr>
				<c:forEach var="buy" items="${buyList}">
				<tr class="sub1">
					<td><input type="checkbox" name="checkOne" class="hiddenchk" value="${buy.pid},${buy.num},${buy.pprice},${buy.id}" checked></td>
					<td class="product"><br>
						<div class="box1">
							<img class="box1" src="images/product/${buy.pimg}">
						</div>
						<div class="box2">
							<span class="title">${buy.pname}</span><span class="prod"><br>
								(상품번호:${buy.pid})</span><br> <br>
						</div></td>
					<td class="date"><br>
					 <p><fmt:formatNumber value="${buy.pprice}" type="number" pattern="#,##0"/>원</p>
					 <input type="hidden" value="${buy.pprice}" name="unitPrice">
					</td>
					<td align="right" class="numip"><br> 
					${buy.num}
					<input type="hidden" value="${buy.num}" name="num"> 개
					<br>
					</td>
					<td align="right" class="numip"><br>
						<c:set var= "sum1" value="${buy.pprice * buy.num}"/>
						<c:set var= "sum2" value="${sum2 + sum1}"/>
						<fmt:formatNumber value="${sum1}" type="number" pattern="#,##0"/> 원
					</td>
				</tr>
				<input type="hidden" name="userid" value="${loginUser.userid}">
				</c:forEach>
			</table>
		</div>
		<table class="tb table content1">
			<tr class="main1">
				<td>총 상품금액</td>
				<td>총 배송비</td>
				<td>최종 결제 금액</td>
			</tr>
			<tr align="center">
				<td><fmt:formatNumber value="${sum2}" type="number" pattern="#,##0"/>원</td>
				<td>
				<c:choose>
				    <c:when test="${sum2>=70000}">
				        <c:set var="del" value="0"/>
				    </c:when>
				    <c:when test="${sum2<70000}">
				        <c:set var="del" value="2500"/>
				    </c:when>
				</c:choose>
				<fmt:formatNumber value="${del}" type="number" pattern="#,##0"/>원</td>
				<td><c:set var="total" value="${sum2 + del}"/> 
				<input type="hidden" value="${total}" name="total" id="total">
				<fmt:formatNumber value="${sum2 + del}" type="number" pattern="#,##0"/>원</td>
			</tr>
			</table>
		<h3>주문자 정보</h3>
		<hr>
		<div class="form">
			<table class="table userinfo product">
				<tr>
					<td class="num">주문자명</td>
					<td>${loginUser.name}</td>
					<td><input type="hidden" name="pname" value="${loginUser.name}"></td>
				</tr>

				<tr>
					<td class="num">연락처</td>
					<td>${loginUser.phone1} - ${loginUser.phone2} - ${loginUser.phone3}</td>
					<td><input type="hidden" name="pphone1" value="${loginUser.phone1}"></td>
					<td><input type="hidden" name="pphone2" value="${loginUser.phone2}"></td>
					<td><input type="hidden" name="pphone1" value="${loginUser.phone3}"></td>
				</tr>
				<tr>
					<td class="num">이메일</td>
					<td>${loginUser.email1} @ ${loginUser.email2}</td>
					<td><input type="hidden" name="pemail1" value="${loginUser.email1}"></td>
					<td><input type="hidden" name="pemail2" value="${loginUser.email2}"></td>
				</tr>
			</table>
		</div>
		<h3>배송지 정보</h3>
		<hr>
		<div class="form">
			<table class="table userinfo">
				<tr>
					<td class="num">받는분</td>
					<td><input type="text" id="name" name="name">  
					<input id="delinfo" name="delinfo" type="checkbox" onclick="checkForm()">
					<label for="delinfo">주문자 정보와 동일</label></td>
				</tr>

				<tr>
					<td class="num">연락처</td>
					<td>
					<input type="text" name="phone1" id="phone1" maxlength="3"
						 required> - 
					<input type="text" name="phone2" id="phone2" maxlength="4" required>
						- 
					<input type="text" name="phone3" id="phone3" maxlength="4"
						required></td>
				</tr>
				<tr>
					<td class="num">주소</td>
					<td>  
						<div class="input-align">
							<div id="callBackDiv">
								우편번호
								<input type="text" value="" id="zipNo" name="zipNo" readonly onClick="javascript:alert('주소 검색 버튼을 이용하세요.')" required /> 
								<input type="button" class="button alt" onClick="goPopup();" value="주소 검색" /> 
								<br>
								도로명주소
								<input type="text" style="width: 80%" id="roadAddrPart1" name="roadAddrPart1" value="" onClick="javascript:alert('주소 검색 버튼을 이용하세요.')" readonly required /> 
								<br>
								상세주소
								<input type="text" style="width: 80%" id="addrDetail" name="addrDetail" value="" required />
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="num">배송 메시지</td>
					<td><textarea rows="5" cols="100"></textarea>
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
									<br> * 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.
								</p>
							</div>
							<div class="tab3_content tdiv">
								<h4>휴대폰 결제 안내</h4>
								<p><b>* [결제하기]</b> 버튼 클릭시, 휴대폰 결제 화면으로 연결되어 결제정보를 입력하실 수 있습니다.</p>
								<p>* 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</p>
							</div>
						</div></td>
				</tr>
			</table>
		</div>
		<div class="btn-cnt">
			<a href="#" onclick="history.back();">
			<button class="button alt">이전으로</button>
			</a>
			<a href="#" onclick="pay()"><button type="button" class="button special">결제하기</button></a>
		</div>
	</form>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>