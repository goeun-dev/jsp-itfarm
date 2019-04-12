<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판관리</title>
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
</head>
<body>
<div id="wrapper">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div id="page-wrapper">
        <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header">문의게시판관리</h2>
                </div>
                <!-- /.col-lg-12 -->
     </div>
	
	
		<h5>문의 게시판 삭제</h5>
		<form action="Admin?command=board2_delete" method="post">
			<table class="table table-bordered table-sm">
							<tr>
								<th style="width: 80px">글 번호</th>
								<td>${board.rcdNo}</td>
							</tr>
							<tr>
								<th style="width: 80px">작성자</th>
								<td>${board.usrName}</td>
							</tr>
							<tr>
								<th>제목</th>
								<td>${board.usrSubject}</td>
							</tr>
							<tr>
								<th>작성일자</th>
								<td>${board.usrDate}</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>${board.usrContent}</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>${board.usrPass}</td>
							</tr>
						</table>
						
			<br> <input type="hidden" name="rcdNo" value="${board.rcdNo}">
			<input type="submit" value="삭제" class="btn btn-default">
			 <input type="button" value="목록" onclick="location.href='Admin?command=board2_list'" class="btn btn-default">
		</form>

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
