<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>체험관리</title>

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

</head>

<body>

    <div id="wrapper">

        <jsp:include page="../sidebar.jsp"></jsp:include>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">체험목록</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
								<form action="Admin?command=experience_list" method="post">
									<select name="searchSidoCode"
										onchange="this.form.submit()"
										class="area form-control" style="width: 150px; display: inline-block;">
										<c:choose>
											    <c:when test="${category == 1}">
											        <c:set var="sensor" value="selected"/>
											    </c:when>
											    <c:when test="${category == 2}">
											        <c:set var="control" value="selected"/>
											    </c:when>
											    <c:when test="${category == 3}">
											        <c:set var="notice" value="selected"/>
											    </c:when>
										</c:choose>
										<option value='' selected>${sdName}</option>
										<option value='6490000'>제주도‎</option>
										<option value='6290000'>광주광역시</option>
										<option value='6270000'>대구광역시‎</option>
										<option value='6440000'>충청남도</option>
										<option value='6430000'>충청북도</option>
										<option value='6420000'>강원도</option>
										<option value='6480000'>경상남도</option>
										<option value='6470000'>경상북도</option>
										<option value='6410000'>경기도</option>
										<option value='6260000'>부산광역시‎</option>
										<option value='6450000'>전라북도</option>
										<option value='6460000'>전라남도</option>
									</select>
									<input type="hidden" value="1" name="pageNo">
								</form>
								
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
										<!-- <th>
										<input type="checkbox"  name="checkAll" >
										</th> -->
										<th>체험번호</th>
										<th>체험명</th>
										<th>가격(성인)</th>
										<th>가격(어린이)</th>
										<th>마을명</th>
										<th>지역명</th>
									</tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="exList" items="${exList}">
									${emp}
										<tr class="record">
											<%-- <td class="chk"><input type="checkbox" name="checkOne" value="${exList.prodCode}"></td> --%>
											<td>${exList.prodCode}</td>
											<td><a href="Admin?command=experience_detail&prodCode=${exList.prodCode}&imgPath=${exList.imgPath}">${exList.title}</a></td>
											<td align="right">
												<fmt:formatNumber value="${exList.adultPrice}" type="number" pattern="#,##0"/> 원
											</td>
											<td align="right">
												<fmt:formatNumber value="${exList.childPrice}" type="number" pattern="#,##0"/> 원
											</td>
											<td>${exList.villageName}</td>
											<td>${exList.sidoName}</td>
										</tr>
									</c:forEach>
                                </tbody>
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
