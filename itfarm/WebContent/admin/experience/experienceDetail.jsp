
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>농업체험상세조회</title>
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
<style type="text/css">
.none_sm {
height: 0px;
}
</style>
</head>
<body>
	<div id="wrapper">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div id="page-wrapper">
        <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header">체험관리</h2>
                </div>
                <!-- /.col-lg-12 -->
     </div>
			<div id="wrap" align="center">
				<h5>체험 상세</h5>
				<table class="list table table-bordered table-sm">
					<tr>
						<th>번호</th>
						<th>주소</th>
						<th>탐당자</th>
						<th>마을명</th>
						<th>연락처</th>
						<th>보험가입여부</th>
						<th>참가인원</th>
						<th>가격(성인)</th>
						<th>가격(어린이)</th>
					</tr>
					<tr class="record">
						<td>${prodCode}</td>
						<td>${addr}</td>
						<td>${ceoName}</td>
						<td>${villageName}</td>
						<td>${telNo}</td>
						<td>${limitStatus}</td>
						<td  align="right">${stdCnt}명</td>
						<td align="right"><fmt:formatNumber value="${adultPrice}" type="number"
								pattern="#,##0" /> 원</td>
						<td align="right"><fmt:formatNumber value="${childPrice}" type="number"
								pattern="#,##0" /> 원</td>
					</tr>
				</table>
				<div class="subimg">
					<div class="img2" id="exDetail">${detail}</div>
				</div>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script type="text/javascript">
var jb = jQuery.noConflict();
	jb("img").error(function() {
		$(this).unbind("error").attr("src", "images/none.png");
		$(this).unbind("error").attr("class", "none_sm");
	});
</script>
				<div>
					<a href="#" onclick="history.back();">
						<button class="btn btn-outline-secondary btn-sm">목록으로</button>
					</a>
				</div>
			</div>
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
