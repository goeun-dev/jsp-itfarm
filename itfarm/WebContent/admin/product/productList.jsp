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

    <title>제품관리</title>

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
<style type="text/css">
.tlabel {  padding-right: 5px; padding-left: 5px; font-weight: 600;}
</style>
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
	   alert('삭제할 상품을 선택하세요.');
	   return;
	  }
	}
</script>
</head>

<body>

    <div id="wrapper">

        <jsp:include page="../sidebar.jsp"></jsp:include>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h2 class="page-header">제품관리</h2>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            검색
                        </div>
				<div class="search_div">
				<form action="Admin?command=product_search" class="search_form" method="post">
					<label  class="tlabel">카테고리</label>
					<select name="searchCategory" class="form-control" style="width: 100px; display: inline-block;">
						<c:choose>
								<%-- <c:when test="${searchCategory == null}">
							        <c:set var="sctgry" value="전체"/>
							    </c:when> --%>
							    <c:when test="${searchCategory == 1}">
							        <c:set var="sensor" value="selected"/>
							    </c:when>
							    <c:when test="${searchCategory == 2}">
							        <c:set var="control" value="selected"/>
							    </c:when>
							    <c:when test="${searchCategory == 3}">
							        <c:set var="notice" value="selected"/>
							    </c:when>
						</c:choose>
						<option value="">전체</option>
						<option value="1" <c:out value="${sensor}"></c:out>>센서</option>
						<option value="2" <c:out value="${control}"></c:out>>원격제어</option>
						<option value="3" <c:out value="${notice}"></c:out>>알림</option>
					</select><br>
					<label  class="tlabel">제품명</label>
					<input type="text" name="searchName" value="${searchName}" class="form-control" style="width: 400px; display: inline-block;">
					<br>
					<br>
					<button class="btn btn-default btn-block" type="submit" onclick="search();">검색</button>
				</form>
				</div>
				</div>
				</div>
			</div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <button class="btn btn-default btn-sm" type="button" onclick="location.href='ProductWrite'">
								등록
							</button>
							<button class="btn btn-default btn-sm" type="button" onclick="checkDel();">
								선택 삭제
							</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <form name="form1" method="post" action="Admin?command=product_chkdelete" id="checkList">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th class="chk">
										<input type="checkbox"  name="checkAll" >
										</th>
										<th>번호</th>
										<th>이미지</th>
										<th>상품명</th>
										<th>카테고리</th>
										<th>가격</th>
										<th>수량</th>
										<th>수정</th>
										<th>삭제</th>
                                    </tr>
                                </thead>
                                <tbody>
									<c:forEach var="product" items="${productList}">
									${emp}
										<tr class="record">
											<td class="chk"><input type="checkbox" name="checkOne" value="${product.productNum}"></td>
											<td>${product.productNum}</td>
											<td><img style="width: 30px; height: 30px;" src="images/product/${product.productImg}"></td>
											<td><a href="ProductUpdate?productNum=${product.productNum}">${product.name}</a></td>
											<td>
											<c:choose>
											    <c:when test="${product.category == 1}">
											        <c:set var="ctgry" value="센서"/>
											    </c:when>
											    <c:when test="${product.category == 2}">
											        <c:set var="ctgry" value="원격제어"/>
											    </c:when>
											    <c:when test="${product.category == 3}">
											        <c:set var="ctgry" value="알림"/>
											    </c:when>
											</c:choose><c:out value="${ctgry}"></c:out> </td>
											<td  align="right"><fmt:formatNumber value="${product.price}" type="number" pattern="#,##0"/> 원</td>
											<td  align="right">
											<c:if test="${product.count == 0}">
											<span style="color:#a35244;">
											</c:if>
											<fmt:formatNumber value="${product.count}" type="number" pattern="#,##0"/> 
											</span>
											개
											</td>
											<td align="center"><a href="ProductUpdate?productNum=${product.productNum}">수정</a>
											</td>
											<td  align="center"><a href="Admin?command=product_deleteform&productNum=${product.productNum}">삭제</a>
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
