<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String[] stAy = request.getParameterValues("status1");
String[] pyAy = request.getParameterValues("pay");
%>
<!DOCTYPE html>
<html>

<head>

	<title>주문관리</title>
	
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
    <link rel="stylesheet" type="text/css" href="assets/css/admin2.css">
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>  
<script>
function allCheckFunc( obj ) {
		$("[name=checkOne]").prop("checked", $(obj).prop("checked") );
}

/* 체크박스 체크시 전체선택 체크 여부 */
function oneCheckFunc( obj )
{
	var allObj = $("[name=checkAll]");
	var objName = $(obj).attr("name");

	if( $(obj).prop("checked") )
	{
		checkBoxLength = $("[name="+ objName +"]").length;
		checkedLength = $("[name="+ objName +"]:checked").length;

		if( checkBoxLength == checkedLength ) {
			allObj.prop("checked", true);
		} else {
			allObj.prop("checked", false);
		}
	}
	else
	{
		allObj.prop("checked", false);
	}
}

$(function(){
	$("[name=checkAll]").click(function(){
		allCheckFunc( this );
	});
	$("[name=checkOne]").each(function(){
		$(this).click(function(){
			oneCheckFunc( $(this) );
		});
	});
});
function checkDel() {
	  var chkFirList = document.getElementsByName('checkOne');
	  var arrFir = new Array();
	  var cnt = 0;
	  for ( var idx = chkFirList.length - 1; 0 <= idx; idx--) {
	   if (chkFirList[idx].checked) {
	    arrFir[cnt] = chkFirList[idx].value;
	    cnt++;
	   }
	  }
	  
	  if (arrFir.length != 0) {
	   document.form1.submit();
	  } else {
	   alert('취소할 주문을 선택하세요.');
	   return;
	  }
}
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
function popup(url, w, h, name, option) {
    var pozX, pozY;
    var sw = screen.availWidth;
    var sh = screen.availHeight;
    var scroll = 0;
    if (option == 'scroll') {
        scroll = 1;
    }
    pozX = (sw - w) / 2;
    pozY = (sh - h) / 2;
    window.open(url, name, "location=0,status=0,scrollbars=" + scroll + ",resizable=1,width=" + w + ",height=" + h + 
    ",left=" + pozX + ",top=" + pozY);
}

function search() {
	
}
$(document).ready(function(){
	/* chk = document.getElementsByName("status1"); */
	<%
	if (stAy != null) {
		for (String val : stAy) {
			out.println("$(\"input:checkbox[id='"+val+"']\").attr(\"checked\", true);");
			System.out.println("$(\"input:checkbox[id='"+val+"']\").prop(\"checked\", true);");
		}
	} 
	%>
	<%
	if (pyAy != null) {
		for (String p : pyAy) {
			out.println("$(\"input:checkbox[id='a"+p+"']\").attr(\"checked\", true);");
			System.out.println("$(\"input:checkbox[id='a"+p+"']\").prop(\"checked\", true);");
		}
	} 
	%>
});
</script>

</head>

<body>

    <div id="wrapper">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div id="page-wrapper">
        <!-- <div class="left-loc">
	<a href="">홈</a> 
	<span> > </span> 
	<a href="">주문목록</a>
	</div> -->
	 <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header">주문관리</h2>
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
		<form action="Admin?command=order_list" class="search_form" method="post">
			<label class="tlabel">주문기간</label>
			<input type="date" class="date" id="startDate" name="startDate" 
			value="${startDate}" onchange="selectDate()"> -
			<input type="date" class="date" id="endDate" name="endDate" onclick="selectEndDate()"
			value="${endDate}" >
			<br>
			<label class="tlabel">아이디</label>
			<input type="text" name="searchName" value="${searchName}"
			class="form-control" style="width: 200px; display: inline-block;">
			<br>
			<label class="tlabel">결제방법</label>
			<label for="a1">무통장입금</label>
			<input type="checkbox" id="a1" name="pay" value="1">
			<label for="a2">카드결제</label>
			<input type="checkbox" id="a2" name="pay" value="2">
			<label for="a3">휴대폰결제</label>
			<input type="checkbox" id="a3" name="pay" value="3">
			<br>
			<label class="tlabel">주문상태</label>
			<label for="0">주문완료</label>
			<input type="checkbox" id="0" name="status1" value="0">
			<label for="1">결제완료</label>
			<input type="checkbox" id="1" name="status1" value="1">
			<label for="2">배송중</label> 
			<input type="checkbox" id="2" name="status1" value="2">
			<label for="3">배송완료</label>
			<input type="checkbox" id="3" name="status1" value="3">
			<label for="4">주문취소</label>
			<input type="checkbox" id="4" name="status1" value="4">
			<label for="5">반품신청</label>
			<input type="checkbox" id="5" name="status1" value="5">
			<label for="6">반품완료</label>
			<input type="checkbox" id="6" name="status1" value="6">
			<label for="7">반품취소</label>
			<input type="checkbox" id="7" name="status1" value="7">
			<br>
			<br>
			<button class="btn btn-default btn-block" type="submit" onclick="search();">검색</button>
		</form>
		
		</div>
		</div>
		</div>
		</div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <button class="btn btn-default btn-sm" type="button" onclick="checkDel();">
									주문 취소
							</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <form name="form1" method="post" action="Admin?command=order_chkdelete" id="checkList">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th class="chk">
										<input type="checkbox"  name="checkAll" >
										</th>
										<th>주문번호</th>
										<th>상품정보</th>
										<th>구매자</th>
										<th>결제날짜</th>
										<th>결제방법</th>
										<th>결제금액</th>
										<th>주문상태</th>
										<th></th>
                                    </tr>
                                </thead>
                                <tbody>
									<c:forEach var="sale" items="${sList}">
									${emp}
										<tr class="record">
											<td class="chk">
											<input type="checkbox" name="checkOne" value="${sale.saleid}"
											<c:if test="${sale.deliveryStatus == 4}">disabled</c:if>>
											</td>
											<td>${sale.saleid}</td>
											<td><a href="#">${sale.name} 외 ${sale.cnt} 개 상품</a></td>
											<td>${sale.userid}</td>
											<td>${sale.pDate}</td>
											<td>
											<c:choose>
												<c:when test="${sale.payment == 1}">
												무통장 입금
												</c:when>
												<c:when test="${sale.payment == 2}">
												카드결제
												</c:when>
												<c:when test="${sale.payment == 3}">
												휴대폰 결제
												</c:when>
											</c:choose>
											</td>
											<td  align="right">
											<fmt:formatNumber value="${sale.unitPrice}" type="number" pattern="#,##0"/> 원
											</td>
											<td>
											${sale.delivery}
											</td>
											<td>
											<c:choose>
												<c:when test="${sale.deliveryStatus == 1}">
											        <a href="Admin?command=delivery_form&saleid=${sale.saleid}"
													onclick="popup(this.href,400,250,'운송장 번호 등록','scroll'); return false;">
													운송장등록</a>
											    </c:when>
											    <c:when test="${sale.deliveryStatus == 0}">
											        <a href="Product?command=order_refund&id=${sale.saleid}&status=1">
													입금확인</a>
											    </c:when>
											    <c:when test="${sale.deliveryStatus == 2}">
											        ${sale.deliveryNo}
											    </c:when>
											    <c:when test="${sale.deliveryStatus == 3}">
											        ${sale.deliveryNo}
											    </c:when>
											    <c:when test="${sale.deliveryStatus == 4}">
											        -
											    </c:when>
											    <c:when test="${sale.deliveryStatus == 5}">
											         <a href="Admin?command=order_returnform&id=${sale.saleid}"
													onclick="popup(this.href,900,600,'반품 신청 내역','scroll'); return false;">
													승인/거절 하기</a>
											    </c:when>
											</c:choose>
											</td>
										</tr>
									</c:forEach>
                                </tbody>
                            </table>
                            </form>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>               
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

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
