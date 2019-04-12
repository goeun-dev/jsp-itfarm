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
google.charts.load('current', {'packages':['corechart', 'bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var linedata = new google.visualization.arrayToDataTable([
		['지역', '가입자수', { role: 'style' }],
		['서울특별시', <%= annualRevenue.get("member_01") %>, '#b87333'],
        ['부산광역시', <%= annualRevenue.get("member_02") %>, 'silver'],
        ['대구광역시', <%= annualRevenue.get("member_03") %>, 'gold'],
        ['인천광역시', <%= annualRevenue.get("member_04") %>, 'silver'],
        ['광주광역시', <%= annualRevenue.get("member_05") %>, 'silver'],
        ['대전광역시', <%= annualRevenue.get("member_06") %>, 'color: #76A7FA'],
        ['울산광역시', <%= annualRevenue.get("member_07") %>, 'color: #76A7FA'],
        ['세종특별자치시', <%= annualRevenue.get("member_08") %>, 'color: #76A7FA'],
        ['경기도', <%= annualRevenue.get("member_09") %>, 'color: #76A7FA'],
        ['강원도', <%= annualRevenue.get("member_10") %>, 'gold'],
        ['경상남도', <%= annualRevenue.get("member_11") %>, 'gold'],
        ['경상북도', <%= annualRevenue.get("member_12") %>, 'color: #76A7FA'],
        ['충청남도', <%= annualRevenue.get("member_13") %>, 'color: #76A7FA'],
        ['전라북도', <%= annualRevenue.get("member_14") %>, 'color: #76A7FA'],
        ['전라남도', <%= annualRevenue.get("member_15") %>, 'color: #76A7FA'],
        ['전라북도', <%= annualRevenue.get("member_16") %>, 'color: #76A7FA'],
        ['제주특별자치도', <%= annualRevenue.get("member_17") %>, 'color: #76A7FA']
	]);

    var lineOpts = {
      chart: {
        title: '2018 년 지역별 회원 현황',
        subtitle: ''
      },
      hAxis: {
        title: '회원수',
        minValue: 0
      },
      vAxis: {
        title: '지역',
        format: 'decimal'
      },
      width: '100%',
      height: 700
    };

    var linechart = new google.visualization.BarChart(document.getElementById('line_chart'));
    linechart.draw(linedata, lineOpts);

};

</script>
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
                            지역별 회원 통계
                        </div>
						<div role="main" class="container mt-5" align="center">
						<br>
							<div class="btn-group" role="group" aria-label="버튼 그룹">
								<button  onclick="location.href='Admin?command=member_month&yyyy=2018'"
								class="btn btn-primary btn-outline" type="submit">월별</button>
								 
								<button onclick="location.href='Admin?command=member_week&week=7'"
								class="btn btn-primary btn-outline" type="submit">주별</button>
								 
								<button onclick="location.href='Admin?command=member_day'"
								 class="btn btn-primary btn-outline" type="submit">일별</button>
								   
								 <button onclick="location.href='Admin?command=member_addr'"
								 class="btn btn-primary" type="submit">지역별</button> 
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
