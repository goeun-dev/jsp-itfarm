<%@page import="com.itfarm.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="org.json.*"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%

String yyyy = (String)request.getAttribute("yyyy");
Map<String, Object> annualRevenue = (Map<String, Object>)request.getAttribute("annualRevenue");
Map<String, Object> annualRfRevenue = (Map<String, Object>)request.getAttribute("annualRefundRevenue");
%>
<html>
<title>회원통계</title>
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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['line']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var linedata = new google.visualization.DataTable();
    linedata.addColumn('string', '월');
    linedata.addColumn('number', '탈퇴회원수');
   	linedata.addColumn('number', '가입회원수');

    linedata.addRows([

  		['1월', <%= annualRfRevenue.get("member_01") %>, <%= annualRevenue.get("member_01") %>],
        ['2월', <%= annualRfRevenue.get("member_02") %>, <%= annualRevenue.get("member_02") %>],
        ['3월', <%= annualRfRevenue.get("member_03") %>, <%= annualRevenue.get("member_03") %>],
        ['4월', <%= annualRfRevenue.get("member_04") %>, <%= annualRevenue.get("member_04") %>],
        ['5월', <%= annualRfRevenue.get("member_05") %>, <%= annualRevenue.get("member_05") %>],
        ['6월', <%= annualRfRevenue.get("member_06") %>, <%= annualRevenue.get("member_06") %>],
        ['7월', <%= annualRfRevenue.get("member_07") %>, <%= annualRevenue.get("member_07") %>],
        ['8월', <%= annualRfRevenue.get("member_08") %>, <%= annualRevenue.get("member_08") %>],
        ['9월', <%= annualRfRevenue.get("member_09") %>, <%= annualRevenue.get("member_09") %>],
        ['10월', <%= annualRfRevenue.get("member_10") %>, <%= annualRevenue.get("member_10") %>],
        ['11월', <%= annualRfRevenue.get("member_11") %>, <%= annualRevenue.get("member_11") %>],
        ['12월', <%= annualRfRevenue.get("member_12") %>, <%= annualRevenue.get("member_12") %>]
  		]);

    var lineOpts = {
      chart: {
        title: '<%=yyyy%> 년 월별 가입자수 현황',
        subtitle: ''
      },
      vAxis: {
    	  format: 'decimal'
      },
      series: {
          0: { color: '#e7711b' },
          1: { color: '#6f9654' },
        },
      width: '100%',
      height: 500
    };
    
    var linechart = new google.charts.Line(document.getElementById('line_chart'));
    linechart.draw(linedata, google.charts.Line.convertOptions(lineOpts));

};

</script>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<style type="text/css">
.date {
	border: 1px solid #a5a5a5;
}
.tlabel {width: 5%; text-align: right; padding-right: 5px; font-weight: 600;}
.increase{color: blue; text-align: center;}
.decrease{color: orange; text-align: center;}
.titleCol {vertical-align: middle;}
</style>
<body>
<div id="wrapper">

        <jsp:include page="../sidebar.jsp"></jsp:include>

        <div id="page-wrapper">
		<div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">회원통계</h3>
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
				<form action="Admin?command=member_month" class="search_form" method="post">
					<label class="tlabel">연도</label>
					<select name="yyyy">
					<option value="2018">2018</option>
					<option value="2017">2017</option>
					</select>
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
                            	월별 회원 통계
                        </div>
						<div role="main" class="container mt-5" align="center">
						<br>
							<div class="btn-group" role="group" aria-label="버튼 그룹">
								<button  onclick="location.href='Admin?command=member_month&yyyy=2018'"
								class="btn btn-primary" type="submit">월별</button>
								 
								<button onclick="location.href='Admin?command=member_week&week=7'"
								class="btn btn-primary btn-outline" type="submit">주별</button>
								 
								<button onclick="location.href='Admin?command=member_day'"
								 class="btn btn-primary btn-outline" type="submit">일별</button>
								   
								 <button onclick="location.href='Admin?command=member_addr'"
								 class="btn btn-primary btn-outline" type="submit">지역별</button> 
							</div>
							<div class="ml-auto mb-3">
								<div id="bar_chart">
									<div id="line_chart" class="mb-3"></div>
									<div id="bar_chart"></div>
								</div>
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
    <script src="admin/vendor/datatables/js/jquery.dataTables.min.js"></script>
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
