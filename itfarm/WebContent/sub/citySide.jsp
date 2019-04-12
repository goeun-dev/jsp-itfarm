<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sidenav">
		<button class="dropdown-btn">
			도시농업체험 <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../sub/sub_city.jsp">소개</a> 
		</div>
		
		<button class="dropdown-btn">
			예약하기 <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../sub/sub_city1.jsp">수도권</a> 
			<a href="../sub/sub_city2.jsp">충청</a> 
			<a href="../sub/sub_city3.jsp">전라</a> 
			<a href="../sub/sub_city4.jsp">강원</a> 
			<a href="../sub/sub_city5.jsp">경상</a> 
		</div>
		
		<button class="dropdown-btn">
			체험후기 <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="../board/BoardList.jsp">후기게시판</a> 
		</div>
	</div>
	
	<script>
		/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
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
	