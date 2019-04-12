<%@page import="com.itfarm.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="org.json.*"
    import= "java.text.SimpleDateFormat"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
/* String startDt = "20170801";
int endDt = 20181211; */
String startDt = request.getParameter("startDate");
String endDate = request.getParameter("endDate");

SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat str_sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c1 = Calendar.getInstance();
String strToday = sdf.format(c1.getTime());
Calendar week = Calendar.getInstance();
week.add(Calendar.MONTH, -1);
String lastWeek = sdf.format(week.getTime());

if (startDt == null) {
	startDt = lastWeek;
} else {
	String startDt1 = startDt.split("-")[0];
	String startDt2 = startDt.split("-")[1];
	String startDt3 = startDt.split("-")[2];
	Calendar st = Calendar.getInstance();
	st.set(Integer.parseInt(startDt1), Integer.parseInt(startDt2)-1, Integer.parseInt(startDt3));
	startDt = sdf.format(st.getTime());
}

if (endDate == null) {
	endDate = strToday;
} else {
	String endDate1 = endDate.split("-")[0];
	String endDate2 = endDate.split("-")[1];
	String endDate3 = endDate.split("-")[2];
	Calendar ed = Calendar.getInstance();
	ed.set(Integer.parseInt(endDate1), Integer.parseInt(endDate2)-1, Integer.parseInt(endDate3));
	endDate = sdf.format(ed.getTime());
}

int endDt = Integer.parseInt(endDate);
int startYear = Integer.parseInt(startDt.substring(0, 4));
int startMonth = Integer.parseInt(startDt.substring(4, 6));
int startDate = Integer.parseInt(startDt.substring(6, 8));

Calendar cal = Calendar.getInstance();

// Calendar의 Month는 0부터 시작하므로 -1 해준다.
// Calendar의 기본 날짜를 startDt로 셋팅해준다.
cal.set(startYear, startMonth-1, startDate);

String yyyy = (String)request.getAttribute("yyyy");
Map<String, String> dayRevenue = (LinkedHashMap<String, String>)request.getAttribute("dayRevenue");
Map<String, String> dayRefundRevenue = (LinkedHashMap<String, String>)request.getAttribute("dayRefundRevenue");

%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>주문통계</title>
 	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Bootstrap Core CSS -->
    <link href="admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="admin/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="admin/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="admin/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="admin/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="admin/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
       <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
         <script>
 
  var chartDrowFun = {
 
    chartDrow : function(){
        var chartData = '';
 
        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
        var chartDateformat = 'yyyy년MM월dd일';
        //라인차트의 라인 수
        var chartLineCount    = 10;
        //컨트롤러 바 차트의 라인 수
        var controlLineCount    = 10;
 
 
        function drawDashboard() {
 
          var data = new google.visualization.DataTable();
          //그래프에 표시할 컬럼 추가
          data.addColumn('datetime' , '날짜');
          data.addColumn('number'   , '환불/취소액');
          data.addColumn('number'   , '매출액');
 
          //그래프에 표시할 데이터
          data.addRows([
        	  <%
        	  System.out.println(dayRevenue.get("2018-11-07"));
              while (true){
            	  
            	  int year = Integer.parseInt(sdf.format(cal.getTime()).substring(0, 4));
            	  int month = Integer.parseInt(sdf.format(cal.getTime()).substring(4, 6))-1;
            	  String cmonth = sdf.format(cal.getTime()).substring(4, 6);
            	  /* if (Integer.parseInt(cmonth) < 10) {
            		  cmonth = "0"+cmonth;
            	  } */
            	  int date = Integer.parseInt(sdf.format(cal.getTime()).substring(6, 8));
            	  String cdate = (sdf.format(cal.getTime()).substring(6, 8));
            	  /* if (Integer.parseInt(cdate) < 10) {
            		  cdate = "0"+cdate;
            	  } */
            	  
            	  if (Integer.parseInt(sdf.format(cal.getTime())) != endDt){
            		  // 환불 0, 매출 y
            		  if(dayRevenue.get(year+"-"+cmonth+"-"+cdate)!=null && dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate)==null){
            			  out.print("[new Date("+year+", "+month+", "+ date +", 9)" +", "
            	           + 0 +", " + dayRevenue.get(year+"-"+cmonth+"-"+cdate) + "],");
            			  
            			  System.out.print(" 환불 0, 매출 y[new Date("+year+", "+month+", "+ date +", 9)" +", "
                   	           + 0 +", " + dayRevenue.get(year+"-"+cmonth+"-"+date) + "],");
            		  }
            		// 환불 y, 매출 0
            		else if(dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate) != null && dayRevenue.get(year+"-"+cmonth+"-"+cdate)==null) {
            			  out.print("[new Date("+year+", "+month+", "+ date +", 6)" +", "
                   	           + dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate) +", " + 0 + "],");
            			  
            			  System.out.print("환불 y, 매출 0[new Date("+year+", "+month+", "+ date +", 6)" +", "
                      	           + dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate) +", " + 0 + "],");
            		  }
            		// 환불 0, 매출 0
            		else if (dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate)==null && dayRevenue.get(year+"-"+cmonth+"-"+cdate) == null) {
            			  out.print("[new Date("+year+", "+month+", "+ date +", 5)" +", "
                   	           + 0 +", " + 0 + "],");
            			  System.out.print("환불 0, 매출 0[new Date("+year+", "+month+", "+ cdate +", 5)" +", "
                      	           + 0 +", " + 0 + "],");
            		  }
            		// 환불 y, 매출 y
            		else if (dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate)!=null && dayRevenue.get(year+"-"+cmonth+"-"+cdate) != null) {
            			 out.print("[new Date("+year+", "+month+", "+ date +", 4)" +", "
                  	           + dayRefundRevenue.get(year+"-"+cmonth+"-"+cdate) 
                  	           +", " + dayRevenue.get(year+"-"+cmonth+"-"+cdate) + "],");
            			 
            			 System.out.print("환불 y, 매출 y[new Date("+year+", "+month+", "+ date +", 4)" +", "
                    	           + dayRefundRevenue.get(year+"-"+cmonth+"-"+date) 
                      	           +", " + dayRevenue.get(year+"-"+cmonth+"-"+date) + "],");
            		  }
            		
            		  
            		  
                  } else {
                	  out.print("[new Date("+year+", "+month+", "+ date +", 3)" +", "
                 	           + 0 
                 	           +", " + 0 + "]");
                  }  
                		
                // Calendar의 날짜를 하루씩 증가한다.
                cal.add(Calendar.DATE, 1); 
				
                // 현재 날짜가 종료일자보다 크면 종료
                if (Integer.parseInt(sdf.format(cal.getTime())) > endDt){
                	break;
                }
              }
              %>
          ]);
          console.log(data);
 
 
            var chart = new google.visualization.ChartWrapper({
              chartType   : 'LineChart',
              containerId : 'lineChartArea', //라인 차트 생성할 영역
              options     : {
                              isStacked   : 'percent',
                              focusTarget : 'category',
                              height          : 500,
                              width              : '100%',
                              legend          : { position: "top", textStyle: {fontSize: 13}},
                              pointSize        : 5,
                              
                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
                              hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
                                                                  years : {format: ['yyyy년']},
                                                                  months: {format: ['MM월']},
                                                                  days  : {format: ['dd일']},
                                                                  hours : {format: ['HH시']}}
                                                                },textStyle: {fontSize:12}},
                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
                animation        : {startup: true,duration: 1000,easing: 'in' },
                annotations    : {pattern: chartDateformat,
                                textStyle: {
                                fontSize: 15,
                                bold: true,
                                italic: true,
                                color: '#871b47',
                                auraColor: '#d799ae',
                                opacity: 0.8,
                                pattern: chartDateformat
                              }
                            }
              },chart: {
                  title: '일별 매출현황',
                  subtitle: ''
                }
            });
 
            var control = new google.visualization.ControlWrapper({
              controlType: 'ChartRangeFilter',
              containerId: 'controlsArea',  //control bar를 생성할 영역
              options: {
                  ui:{
                        chartType: 'LineChart',
                        chartOptions: {
                        chartArea: {'width': '70%','height' : 80},
                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
                            gridlines:{count:controlLineCount,units: {
                                  years : {format: ['yyyy년']},
                                  months: {format: ['MM월']},
                                  days  : {format: ['dd일']},
                                  hours : {format: ['HH시']}}
                            }}
                        }
                  },
                    filterColumnIndex: 0
                }
            });
 
            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
            date_formatter.format(data, 0);
 
            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
            dashboard.bind([control], [chart]);
            dashboard.draw(data);
 
        }
          google.charts.setOnLoadCallback(drawDashboard);
 
      }
    }
 
$(document).ready(function(){
  google.charts.load('current', {'packages':['line','controls']});
  chartDrowFun.chartDrow(); //chartDrow() 실행
});
  
  function selectDate() {
		var startDate = document.getElementById("startDate").value;
		var endDate = document.getElementById("endDate");
		endDate.setAttribute("min", startDate);
	}
	function selectEndDate(){
		var startDate = document.getElementById("startDate").value;
		var endDate = document.getElementById("endDate");
		if (startDate == null || startDate == "") {
			alert("시작날짜를 선택하세요.");
		}
	}
  </script>
  <link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
  <style type="text/css">
.date {
	border: 1px solid #a5a5a5;
}
.tlabel {width: 5%; text-align: right; padding-right: 5px; font-weight: 600;}
.increase{color: blue;}
.decrease{color: orange;}
</style>
  </head>
  <body>
 <div id="wrapper">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div id="page-wrapper">
        <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">예약통계</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
      <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            검색
                        </div>
				<div class="search_div">
				<form action="Admin?command=reserv_day" class="search_form" method="post">
					<label class="tlabel">결제기간</label>
					<input type="date" class="date" id="startDate" name="startDate" 
					value="${startDate}" onchange="selectDate()"> -
					<input type="date" class="date" id="endDate" name="endDate" onclick="selectEndDate()"
					value="${endDate}" min="2018-10-22">
					<button class="btn btn-default btn-sm" type="submit">조회</button>
				</form>
				</div>
				</div>
				</div>
			</div>   
			<div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	일별 예약 통계
                        </div>
                        <br>
                        <div role="main" class="container mt-5" align="center">
							<div class="btn-group" role="group" aria-label="버튼 그룹" >
								 <button  onclick="location.href='Admin?command=reserv_month'"
								class="btn btn-primary btn-outline btn-sm" type="submit">월별</button>
								 
								<button onclick="location.href='Admin?command=reserv_week&week=7'"
								class="btn btn-primary btn-outline btn-sm" type="submit">주별</button> 
								
								<button onclick="location.href='Admin?command=reserv_day'"
								 class="btn btn-primary btn-sm" type="submit">일별</button>
							</div>
							</div><br>
							<div id="Line_Controls_Chart">
								<p style="width:100%; text-align: center;">일별 매출현황</p>
						      <!-- 라인 차트 생성할 영역 -->
						          <div id="lineChartArea" style="padding:0px 20px 0px 0px;">
						          
						          </div>
						      <!-- 컨트롤바를 생성할 영역 -->
						          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
						      </div>
						      </div>
					</div> 
                	</div>
                 </div>    
	
	
	</div>
</div>
<!-- jQuery -->
    <script src="admin/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="admin/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="admin/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    
    <script src="admin/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="admin/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="admin/dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
    });
    </script>

</body>

</html>
