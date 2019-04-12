<%@page import="com.itfarm.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    import="org.json.*"
    import = "com.itfarm.dto.ReservationVO"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%

String yyyy = (String)request.getAttribute("yyyy");
Map<String, Object> annualRevenue = (Map<String, Object>)request.getAttribute("annualRevenue");
Map<String, Object> annualRfRevenue = (Map<String, Object>)request.getAttribute("annualRefundRevenue");
List<ReservationVO> rVo = (List<ReservationVO>)request.getAttribute("expRankList");
%>
<html>
<title>주문통계</title>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>체험통계</title>

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
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var linedata = google.visualization.arrayToDataTable([
  		['체험명', '예약건수'],<%
  		for(ReservationVO data : rVo){
  			
  		out.print("['"+data.getExpName()+"', "+data.getExpid() +"],");
  		};%>]);

    var lineOpts = {
      chart: {
        title: '2018 년 월별 매출현황',
        subtitle: ''
      },
      vAxis: {
    	  format: 'decimal'
      },
      width: '100%',
      height: 500
    };
    
    var linechart = new google.visualization.PieChart(document.getElementById('line_chart'));
    linechart.draw(linedata,lineOpts);

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
                    <h3 class="page-header">체험통계</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
			<div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                    	
                        <div class="panel-heading">
                            체험 top 10
                        </div>
						<div id="wrap" align="center"> 
							<div role="main" class="container mt-5">
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
            </div><br><br><br>
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
