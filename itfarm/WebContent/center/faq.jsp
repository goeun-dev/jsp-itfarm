<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../assets/css/main.css" />
<link rel="stylesheet" href="../assets/css/join.css" />
<style>
.accordion {
    background-color: #eee;
    color: #444;
    cursor: pointer;
    padding: 18px;
    width: 100%;
    border: none;
    text-align: left;
    outline: none;
    font-size: 15px;
    transition: 0.4s;
}

.active, .accordion:hover {
    background-color: #ccc;
}

.accordion:after {
    content: '\002B';
    color: #777;
    font-weight: bold;
    float: right;
    margin-left: 5px;
}

.active:after {
    content: "\2212";
}

.panel {
    padding: 0 18px;
    background-color: white;
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.2s ease-out;
}
section{text-align: center; width: 100%;}
section button {border-radius: 0px;}
.cnt-div{width: 80%; margin: 0 auto;}
</style>
</head>
<body>
	<jsp:include page="../sub/subHeader.jsp" flush="false" />
	<section>
	<div class="cnt-div">
<h2>FAQ</h2>
<p>자주 묻는 질문에 대한 답변을 찾을 수 있습니다.</p>
<hr>
<button class="accordion"><b>Q1</b>&nbsp;배송 출발 후 보통 몇일 뒤에 상품을 받아볼 수 있나요?</button>
<div class="panel">
  <p>상품 출고 후 배송은 택배 사에서 관리하며, 택배 사의 사정에 따라 보통 1~2일 정도 소요됩니다.</p>
</div>

<button class="accordion"><b>Q2</b>&nbsp;예약 인원을 잘못 체크했는데 취소하고 다시 예약할 수 있나요?</button>
<div class="panel">
  <p>문의하기 게시판에 취소할 예약내역의 예약번호를 기재해주시면 취소해드릴 수 있습니다. <br>단, 카드결제 환불은 카드 사의 사정에 따라 최대 일주일이 소요될 수 있습니다.</p>
</div>

<button class="accordion"><b>Q3</b>&nbsp;상품을 환불하고 싶은데 어떻게 하나요?</button>
<div class="panel">
  <p>문의하기 게시판에 주문번호와 환불하실 상품명을 함께 기재해주시면 환불접수가 가능합니다.<br> 상품 하자의 경우 택배비는 무료이며, 단순 변심이나 파손에 의한 환불은 불가합니다.<br>단, 카드결제 환불은 카드 사의 사정에 따라 최대 일주일이 소요될 수 있습니다.</p>
</div>

<button class="accordion"><b>Q4</b>&nbsp;회원가입 할 때 개인정보를 잘못 기재했는데 따로 수정할 수 있나요?</button>
<div class="panel">
  <p>회원정보 수정은 마이페이지 > 나의 정보 > 회원정보변경 에서 비밀번호 입력 후 수정이 가능합니다.</p>
</div>

<button class="accordion"><b>Q5</b>&nbsp;작성했던 글을 삭제하고 싶은데 비밀번호를 까먹었어요. 삭제할 수 있는 방법은 더 없나요?</button>
<div class="panel">
  <p>문의하기 게시판에 고객님이 작성한 글 번호를 기재해주시면 확인 후 삭제해드릴 수 있습니다.</p>
</div>


<button class="accordion"><b>Q6</b>&nbsp;저희 지역 체험농장이 많이 부족한 거 같아요. 체험농장을 더 추가해주시면 안되나요?</button>
<div class="panel">
  <p>체험농장은 저희가 확인 후 공공기관과 지자체의 승인을 받고 추가할 수 있습니다.<br> 만약 추가를 원하시는 농장이 있다면 1:1 문의를 통해 요청해주세요.</p>
</div>
</div>
</section>
<script>
var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
  acc[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var panel = this.nextElementSibling;
    if (panel.style.maxHeight){
      panel.style.maxHeight = null;
    } else {
      panel.style.maxHeight = panel.scrollHeight + "px";
    } 
  });
}
</script>
	<jsp:include page="../footer.jsp" flush="false" />
</body>
</html>
