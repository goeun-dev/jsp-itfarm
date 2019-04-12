<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*"
    import="org.json.*"
    import="com.itfarm.dto.SaleVO"
	%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
List<SaleVO> sVo = (List<SaleVO>)request.getAttribute("productCountRank1");
List<SaleVO> pVo = (List<SaleVO>)request.getAttribute("categoryRank");
List<SaleVO> cVo = (List<SaleVO>)request.getAttribute("productCountRank2");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품통계</title>
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
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart1);
      google.charts.setOnLoadCallback(drawChart2);
      
	 // 판매상품 순위
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['상품명', '판매 건수'],
      	<%
    	for(SaleVO data : sVo){
            out.print("['"+data.getName()+"', "+ data.getNum() + "],");
    	}
  		%>
        ]);

        var options = {
          title: '판매상품 순위'
        };
        var chart = new google.visualization.PieChart(document.getElementById('piechart'));
        chart.draw(data, options);
        
      }
	 
      // 카테고리 순위
      function drawChart1() {
        var data = google.visualization.arrayToDataTable([
          ['카테고리명', '판매 건수'],
      	<%
      	for(SaleVO data : pVo){
            out.print("['"+data.getCategory()+"', "+ data.getNum() + "],");
    	}
  		%>
        ]);

        var options = {
          title: '카테고리 순위'
        };
        var chart = new google.visualization.PieChart(document.getElementById('piechart1'));
        chart.draw(data, options);      
      }
   
   	 // 주문취소 순위
      function drawChart2() {
        var data = google.visualization.arrayToDataTable([
          ['상품명', '주문취소 건수'],
      	<%
      	for(SaleVO data : cVo){
            out.print("['"+data.getName()+"', "+ data.getNum() + "],");
    	}
  		%>
        ]);

        var options = {
          title: '주문취소 순위'
        };
        var chart = new google.visualization.PieChart(document.getElementById('piechart2'));
        chart.draw(data, options);      
      }
</script>

</head>

<body>
<div id="wrapper">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div id="page-wrapper">
        <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">상품통계</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
        
        <div class="row">
			<div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            판매상품 순위
                        </div>
                        <div align="center">
						<div id="piechart" style="width: 900px; height: 500px;"></div>
						</div>
					</div> 
			</div>
		</div>
        <div class="row">
			<div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            판매상품전체 순위내역
                        </div>
                         <table class="table table-striped table-bordered table-hover" id="dataTables-example">
				        <thead>
				        <tr style="font-weight: bold;">
				        <td>순위</td>
				        <td>상품명</td>
				        <td>판매가</td>
				        <td>판매수량</td>
				        <td>판매합계</td>
				        </tr> 
				        </thead>
				      <c:set var="i" value="0"></c:set>  
				        <c:forEach var="rank" items="${rVo}">
				        <tr>
				        <td class="">
				       	<c:set var="i" value="${i+1}"></c:set>
				       	${i}
				     	 </td>
				        <td class="">
				      	 ${rank.name}
				     	 </td>
				        <td class="" align="right">
				       <fmt:formatNumber value="${rank.unitPrice}" type="number" pattern="#,##0"/> 원  
				     	 </td>
				     	 <td class="" align="right">
				     	 ${rank.num} 개
				     	 </td>
				   		<td class="" align="right">
				   		<fmt:formatNumber value="${rank.num*rank.unitPrice}" type="number" pattern="#,##0"/> 원
				   		</td>
				     	 </tr>	
				        </c:forEach>
				      </table>
					</div> 
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            카테고리별 순위
                        </div>
                        <div align="center">
						<div id="piechart1" style="width: 900px; height: 500px;"></div>
						</div>
					</div> 
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            주문취소 순위
                        </div>
                        <div align="center">
						<div id="piechart2" style="width: 900px; height: 500px;"></div>
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
