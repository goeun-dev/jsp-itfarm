<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주문관리</title>
<link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<style>
/* 그래프 */
.graph{padding:20px 0; font-size: 9pt; width: 500px; margin: auto;}
.graph ul{margin:auto 0; padding:0; height:200px; font-size:13px; list-style:none;}
.graph ul:after{content:""; display:block; clear:both;}
.graph li{
border-bottom:1px solid #ddd; float:left; display:inline; width:30%;  margin:0 30%; 
position:relative; text-align:center; white-space:nowrap;}
.graph .month{ 
    position:relative; 
    display:inline-block; 
    width:100%; 
    height:20px; 
    line-height:20px; 
    margin:0 -100% -20px 0; 
    padding:200px 0 0 0; 
    vertical-align:bottom; 
    text-align: center;
    font-weight:bold;
}
.graph .bar{
    position:relative; 
    display:inline-block; 
    width:100%; 
    margin:0 0 0 -3px; 
    border:1px solid #ddd; 
    border-bottom:0; 
    background: #ddd; 
    vertical-align:bottom;
    }
.graph .bar span{ 
    position:absolute; 
    width:100%; 
    top:-20px; 
    left:0; 
    color:#767676;} 
</style>
</head>
<body>
<section class="main">
	<jsp:include page="../sidebar.jsp" flush="false" />
	<article>
	<div class="left-loc">
	<a href="">홈</a> 
	<span> > </span>
	<a href="">통계</a>
	</div>
	<div id="wrap" align="center"> 
		<h5>주문 통계</h5>
		<br>
		<h6>상품 매출 순위</h6>
        <table class="list table table-bordered table-sm">
        <tr>
        <td>순위</td>
        <td>상품명</td>
        <td>총매출</td>
        </tr> 
        <c:set var="i" value="0"></c:set>
        <c:forEach var="rank" items="${rVo}">
        <tr>
        <td class="">
       	<c:set var="i" value="${i+1}"></c:set>
       	${i}
     	 </td>
        <td class="">
      	 ${rank.title}
     	 </td>
        <td class="">
       <fmt:formatNumber value="${rank.total}" type="number" pattern="#,##0"/> 원
     	 </td>
     	 <tr>	
        </c:forEach>
      </table>
      <br>
		<h6>월별 총 주문금액</h6>
        <table> 
        <c:forEach var="odrPrice" items="${pVo}">
        <td class="graph">
        <ul>
        <li><span class="month">${odrPrice.month}</span>
        	<c:set value="${odrPrice.total * 0.00004}" var="total"></c:set>
            <span class="bar" style="height: ${total}px">
            <span>
            <fmt:formatNumber value="${odrPrice.total}" type="number" pattern="#,##0"/> 원
            </span></span></li>
        </ul>
        </td>
        </c:forEach>
      </table>
      <br><br>
      <h6>월별 총 주문 취소 금액</h6>
        <table> 
        <c:forEach var="cnPrice" items="${cVo}">
        <td class="graph">
        <ul>
        <li><span class="month">${cnPrice.month}</span>
        	<c:set value="${cnPrice.total * 0.00004}" var="total"></c:set>
            <span class="bar" style="height: ${total}px">
            <span>
            <fmt:formatNumber value="${cnPrice.total}" type="number" pattern="#,##0"/> 원
            </span></span></li>
        </ul>
        </td>
        </c:forEach>
      </table>
      <br><br>
      <h6>월별 총 주문량</h6>
        <table> 
        <c:forEach var="odrTotal" items="${sVo}">
        <td class="graph">
        <ul>
        <li><span class="month">${odrTotal.month}</span>
            <span class="bar" style="height: ${odrTotal.total}px"><span>${odrTotal.total}</span></span></li>
        </ul>
        </td>
        </c:forEach>
      </table>  
    </div> 
	</div>
	</article>
</section>
	
</body>
</html>