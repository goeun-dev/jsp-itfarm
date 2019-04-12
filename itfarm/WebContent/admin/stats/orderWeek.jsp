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
Map<String, Object> weekRevenue = (Map<String, Object>)request.getAttribute("weekRevenue");
Map<String, Object> weekRefundRevenue = (Map<String, Object>)request.getAttribute("weekRefundRevenue");

%>
<html>
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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['line']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var linedata = new google.visualization.DataTable();
    linedata.addColumn('string', '주');
    linedata.addColumn('number', '환불/취소액');
   	linedata.addColumn('number', '매출액');

    linedata.addRows([
    	['7주전', <%= weekRefundRevenue.get("order_price_01") %>, <%= weekRevenue.get("order_price_01") %>],
        ['5주전', <%= weekRefundRevenue.get("order_price_02") %>, <%= weekRevenue.get("order_price_02") %>],
        ['4주전', <%= weekRefundRevenue.get("order_price_03") %>, <%= weekRevenue.get("order_price_03") %>],
        ['3주전', <%= weekRefundRevenue.get("order_price_04") %>, <%= weekRevenue.get("order_price_04") %>],
        ['2주전', <%= weekRefundRevenue.get("order_price_05") %>, <%= weekRevenue.get("order_price_05") %>],
        ['1주전', <%= weekRefundRevenue.get("order_price_06") %>, <%= weekRevenue.get("order_price_06") %>],
        ['이번주', <%= weekRefundRevenue.get("order_price_07") %>, <%= weekRevenue.get("order_price_07") %>]
  		]);

    var lineOpts = {
      chart: {
        title: '최근 7주간 매출현황',
        subtitle: ''
      },
      vAxis: {
    	  format: 'decimal'
      },
      animation: {startup: true, duration: 1000, easing: 'in' },
      tooltip: {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
      width: '100%',
      height: 500
    };
    
    var linechart = new google.charts.Line(document.getElementById('line_chart'));
    linechart.draw(linedata, google.charts.Line.convertOptions(lineOpts));

};

</script>
<style type="text/css">
.date {
	border: 1px solid #a5a5a5;
}
.tlabel {width: 5%; text-align: right; padding-right: 5px; font-weight: 600;}
.increase{color: blue;}
.decrease{color: orange;}
</style>
<body>
<div id="wrapper">

        <jsp:include page="../sidebar.jsp"></jsp:include>

        <div id="page-wrapper">
			<div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">주문통계</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            	주별 주문 통계
                        </div>
                        <div role="main" class="container mt-5" align="center">
                        <br>
							<div class="btn-group" role="group" aria-label="버튼 그룹" >  
								 <button  onclick="location.href='Admin?command=order_month'"
								class="btn btn-primary btn-outline btn-sm" type="submit">월별</button>
								 
								<button onclick="location.href='Admin?command=order_week&week=7'"
								class="btn btn-primary btn-sm" type="submit">주별</button> 
								
								<button onclick="location.href='Admin?command=order_day'"
								 class="btn btn-primary btn-outline btn-sm" type="submit">일별</button> 
							</div>
							</div>
							
							<div id="bar_chart">
								<div id="line_chart" class="mb-3"></div>
								<div id="bar_chart"></div>
							</div>
						
					</div> 
                	</div>
                 </div>
                 <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
								주별 매출 내역
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
						<tr align="center">
							<th rowspan="2" style="vertical-align: middle">일자</th>
							<th colspan="3">결제완료주문</th>		
							<th rowspan="2" style="vertical-align: middle">결제금액합계</th>
							<th rowspan="2" style="vertical-align: middle">환불/취소합계</th>
							<th rowspan="2" style="vertical-align: middle">순매출</th>
						</tr>
						<tr align="center">
							<th>주문수</th>
							<th>상품구매금액</th>
							<th>배송비합계</th>
						</tr>
						</thead>
						<c:forEach var="sale" items="${sVo}">
						<tr>
							<td align="center">
							${sale.month}
							</td>
							<td align="right">
							<fmt:formatNumber value="${sale.cnt}" type="number" pattern="#,##0"/> 건
							</td>
							<td  align="right">
							<fmt:formatNumber value="${sale.num}" type="number" pattern="#,##0"/> 원
							</td>
							<td  align="right">
							<fmt:formatNumber value="${sale.delivery}" type="number" pattern="#,##0"/> 원
							</td>
							<td  align="right">
							<fmt:formatNumber value="${sale.total}" type="number" pattern="#,##0"/> 원
							</td>
							<td  align="right">
							<fmt:formatNumber value="${sale.unitPrice}" type="number" pattern="#,##0"/> 원
							</td>
							<td align="right">
							<fmt:formatNumber value="${sale.price}" type="number" pattern="#,##0"/> 원
							</td>
					
							<c:set var="orderCntSum" value="${orderCntSum + sale.cnt}"></c:set>
							<c:set var="buyPriceSum" value="${buyPriceSum + sale.num}"></c:set>
							<c:set var="delPriceSum" value="${delPriceSum + sale.delivery}"></c:set>
							<c:set var="orderPriceSum" value="${orderPriceSum + sale.total}"></c:set>
							<c:set var="refundPriceSum" value="${refundPriceSum + sale.unitPrice}"></c:set>
							<c:set var="netSaleSum" value="${netSaleSum + sale.price}"></c:set>
						</tr>
						</c:forEach>
						<tr>
							<td align="center">합계</td>
							<td align="right">
							<fmt:formatNumber value="${orderCntSum}" type="number" pattern="#,##0"/> 건
							</td>
							<td align="right">
							<fmt:formatNumber value="${buyPriceSum}" type="number" pattern="#,##0"/> 원
							</td>
							<td align="right">
							<fmt:formatNumber value="${delPriceSum}" type="number" pattern="#,##0"/> 원
							</td>
							<td align="right">
							<fmt:formatNumber value="${orderPriceSum}" type="number" pattern="#,##0"/> 원
							</td>
							<td align="right">
							<fmt:formatNumber value="${refundPriceSum}" type="number" pattern="#,##0"/> 원
							</td>
							<td align="right">
							<fmt:formatNumber value="${netSaleSum}" type="number" pattern="#,##0"/> 원
							</td>
						</tr>
						</table>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>               
            <!-- /.row -->
                 <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
								전주/금주 증감 추이
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <table  class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <thead>
						<tr align="center">
							<th>기간</th>
							<th colspan="2">결제합계</th>
							<th colspan="2">환불합계</th>
							<th colspan="2">순매출</th>
						</tr>	
						</thead>
						<c:forEach var="t1" items="${rc}" begin="0" end="0">
						<c:set var= "total1" value="${t1.total}"/>
						<c:set var= "unitPrice1" value="${t1.unitPrice}"/>
						<c:set var= "price1" value="${t1.price}"/>
						</c:forEach>
						<c:forEach var="t2" items="${rc}" begin="1" end="1">
						<c:set var= "total2" value="${t2.total}"/>
						<c:set var= "unitPrice2" value="${t2.unitPrice}"/>
						<c:set var= "price2" value="${t2.price}"/>
						</c:forEach>
						<c:forEach var="rc" items="${rc}" varStatus="status">
						<tr>
							<c:if test="${status.first}">
							<td align="center">금주(${rc.month})</td>
							</c:if>
							<c:if test="${status.last}">
							<td align="center">전주(${rc.month})</td>
							</c:if>
							<c:set var= "total3" value="${(total1-total2)/total2*100}"/>
							<c:set var= "price3" value="${(price1-price2)/total2*100}"/>
							<c:set var= "unitPrice3" value="${(unitPrice1-unitPrice2)/total2*100}"/>
							<td align="right">
							<fmt:formatNumber value="${rc.total}" type="number" pattern="#,##0"/> 원
							</td>
							
							<c:if test="${status.first}">
							<c:if test="${total3 < 0 }">
							<td rowspan="2" class="decrease" align="center" style="vertical-align: middle">
							<fmt:formatNumber value="${total3}" 
							type="number" pattern=".00"/> % 감소
							</td>
							</c:if>
							<c:if test="${total3 > 0}">
							<td rowspan="2" class="increase" align="center" style="vertical-align: middle">
							<fmt:formatNumber value="${total3}" 
							type="number" pattern=".00"/> % 증가
							</td>
							</c:if>
							</c:if>
						
							
							<td align="right">
							<fmt:formatNumber value="${rc.unitPrice}" type="number" pattern="#,##0"/> 원
							</td>
							
							<c:if test="${status.first}">
							<c:if test="${unitPrice3 < 0 }">
							<td rowspan="2" class="decrease" align="center" style="vertical-align: middle">
							<fmt:formatNumber value="${unitPrice3}" 
							type="number" pattern=".00"/> % 감소
							</td>
							</c:if>
							<c:if test="${unitPrice3 > 0}">
							<td rowspan="2" class="increase" align="center" style="vertical-align: middle">
							<fmt:formatNumber value="${unitPrice3}" 
							type="number" pattern=".00"/> % 증가
							</td>
							</c:if>
							</c:if> 
							
							<td align="right">
							<fmt:formatNumber value="${rc.price}" type="number" pattern="#,##0"/> 원
							</td>
							
							<c:if test="${status.first}">
							<c:if test="${price3 < 0 }">
							<td rowspan="2" class="decrease" align="center" style="vertical-align: middle">
							<fmt:formatNumber value="${price3}" 
							type="number" pattern=".00"/> % 감소
							</td>
							</c:if>
							<c:if test="${price3 > 0}">
							<td rowspan="2" class="increase" align="center" style="vertical-align: middle">
							<fmt:formatNumber value="${price3}" 
							type="number" pattern=".00"/> % 증가
							</td>
							</c:if> 
							</c:if> 	
						</tr>
						</c:forEach>
						</table>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>               
            <!-- /.row -->
			

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
