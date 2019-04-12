<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자페이지</title>

    <!-- Bootstrap Core CSS -->
    <link href="admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="admin/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="admin/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="admin/vendor/morrisjs/morris.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="admin/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<link rel="stylesheet" type="text/css" href="assets/css/admin_index.css">
<style type="text/css">
p{
width: 100%;
padding-left: 10px;
padding-top: 10px;
font-size: 22px;
}
</style>

</head>

<body>

    <div id="wrapper">

        <jsp:include page="sidebar.jsp"></jsp:include>

        <div id="page-wrapper">
            <article>
			<h3></h3>
			<span>(이번달 현황)</span><br>
			<div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">주문현황</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
			<div class="row">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    	<c:forEach var="sts0" items="${sts0}">
                        <div class="panel-heading">
                            <b>주문완료</b><span> ${sts0.category} 건</span>
                        </div>
						<p>
						<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
						</p>
						</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts0" items="${sts1}">
                        <div class="panel-heading">
                            <b>결제완료</b>	<span> ${sts0.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts0" items="${sts2}">
                        <div class="panel-heading">
                            <b>배송중</b><span> ${sts0.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts0" items="${sts3}">
                        <div class="panel-heading">
                            <b>배송완료</b>
					<span> ${sts0.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
            </div>
			<div class="row">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts0" items="${sts4}">
                        <div class="panel-heading">
                            <b>취소완료</b>
					<span> ${sts0.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts0" items="${sts5}">
                        <div class="panel-heading">
                            <b>반품요청</b>
					<span> ${sts0.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts0" items="${sts6}">
                        <div class="panel-heading">
                            <b>반품완료</b>
					<span> ${sts0.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts0.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="sts7" items="${sts7}">
                        <div class="panel-heading">
                            <b>반품취소</b>
					<span>${sts7.category} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${sts7.num}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
            </div>
			<div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">예약현황</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
			<div class="row">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    	<c:forEach var="rs" items="${rs}">
                        <div class="panel-heading">
                            <b>예약완료</b><span> ${rs.expName} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${rs.price}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    <c:forEach var="rsc" items="${rsc}">
                        <div class="panel-heading">
                            <b>예약취소</b><span> ${rsc.expName} 건</span>
                        </div>
					<p>
					<fmt:formatNumber value="${rsc.price}" type="number" pattern="#,##0"/> 원
					</p>
					</c:forEach>
                	</div>
                 </div>
            </div>
			<div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">가입현황</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
			<div class="row">
                <div class="col-lg-3">
                    <div class="panel panel-default">
                    	
                        <div class="panel-heading">
                           <b>가입현황</b> 
                        </div>
						<c:forEach var="rs" items="${rs}">
						<p>
						${mem} 명
						</p>
						</c:forEach>
                	</div>
                 </div>
            </div>
			<br>

			<br><br><br><br>
			

		</article>
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

    <!-- Morris Charts JavaScript -->
    <script src="admin/vendor/raphael/raphael.min.js"></script>
    <script src="admin/vendor/morrisjs/morris.min.js"></script>
    <script src="admin/data/morris-data.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="admin/dist/js/sb-admin-2.js"></script>

</body>

</html>
