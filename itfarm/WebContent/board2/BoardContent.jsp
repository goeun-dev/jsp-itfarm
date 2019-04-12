<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	int rno = Integer.parseInt(request.getParameter("rno"));

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs1 = null;

	String encoded_key = "";

	//---------------------------------- 전송된 검색어 처리

	String column = request.getParameter("column");
	if (column == null)
		column = "";

	String key = request.getParameter("key");
	if (key != null) {
		encoded_key = URLEncoder.encode(key, "utf-8");
	} else {
		key = "";
	}

	//---------------------------------- 전달된 페이지 번호 추출
	int CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));

	try {
		//------------------------------- JDBC 설정

		String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230029";
		String jdbcId = "216230029";
		String jdbcPw = "lge216230029";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

		//---------------------------------- UsrRefer 필드값 1 증가
		String Query1 = "UPDATE board2 SET UsrRefer=UsrRefer+1 WHERE RcdNo=?";
		pstmt = conn.prepareStatement(Query1);

		pstmt.setInt(1, rno);
		pstmt.executeUpdate();

		String Query2 = "SELECT UsrName, UsrSubject, UsrContent, UsrFileName, UsrFileSize FROM board2 WHERE RcdNo=?";
		pstmt = conn.prepareStatement(Query2);
		pstmt.setInt(1, rno);
		rs1 = pstmt.executeQuery();
		rs1.next();

		String name = rs1.getString(1);
		String subject = rs1.getString(2).trim();
		String content = rs1.getString(3).trim();
		content = content.replaceAll("\r\n", "<BR>");
		
		String filename = rs1.getString(4);
		int filesize = rs1.getInt(5) / 1000;
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8" />
<link rel="stylesheet" href="../assets/css/main.css" />
<!-- <link rel="stylesheet" href="../assets/css/sub_sidebar.css" /> -->
<link rel="stylesheet" type="text/css" href="../include/style.css" />
<TITLE>게시글 출력</TITLE>
</HEAD>

<BODY>
	<jsp:include page="../sub/subHeader.jsp" flush="false" />
	<%-- <jsp:include page="../sub/citySide.jsp" flush="false" /> --%>
	<div class="main">
		<section>
			<h4>게시글 내용</h4>
			<hr>
			<br>
			<TABLE ALIGN=CENTER>
				<tr class="bc-user">
				<TD WIDTH=160 ALIGN=CENTER><B>제목</B></TD>
					<TD WIDTH=150><%=subject%></TD>
					<TD WIDTH=160 ALIGN=CENTER><B>작성자</B></TD>
					<TD WIDTH=150><%= name %></TD>
				</TR>

				<TR class="bcnt-cnt"><br>
					<TD WIDTH=160 ALIGN=CENTER><B>내용</B></TD>
					<TD WIDTH=400><%=content%>
					<%
							if (filename == null) {
									
								} else {
						%> <br>
						<img style="width:50%;" 
						src="../images/board/<%=filename%>" 
						onerror="this.src='../images/none.png'"> 
					  <%
						}%>
					</TD>
				</TR>

				<TR>
					<TD WIDTH=160 ALIGN=CENTER><B>첨부파일</B></TD>
					<TD WIDTH=400>
						<%
							if (filename == null) {
									out.println("첨부된 파일이 없습니다.");
								} else {
									String IMGURL = "../images/btn_filedown.gif";
									out.println("<IMG ALIGN=ABSMIDDLE SRC=" + IMGURL + ">");
						%> <A HREF="filedownload.jsp?filename=<%=filename%>"> <%=filename%>
					</A> ( <%=filesize%> Kbyte) <%
						}
					%>
					</TD>
				</TR>

			</TABLE>
			<br>
			<hr>
			<br>
			<TABLE WIDTH=560 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1
				ALIGN=CENTER>

				<TR ALIGN=CENTER>
					<TD WIDTH="230" ALIGN=LEFT>
					<a
						href="BoardList.jsp?column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">목록</a> 
					</TD>
					<TD WIDTH="230" ALIGN=RIGHT>
					<%
					if ((session.getAttribute("isAdmin") == "1")) {
					%>
					<a
						href="BoardReply.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">답변</a>
					<%
					}
					%>
					<c:set value="<%= name %>" var="name"></c:set>
					<c:if test="${loginUser.userid == name}">
					<a
						href="BoardModify.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">수정</a>
					<a
						href="BoardDelete.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">삭제</a>
					</c:if>
						</TD>
				</TR>


			</TABLE>
		</section>
	</div>
	<%
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			rs1.close();
			pstmt.close();
			conn.close();
		}
	%>
</BODY>
</HTML>