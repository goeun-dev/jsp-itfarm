	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<!DOCTYPE html>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>ITFARM - 농업체험상품 상세보기</title>
	<link rel="stylesheet" href="assets/css/main.css" />
	<link rel="stylesheet" href="assets/css/experiencedetail.css" />

	<!-- // jQuery UI CSS파일  -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
	<!-- // jQuery 기본 js파일 -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
	<!-- // jQuery UI 라이브러리 js파일 -->
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

	<style type="text/css">
	.ui-datepicker{ font-size: 12px; width: 17%; }
	.ui-datepicker select.ui-datepicker-month{ width:30%; font-size: 11px; }
	.ui-datepicker select.ui-datepicker-year{ width:40%; font-size: 11px; }
	</style>
	<script type="text/javascript">
	function mySubmit() {
		var eDateV = document.form1.eDate.value;
		var iCount = document.form1.intro_count.value;
		var mCount = document.form1.main_count.value;
		var rcnt = document.form1.recnt.value;
		var totalCnt = parseInt(iCount) + parseInt(mCount);
		if (eDateV == null || eDateV == ""){
			alert("날짜를 선택하세요");
			return false; // 새로고침 안되게
		}
		if (iCount == 0 && mCount == 0){
			alert("체험 인원을 선택하세요");
			return false;
		}
		if (totalCnt > rcnt) {
			alert ("잔여 수량보다 많이 담을 수 없습니다.");
			return false;
		}
		if (iCount != 0 || mCount != 0 && eDateV != ""){
		document.form1.action='Experience?command=reservation_form';
		document.form1.submit();
		}
		return true;
	}
		/* count */	
		var intro_count = 1;
		var countEl = document.form1.getElementById("intro_count");
		function plus() {
			intro_count++;
			countEl.value = intro_count;
			//plus(document.form1); 
		}
		function minus() {
			if (count > 1) {
				intro_count--;
				countEl.value = intro_count;
			}
		}

		function my_calc(item, item_count, item_sum) {

			if (item_count.value == "")
				var count = 0;
			else
				var count = item_count.value;

			item_sum.value = eval(item.value) * eval(count);

			my_total(document.form1);

		}

		function my_total(f) {

			var totalS = eval(f.intro_sum.value) + eval(f.main_sum.value);
			f.total.value = totalS;
			f.ctotal.value = totalS.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
	</script>
	</head>
	<body>
		<jsp:include page="../header.jsp" flush="false" />
		<div class="content">
		<div class="name">${title}</div>
			<div class="info_l">
				<img class="img1" src="${img}" alt="main">
			</div>
			<form name="form1" method="post" autocomplete="off">
			<!-- <form name="form1" action="ReservationForm" method="post"> -->
			<!--  accept-charset="utf-8" onsubmit="document.charset='utf-8';"> -->
			<div class="info_c">
			
				<%-- <div class="name">${title}</div> --%>
				<!-- 		<hr> -->
				<div class="row1">주소</div>
				<div class="place">${addr}</div>
				<div class="row1">담당자</div>
				<div class="place">${ceoName}</div>
				<div class="row1">마을명</div>
				<div class="place">${villageName}</div>
				<div class="row1">연락처</div>
				<div class="place">${telNo}</div>
				<div class="row1">보험</div>
				<div class="place">${limitStatus} Y</div>
				<div class="row1">참가인원</div>
				<div class="place">${stdCnt}  100 명</div>
				<div class="row1">가격</div>
				<%-- <div class="price">[단체] 성인: ${grpAduitPrice}원, 어린이: ${grpChildPrice}원</div>
				<div class="row1">&nbsp;</div> --%>
				<div class="price"><!-- [개별] --> 성인: <fmt:formatNumber value="${adultPrice}" type="number" pattern="#,##0"/> 원, 
				어린이: <fmt:formatNumber value="${childPrice}" type="number" pattern="#,##0"/> 원</div>
				
					<input type="hidden" value="${img}" name="img">
					<input type="hidden" value="${title}" name="tte">
					<input type="hidden" value="${prodCode}" name="prodCode">
					<input type="hidden" value="${stdCnt}" name="stdCnt">
					<input type="hidden" value="${loginUser.userid}" name="userid">
			</div>
			<div class="info_r">
			<p>체험일 선택</p>
			<div class="datech cnt">
			<c:if test="${selectDate !=null }">
				<c:set var="selectDate2" value="${selectDate}"></c:set>
			</c:if>
			<input type="text" id="select_all" class="" name="select_all" value="${selectDate2}"
			placeholder="날짜를 선택하세요." readonly>
			<label for="fromInput'">
			<%-- <a href="experience/calendar.jsp?prodCode=${prodCode}&stdCnt=${stdCnt}" 
			onclick="popup(this.href,580,470,'팝업1','scroll'); return false;"> --%>
			<a href="experience/calendar.jsp?prodCode=${prodCode}&stdCnt=100" 
			onclick="popup(this.href,580,470,'팝업1','scroll'); return false;">
			<img src="images/calendar.png"></a>
			</label><br>
			<input type="hidden" id="recnt" class="" name="recnt" readonly>
			<input type="hidden" id="fromInput" class="" name="eDate" readonly>
			
			</div>	
				<p>체험인원 선택</p>
				<div class="cnt">
				성&nbsp;&nbsp;&nbsp;인: <input type=hidden name="intro" value="${adultPrice}">
						<input type="number" name="intro_count"
							onclick="my_calc(this.form.intro, this.form.intro_count, this.form.intro_sum)"
							placeholder="0" id="intro_count" min="0" value="0"
							onkeyup="my_calc(this.form.intro, this.form.intro_count, this.form.intro_sum)"> 명 
						<input type="hidden" name="intro_sum" size=6 readonly value="0"> 
						<p></p>
				어린이: <input type=hidden name="main" value="${childPrice}">
						<input type=number name="main_count"
							onclick="my_calc(this.form.main, this.form.main_count, this.form.main_sum)"
							placeholder="0" min="0" value="0"
							onkeyup="my_calc(this.form.main, this.form.main_count, this.form.main_sum)"> 명 
						<input type="hidden" name="main_sum" size=6 readonly value="0"> 
				</div>
				
				<div class="total_p"> 
				<p>총 결제금액</p>
					<input type="text" class="hinput" name="ctotal" value="0" readonly>
					<input type="hidden" class="hinput" name="total" value="0" readonly>
				</div>
				<a href="#" onclick="mySubmit()">
					<button class="button special">예약하기</button>
				</a>
			</div>
			</form>
		</div>

		<div class="subprice">*성인/아동 구분이 없는 상품입니다.</div>

		<div class="subimg">
			<div class="img2" id="exDetail">${detail}</div>
			<style>
				
			TD{font-size: 18pt; color: #666666; text-decoration: none; font-family: "Source Sans Pro", "sans-serif";; line-height:0px;}	
			DIV {font-size: 0.9em; font-family: "Source Sans Pro", "sans-serif";; TEXT-DECORATION: none}
			A:link    {font-size: 1em; color: #666666; text-decoration: none; font-family: "Source Sans Pro", "sans-serif";}
			A:visited {font-size: 1em; color: #666666; text-decoration: none; font-family: "Source Sans Pro", "sans-serif";}
			A:active  {font-size: 1em; color: #666666; text-decoration: none; font-family: "Source Sans Pro", "sans-serif";}
			A:hover   {font-size: 1em; color: #047A89; text-decoration: none; font-family: "Source Sans Pro", "sans-serif";}

			</style>
			<script type="text/javascript">
			/* $(document).ready(function(){
				$("#exDetail img").error(function() {
					$("#exDetail img").error().replaceWith("<p>No Image!</p>")
				});
			}); */
			
			$("img").error(function () {
			  $(this).unbind("error").attr("src", "images/none.png");
			});
			</script>
		</div>
		<div class="button2">
			<a href="#" onclick="history.back();"><button class="button alt">목록으로</button></a>
		</div>


		</section>
		<jsp:include page="../footer.jsp" flush="false" />
	<link rel="stylesheet" href="assets/css/main.css" />
	<link rel="stylesheet" href="assets/css/experiencedetail.css" />
	</body>
	</html>