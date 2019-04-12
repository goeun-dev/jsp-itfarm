<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품등록</title>
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
<script type="text/javascript" src="script/product.js"></script>
</head>
<body>
<div id="wrapper">
        <jsp:include page="../sidebar.jsp"></jsp:include>
        <div id="page-wrapper">
        <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header">제품등록</h2>
                </div>
                <!-- /.col-lg-12 -->
     </div>
	<div id="wrap" align="center">
		
		<form method="post" enctype="multipart/form-data" name="frm">
			<table class="table table-bordered table-sm">
				<tr>
					<th>상 품 명</th>
					<td><input type="text" name="name" size="80" 
					class="form-control"></td>
				</tr>
				<tr>
					<th>가 격</th>
					<td><input type="text" name="price" class="form-control"
					style="width: 300px; display: inline-block;"> 원</td>
				</tr>
				<tr>
					<th>수 량</th>
					<td><input type="number" name="count" class="form-control" 
					style="width: 300px; display: inline-block;"> 개</td>
				</tr>
				<tr>
					<th>사 진</th>
					<td><input type="file" name="pictureUrl"><br>
						(주의사항 : 이미지를 변경하고자 할때만 선택하시오)</td>
				</tr>
				<tr>
					<th>카테고리</th>
					<td><select name="category" class="form-control"><option value="1">센서</option><option value="2">원격제어</option><option value="3">알림</option>
					</select></td>
				</tr>
				<tr>
					<th>상세설명</th>
					<td><textarea rows="5" cols="85" name="description" class="form-control"></textarea> </td>
				</tr>
			</table>
			<br>
			<input class="btn btn-default" type="submit" value="등록" onclick="return productCheck()"> 
			<input class="btn btn-default" type="reset" value="다시작성"> 
			<input class="btn btn-default" type="button" value="목록" onclick="location.href='Admin?command=product_list'"> 
		</form>
	</div>	
	<br><br><br><br><br><br><br><br><br><br><br>	
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
