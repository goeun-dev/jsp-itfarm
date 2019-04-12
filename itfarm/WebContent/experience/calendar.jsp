<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.itfarm.dao.ExperienceDAO"%>
<%@ page import="com.itfarm.dto.ReservationVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	request.setCharacterEncoding("UTF-8");

	//클라이언트에서 넘어온 정보 받기
	String y = request.getParameter("year");
	String m = request.getParameter("month");
	String sDate = request.getParameter("sDate");
	String prodCode = request.getParameter("prodCode");
	String stdCnt = request.getParameter("stdCnt");

	//현재 컴퓨터 시스템의 날짜 구하기
	Calendar cal = Calendar.getInstance();
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1; //클라이언트에서 넘겨준 값이 없을때 표시하는 값

	if (y != null)
		year = Integer.parseInt(y);
	if (m != null)
		month = Integer.parseInt(m);

	cal.set(year, month - 1, 1);
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH) + 1;
	// 1일은 무슨 요일?
	int w = cal.get(Calendar.DAY_OF_WEEK);

	// 달의 마지막 날짜는?
	int endDays = cal.getActualMaximum(Calendar.DATE);

	int intStdCnt = Integer.parseInt(stdCnt);
	ExperienceDAO eDao = ExperienceDAO.getInstance();
	List<ReservationVO> reservationList = eDao.reservationNum(prodCode, intStdCnt);
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 달력</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" type="text/css" href="../assets/css/calendar.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<script type="text/javascript">
var date = "";
function dayClick(date, cnt) {
	 $("#select_date").val(date);
	 $("#reCnt").val(cnt);
	 $("#selectAll").val(date+" (잔여"+cnt+"명)");
}
function daySelect() {
	  var sdate = $("#select_date").val();
	  var reCnt = $("#reCnt").val();
	  var selectAll = $("#selectAll").val();
	 
	  if (sdate == "") {
			alert("날짜를 선택하세요.");
			focus();
			return false;
		} else {
			window.opener.document.getElementById("fromInput").value = sdate;  
			window.opener.document.getElementById("recnt").value = reCnt;  
			window.opener.document.getElementById("select_all").value = selectAll;  
			 self.close();
		}
	  
}



</script>
</head>
<div class="month">
		<a href="calendar.jsp?year=<%=year%>&month=<%=month - 1%>&prodCode=<%= prodCode %>&stdCnt=<%= stdCnt %>"
			class="prev">◀</a>
		<h4><%=year%>.<%=month%></h4> 
		<a href="calendar.jsp?year=<%=year%>&month=<%=month + 1%>&prodCode=<%= prodCode %>&stdCnt=<%= stdCnt %>" class=class="next">▶</a>
</div>
<table class="list table table-bordered table-sm">
	<tr class="weekdays">
		<td align="center">일</td>
		<td align="center">월</td>
		<td align="center">화</td>
		<td align="center">수</td>
		<td align="center">목</td>
		<td align="center">금</td>
		<td align="center">토</td>
	</tr>

	<%
		int line = 0;
		//앞의 공백처리
		out.print("<tr>");
		for (int i = 1; i < w; i++) {
			out.print("<td> </td>");
			line += 1;
		}
		// 자바 버젼때문에 사용불가
		//Map<String, String> map = new HashMap<>();
		HashMap map = new HashMap();
		for (ReservationVO data : reservationList) {
			map.put(data.geteDate(), Integer.toString(data.getAdultNum()));
		}
		//1~마지막날까지 출력하기
		String fc;
		String new_date = "";
		String str_year = Integer.toString(year);
		int adultNum = 0;
		for (int i = 1; i <= endDays; i++) {
			String odate = str_year + "-" + month + "-" + i;
			SimpleDateFormat original_format = new SimpleDateFormat("yyyy-M-d");
			SimpleDateFormat new_format = new SimpleDateFormat("yyyy-MM-dd");
			Date currentTime = new Date ();
			String today = new_format.format ( currentTime );
			Calendar plusCal = new GregorianCalendar(Locale.KOREA);
			cal.setTime(currentTime);
			cal.add(Calendar.MONTH, 3);

		    String plusDate = new_format.format(plusCal.getTime());


			try {
				Date original_date = original_format.parse(odate);
				new_date = new_format.format(original_date);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			fc = line == 0 ? "#e28585" : (line == 6 ? "#84a7e0" : "#8d8d8e");
			out.print("<td align='center' class='days' id='days"+i+"' style='color:" + fc + ";'>");
			%>
			<!-- <script type="text/javascript"> -->
			<!-- /* $(function(){
			  $('.wid').click(function(){
			    $('.wid').css({
			    	background: "#b9d870",
					border-radius: "50px",
					color: "#fff",
					width: "70%"
			    });
			  });
			}); */ -->
			<!-- </script> -->
			<%
			String an;
			int cnt = intStdCnt;
			if(map.containsKey(new_date) == true){
				// 자바 버젼 때문에 사용 불가
				//an = map.get(new_date);
				an = map.get(new_date).toString();
				int intan = Integer.parseInt(an);
				cnt = intStdCnt - intan;
				
				int compareT = new_date.compareTo(today);
				int compareD = plusDate.compareTo(new_date);
				if (compareT < 0) {
					out.print("<button type='button' class='beday-btn wid' ><p>" + i +"</p></button>");
				}else if (compareT == 0) {
					out.print("<button type='button' class='today-btn wid' ><p>" + i + "</p></button>");
				} else {
					if (intan >= intStdCnt) {
						out.print("<button type='button' class='beday-btn wid' ><p>" + i + "</p></button>");
					} else {
						out.print("<label for='day'>" + "잔여: " + cnt +"</label>");
						out.print("<button type='button' class='day-btn wid' onclick='dayClick(\""
					+new_date+"\", "+cnt+" )'><p>" + i + "</p></button>");
					}
				}
			} else {
				
				int compareT = new_date.compareTo(today);
				if (compareT < 0) {
					out.print("<button type='button' class='beday-btn wid' ><p>" + i + "</p></button>");
				}else if (compareT == 0) {
					out.print("<button type='button' class='today-btn wid' ><p>" + i + "</p></button>");
				} else {
					out.print("<label for='day'>" + "잔여: " + cnt +"</label>");
					out.print("<button type='button' class='day-btn wid' onclick='dayClick(\""
				+new_date+"\", "+cnt+" )'><p>" + i + "</p></button>");
				}
			}
			
			

			out.print("</td>");
			line += 1;
			if (line == 7 && i != endDays) {
				out.print("</tr><tr>");
				line = 0;
			}

		}

		//뒷부분 공백 처리
		while (line > 0 && line < 7) {
			out.print("<td> </td>");
			line++;
		}
		out.print("</tr>");
	%>
</table>
<div class="sdate_div">
	<label for="select_date">선택날짜</label>
	<input id="select_date" type="hidden" name="selectDate" class="input">
	<input id="reCnt" type="hidden" name="selectDate">
	<input id="selectAll" type="text" name="selectDate" placeholder="날짜를 선택해주세요." readonly>
	<!-- <input type='button' class='day-btn' onclick='dayClick("2181-11-13", 100 )' value=''> -->
	<button onclick="daySelect()" 
	class="btn btn-outline-secondary btn-sm">날짜 선택</button>
</div>


<br>
</body>
</html>