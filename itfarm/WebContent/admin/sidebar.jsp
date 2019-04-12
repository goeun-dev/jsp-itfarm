<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous"><meta charset="utf-8">
<style type="text/css">
.navbar {background-color: #fff;}
.navbar .nav .dropdown .dropdown-toggle{color: #87b284;}
.navbar .navbar-header .navbar-brand{color: #000;}
.navbar .navbar-header .navbar-brand img{width: 110px; height: 25px; display: inline-block;}
.navbar .navbar-default .sidebar-nav .nav li a {color: #636363;}
</style>
</head>
<body>
<!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="Admin?command=index"><img id="logo" src="admin/logo_1.png"></a>
            </div>
            <!-- /.navbar-header -->
            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="index.jsp">ITFARM</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="Member?command=member_logout"><i class="fas fa-sign-out-alt"></i>로그아웃</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="Admin?command=index"><i class="fas fa-home"></i> 홈</a>
                        </li>
                        <li>
                            <a href="#"><i class="fas fa-user-circle"></i> 회원관리<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="Admin?command=member_list&status=1">가입회원관리</a>
                                </li>
                                <li>
                                    <a href="Admin?command=member_list&status=2">탈퇴회원조회</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="Admin?command=product_list"><i class="fa fa-wrench fa-fw"></i> 제품관리</a>
                        </li>
                        <li>
                            <a href="Admin?command=order_list"><i class="fas fa-shopping-cart"></i> 주문관리</a>
                        </li>
                        <li>
                            <a href="Admin?command=experience_list"><i class="fa fa-edit fa-fw"></i> 체험관리</a>
                        </li>
                        <li>
                            <a href="Admin?command=reservation_list"><i class="far fa-calendar-alt"></i>  예약관리</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-table fa-fw"></i> 게시판관리<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="Admin?command=board2_list">문의게시판관리</a>
                                </li>
                                <li>
                                    <a href="Admin?command=board_list">후기게시판관리</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> 통계<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="Admin?command=member_month&yyyy=2018">회원통계</a>
                                </li>
                                <li>
                                    <a href="Admin?command=order_total">상품통계</a>
                                </li>
                                <li>
                                    <a href="Admin?command=order_month">주문통계</a>
                                </li>
                                <li>
                                    <a href="Admin?command=exp_stats">체험통계</a>
                                </li>
                                <li>
                                    <a href="Admin?command=reserv_month">예약통계</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
</body>