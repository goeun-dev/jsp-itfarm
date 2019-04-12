<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:if test="${empty loginUser}">
	<script>location.href='../Member?command=member_loginform' </script>
</c:if>
<%
	String encoded_key = "";
	//---------------------------------- 키워드 데이터 추출

	String column = request.getParameter("column");
	if (column == null)
		column = "";

	String key = request.getParameter("key");
	if (key != null) {
		encoded_key = URLEncoder.encode(key, "utf-8");
	} else {
		key = "";
	}

	// ---------------------------------- 전달된 페이지 번호 추출
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8" />
<link rel="stylesheet" href="../assets/css/main.css" />
<!-- <link rel="stylesheet" href="../assets/css/sub_sidebar.css" /> -->
<link rel="stylesheet" type="text/css" href="../include/style.css" />-
<SCRIPT LANGUAGE="javascript" SRC="../include/scripts.js"></SCRIPT>
<TITLE>게시글 입력</TITLE>

<SCRIPT type="text/javascript">
	function CheckForm(form) {

		if (!form.subject.value) {
			alert('게시판의 제목을 입력하세요.');
			form.subject.focus();
			return true;
		}

		if (!form.pass.value) {
			alert('패스워드를 입력하세요.');
			form.pass.focus();
			return true;
		}

		form.submit();

	}
</SCRIPT>

</HEAD>

<BODY>
	<jsp:include page="../sub/subHeader.jsp" flush="false" />

	<div class="main">
		<section>

			<h4>게시글 입력</h4>
			<hr>
			<br>


			<FORM NAME="BoardWrite" METHOD=POST ACTION="BoardWriteProc.jsp"
				ENCTYPE="multipart/form-data">
			 <input type="hidden" name="name" value="${loginUser.userid}">
				<TABLE CLASS="T2" WIDTH=560 BORDER=1 CELLSPACING=0 CELLPADDING=2
					ALIGN=CENTER>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>이름</B></TD>
						<TD WIDTH=400 >${loginUser.userid}
						</TD>
						</TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>제목</B></TD>
						<TD WIDTH=400><INPUT TYPE=TEXT NAME="subject" SIZE=70>
						</TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>내용</B></TD>
						<TD WIDTH=400><TEXTAREA NAME="content" COLS=90 ROWS=8></TEXTAREA>
						</TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>파일첨부</B></TD>
						<TD WIDTH=400><INPUT TYPE=FILE NAME="filename" SIZE=60>
						</TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>패스워드</B></TD>
						<TD WIDTH=400><INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
						</TD>
					</TR>

				</TABLE>

			</FORM>

			<TABLE WIDTH=560 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1
				ALIGN=CENTER>

				<TR ALIGN=CENTER>
					<TD WIDTH=110 ALIGN=LEFT>
					<a
						href="BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>"
						class="board-btn" STYLE="CURSOR: HAND">목록</a></TD>
					<TD WIDTH=340 ALIGN=CENTER>
					<a
						onClick="javascript:CheckForm(BoardWrite)" class="board-btn"
						STYLE="CURSOR: HAND">저장</a> 
						<a
						href="BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=currentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">취소</a>
						</TD>
					<TD WIDTH=110 ALIGN=LEFT>&nbsp;</TD>
				</TR>

			</TABLE>
		</section>
	</div>
</BODY>
</HTML>