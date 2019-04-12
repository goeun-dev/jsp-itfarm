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
<title>주문통계</title>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['line']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
	var linedata = new google.visualization.DataTable();
    linedata.addColumn('string', '월');
    linedata.addColumn('number', '환불/취소액');
   	linedata.addColumn('number', '매출액');

    linedata.addRows([

  		['1월', <%= annualRfRevenue.get("order_price_01") %>, <%= annualRevenue.get("order_price_01") %>],
        ['2월', <%= annualRfRevenue.get("order_price_02") %>, <%= annualRevenue.get("order_price_02") %>],
        ['3월', <%= annualRfRevenue.get("order_price_03") %>, <%= annualRevenue.get("order_price_03") %>],
        ['4월', <%= annualRfRevenue.get("order_price_04") %>, <%= annualRevenue.get("order_price_04") %>],
        ['5월', <%= annualRfRevenue.get("order_price_05") %>, <%= annualRevenue.get("order_price_05") %>],
        ['6월', <%= annualRfRevenue.get("order_price_06") %>, <%= annualRevenue.get("order_price_06") %>],
        ['7월', <%= annualRfRevenue.get("order_price_07") %>, <%= annualRevenue.get("order_price_07") %>],
        ['8월', <%= annualRfRevenue.get("order_price_08") %>, <%= annualRevenue.get("order_price_08") %>],
        ['9월', <%= annualRfRevenue.get("order_price_09") %>, <%= annualRevenue.get("order_price_09") %>],
        ['10월', <%= annualRfRevenue.get("order_price_10") %>, <%= annualRevenue.get("order_price_10") %>],
        ['11월', <%= annualRfRevenue.get("order_price_11") %>, <%= annualRevenue.get("order_price_11") %>],
        ['12월', <%= annualRfRevenue.get("order_price_12") %>, <%= annualRevenue.get("order_price_12") %>]
  		]);

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
    
    var linechart = new google.charts.Line(document.getElementById('line_chart'));
    linechart.draw(linedata, google.charts.Line.convertOptions(lineOpts));

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
<section class="main">
<jsp:include page="../sidebar.jsp" flush="false" />
	<article>
	<div class="left-loc">
	<a href="">홈</a> 
	<span> > </span>
	<a href="">월별통계</a>
	</div>
	<div id="wrap" align="center"> 
		<h5>주문 통계</h5>
		<div class="search_div">
		<form action="" class="search_form" method="post">
			<label class="tlabel">연도</label>
			<select>
			<option>2018</option>
			<option>2017</option>
			<option>2016</option>
			</select>
			<button class="btn btn-secondary btn-sm" type="submit">조회</button>
		</form>
		</div>
		<div role="main" class="container mt-5">
			<div class="btn-group" role="group" aria-label="버튼 그룹">
				<button  onclick="location.href='Admin?command=order_month'"
				class="btn btn-outline-secondary btn-sm" type="submit">월별</button>
				 
				<button onclick="location.href='Admin?command=order_week&week=7'"
				class="btn btn-outline-secondary btn-sm" type="submit">주별</button>
				 
				<button onclick="location.href='Admin?command=order_day'"
				 class="btn btn-outline-secondary btn-sm" type="submit">일별</button>
				  
				<button onclick="location.href='Admin?command=order_payment'"
				 class="btn btn-secondary btn-sm" type="submit">결제수단별</button> 
			</div>
			<div class="ml-auto mb-3">
				<div id="bar_chart">
					<div id="line_chart" class="mb-3"></div>
					<div id="bar_chart"></div>
				</div>
			</div>
		</div>
	</div> 
	<b>결제수단별 매출 내역</b>
	<table class="list table table-bordered table-sm">
	<tr align="center">
		<th rowspan="2" style="vertical-align: middle">결제방법</th>
		<th colspan="3">결제</th>		
		<th rowspan="2" style="vertical-align: middle">취소/환불</th>
		<th rowspan="2" style="vertical-align: middle">순매출</th>
		<th rowspan="2" style="vertical-align: middle">비율</th>
	</tr>
	<tr align="center">
		<th>주문수</th>
		<th>상품구매금액</th>
		<th>배송비합계</th>
	</tr>
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
	</article>
</section><br><br><br>
</body>
</html>