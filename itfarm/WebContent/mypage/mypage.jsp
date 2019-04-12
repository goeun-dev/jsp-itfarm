<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty loginUser}">
	<jsp:forward page='../Member?command=member_loginform' />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<title>IT FARM - 마이페이지</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="script/member.js"></script>
<link rel="stylesheet" type="text/css" href="assets/css/admin_index.css">
<link rel="stylesheet" href="assets/css/main.css" />
<link rel="stylesheet" href="assets/css/mypage.css" />

<script type="text/javascript">
	function enterkey() {
		if (window.event.keyCode == 13) {
			if (document.frm.pwd.value == "") {
				alert("비밀번호를 입력하세요.");
				frm.pwd.focus();
				return false;
			}
		}
	}
</script>
</head>
<body>
	<jsp:include page="../header.jsp" flush="false" />
	<br>

	<section class="main-content">
		<nav class="nav">
			<ul>
				<li class="top-menu">마이페이지</li>
				<li>${loginUser.name}<%-- (${loginUser.userid}) --%>님 안녕하세요.</li>
				<hr>
				<li class="top-menu">나의 쇼핑</li>
				<li class="sub-menu">제품구매</li>
				<li><a href="Product?command=order_list&status=1">주문/배송 조회</a></li>
				<li><a href="Product?command=order_list&status=2">취소/반품/교환내역</a></li>
				<li><a href="Product?command=cart_list">장바구니</a></li>
				<li class="sub-menu">농업체험</li>
				<li><a href="Experience?command=reservation_list&status=1">예약내역</a></li>
				<li><a href="Experience?command=reservation_list&status=2">취소내역</a></li>
<!-- 				<hr>
				<li class="top-menu">나의 활동</li>
				<li><a href="#">1:1문의</a></li>
				<li><a href="#">후기</a></li> -->
				<hr>
				<li class="top-menu">나의 정보</li>
				<li><a href="#" data-toggle="modal" data-target="#myModal">회원정보변경</a></li>
				<li><a href="#" onclick="location.href='Member?command=member_passupdateform&userid=${loginUser.userid}'">비밀번호변경</a></li>
				<li><a href="#" onclick="location.href='Member?command=member_deleteform&userid=${loginUser.userid}'">회원탈퇴</a></li>
			</ul>
		</nav>

		<article>
		<h2>마이페이지</h2>
		<br>
			<table class="tb11">
				<tr>
					<td>
					<c:forEach var="del0" items="${del0}">
						<h4>${del0.deliveryStatus}</h4>
						<h2>${del0.cnt}건</h2>
					</c:forEach>
					</td>
					<td>
					<c:forEach var="del1" items="${del1}">
						<h4>${del1.deliveryStatus}</h4>
						<h2>${del1.cnt}건</h2>
					</c:forEach>
					</td>
					<td>
					<c:forEach var="del2" items="${del2}">
						<h4>${del2.deliveryStatus}</h4>
						<h2>${del2.cnt}건</h2>
					</c:forEach>
					</td>
					<td>
					<c:forEach var="del3" items="${del3}">
						<h4>${del3.deliveryStatus}</h4>
						<h2>${del3.cnt}건</h2>
					</c:forEach>
					</td>
				</tr>
			</table>
			<table class="tb11">
				<tr>
					<td>
					<c:forEach var="del4" items="${del4}">
						<h4>${del4.deliveryStatus}</h4>
						<h2>${del4.cnt}건</h2>
					</c:forEach>
					</td>
					<td>
					<c:forEach var="del5" items="${del5}">
						<h4>${del5.deliveryStatus}</h4>
						<h2>${del5.cnt}건</h2>
					</c:forEach>
					</td>
					<td>
					<c:forEach var="del6" items="${del6}">
						<h4>${del6.deliveryStatus}</h4>
						<h2>${del6.cnt}건</h2>
					</c:forEach>
					</td>
					<td>
					<c:forEach var="del7" items="${del7}">
						<h4>${del7.deliveryStatus}</h4>
						<h2>${del7.cnt}건</h2>
					</c:forEach>
					</td>
				</tr>
			</table>
			<div class="mcontent">
				<div class="row">
					<div class="column">
						<h5>
							주문배송조회 <a href="Product?command=order_list&status=1">더보기</a>
						</h5>
						<div class="line"></div>
						<p>주문 내역을 확인하세요.</p>
					</div>
					
					
					<div class="column">
						<h5>
							장바구니 <a href="Product?command=cart_list">더보기</a>
						</h5>
						<div class="line"></div>
						<p>장바구니 내역을 확인하세요.</p>
					</div>
					
					<div class="column">
						<h5>
							주문취소 내역 <a href="Product?command=order_list&status=2">더보기</a>
						</h5>
						<div class="line"></div>
						<p>취소내역을 확인하세요.</p>
					</div>
					
					
					<div class="column">
						<h5>
							예약 내역 <a href="Experience?command=reservation_list&status=1">더보기</a>
						</h5>
						<div class="line"></div>
						<p>예약 내역을 확인하세요.</p>
					</div>
				
					<div class="column">
						<h5>
							예약취소 내역 <a href="Experience?command=reservation_list&status=2">더보기</a>
						</h5>
						<div class="line"></div>
						<p>취소내역을 확인하세요.</p>
					</div>
					<div class="column">
						<h5>
							회원정보 수정 <a href="#" data-toggle="modal" data-target="#myModal">더보기</a>
						</h5>
						<div class="line"></div>
						<p>회원 정보를 수정하세요.</p>
					</div>

				</div>

				<div class="row">
				
					<!-- <div class="column">
						<h5>
							1:1문의 내역 <a>더보기</a>
						</h5>
						<div class="line"></div>
						<p>문의 내역을 확인하세요.</p>
					</div>
					
					<div class="column">
						<h5>
							후기작성 내역 <a>더보기</a>
						</h5>
						<div class="line"></div>
						<p>후기 작성 내역을 확인하세요.</p>
					</div> -->
					
					
					
				</div>
			</div>
			
		</article>
		<!-- Modal 시작 -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog">

					<!-- Modal content-->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h3 class="modal-title">비밀번호 확인</h3>
							<p>
								개인정보보호를 위해 <b>비밀번호</b>를 한번 더 입력해 주세요.
							</p>
						</div>
						<form action="Member?command=member_passcheck" method="post" id="form" name="frm">
							<div class="modal-body">
								<input type="password" id="pwd" name="pwd"
									placeholder="비밀번호를 입력해주세요." onkeyup="enterkey();">
							</div>
							<div class="modal-footer">
								<!-- <button type="button" class="btn btn-default"
								data-dismiss="modal">닫기</button> -->
								<button type="submit" class="btn btn-default">확인</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<script>
				var dropdown = document.getElementsByClassName("dropdown-btn");
				var i;

				for (i = 0; i < dropdown.length; i++) {
					dropdown[i].addEventListener("click", function() {
						this.classList.toggle("active");
						var dropdownContent = this.nextElementSibling;
						if (dropdownContent.style.display === "block") {
							dropdownContent.style.display = "none";
						} else {
							dropdownContent.style.display = "block";
						}
					});
				}
			</script>

			<!-- modal 끝 -->
	</section>
	<jsp:include page="../footer.jsp" flush="false" />

</body>
</html>


