<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="sidenav">
		<button class="dropdown-btn">
			센서 <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="sub_item1.jsp">기상센서 노드</a> 
			<a href="sub_item1.jsp">풍향ㆍ풍속 센서</a> 
			<a href="sub_item1.jsp">일사량 센서</a> 
		</div>
		<button class="dropdown-btn">
			원격제어 <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="sub_item1.jsp">sub</a> 
		</div>
		
		<button class="dropdown-btn">
			알림 <i class="fa fa-caret-down"></i>
		</button>
		<div class="dropdown-container">
			<a href="sub_item1.jsp">sub</a> 
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
	