<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder" %>

<%
//---------------------------------- 레코드 식별자 추출

int rno = Integer.parseInt(request.getParameter("rno"));

//---------------------------------- 변수 및 객체 선언

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String encoded_key="";

//---------------------------------- 키워드 데이터 추출

String column = request.getParameter("column");
if (column == null) column="";

String key = request.getParameter("key");
if(key!=null) {
	encoded_key = URLEncoder.encode(key,"utf-8");
} else {
	key="";
}

//---------------------------------- 전달된 페이지 번호 추출
int CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));

try {
	//------------------------------- JDBC 설정
	
		String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230029";
		String jdbcId = "216230029";
		String jdbcPw = "lge216230029";
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);
	
	//------------------------------- 부모 레코드의 제목과 내용 추출

	String Query1 = "SELECT UsrSubject, UsrContent FROM board2 WHERE RcdNo=?";
	pstmt = conn.prepareStatement(Query1);
	pstmt.setInt(1, rno);
	rs = pstmt.executeQuery();
	rs.next();	
	
	String subject = rs.getString(1).trim();
	String content = rs.getString(2).trim();
	content = content.replaceAll("\r\n","<BR>");
	
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8"/>
				 <link rel="stylesheet" href="../assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="../include/style.css" />
	<SCRIPT LANGUAGE="javascript" SRC="../include/scripts.js"></SCRIPT>			
	<TITLE>답변글 입력</TITLE>
	
	<SCRIPT type="text/javascript">

	function CheckForm(form) {
		
		if(!form.subject.value) {
			alert('게시판의 제목을 입력하세요.');
			form.subject.focus();
			return true;
		}

		if(!form.pass.value) {
			alert('패스워드를 입력하세요.');
			form.pass.focus();
			return true;
		}

		form.submit();

	}

	</SCRIPT>
</HEAD>

<BODY>
<%
if ((session.getAttribute("isAdmin") != "1")) {
%>
<script type="text/javascript">
alert('관리자 계정으로 로그인 후 이용해주세요.');
location.href='../Member?command=member_loginform';
</script>
<%
}
%>
<jsp:include page="../sub/subHeader.jsp" flush="false" />
<%-- <jsp:include page="../sub/citySide.jsp" flush="false" /> --%> 
<div class="main">
		<section>

<h4>답변글 입력</h4>
			<hr>
			<br>

<TABLE WIDTH=560 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>원글제목</B></TD>
		<TD WIDTH=400><%=subject%></TD>
	</TR>
	
	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>원글내용</B></TD>
		<TD WIDTH=400><%=content%></TD>
	</TR>
	
</TABLE>
<BR>

<FORM NAME="BoardReply" METHOD=POST ACTION="BoardReplyProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>" ENCTYPE="multipart/form-data">
<input type="hidden" name="name" value="${loginUser.userid}">
<TABLE WIDTH=560 BORDER=1 CELLSPACING=0 CELLPADDING=2 ALIGN=CENTER>

	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>이름</B></TD>
		<TD WIDTH=400>${loginUser.userid}</TD>
	</TR>
	
	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>제목</B></TD>
		<TD WIDTH=400>
			<INPUT TYPE=TEXT NAME="subject" SIZE=70 value="[RE] <%=subject%>">
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>내용</B></TD>
		<TD WIDTH=400>
			<TEXTAREA NAME="content" COLS=90 ROWS=5></TEXTAREA>
		</TD>
	</TR>
	
	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>파일첨부</B></TD>
		<TD WIDTH=400>
			<INPUT TYPE=FILE NAME="filename" SIZE=60>
		</TD>
	</TR> 
	  
	<TR>
		<TD WIDTH=160 ALIGN=CENTER><B>패스워드</B></TD>
		<TD WIDTH=400>
			<INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
		</TD>
	</TR>
	
</TABLE>

</FORM>

<%
}
catch (SQLException e) {
	
	e.printStackTrace();
	
} finally {
	//------------------------------- 생성된 객체 제거
	rs.close();
    pstmt.close();
    conn.close();	
}
%>

<TABLE WIDTH=560 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1 ALIGN=CENTER>

	<TR ALIGN=CENTER>
		<TD>
			<a onClick="javascript:CheckForm(BoardReply)"
						class="board-btn" STYLE="CURSOR: HAND">저장</a>
			<a href="BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">취소</a>
		</TD>
	</TR>
	
</TABLE>
</section>
</div>
</BODY>
</HTML>