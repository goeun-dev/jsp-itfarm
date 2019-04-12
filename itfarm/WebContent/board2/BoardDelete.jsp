<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	//---------------------------------- 레코드 식별자 추출

	int rno = Integer.parseInt(request.getParameter("rno"));

	//---------------------------------- 변수 및 객체 선언

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

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

	//---------------------------------- 전달된 페이지 번호 추출
	int CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));

	try {
		String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230029";
		String jdbcId = "216230029";
		String jdbcPw = "lge216230029";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

		//------------------------------- 질의의 생성 및 수행

		String Query1 = "SELECT UsrName, UsrSubject, UsrContent, UsrFileName, UsrFileSize FROM board2 WHERE RcdNo=?";
		pstmt = conn.prepareStatement(Query1);
		pstmt.setInt(1, rno);
		rs = pstmt.executeQuery();

		//------------------------------- 필드 값 추출

		rs.next();

		String name = rs.getString(1);
		String subject = rs.getString(2);
		String content = rs.getString(3);
		content = content.replaceAll("\r\n", "<BR>");

		String filename = rs.getString(4);
		int filesize = rs.getInt(5);
		filesize = filesize / 1000;
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8" />
<link rel="stylesheet" href="../assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="../include/style.css" />
<TITLE>게시글 삭제</TITLE>

<SCRIPT type="text/javascript">
	function CheckForm(form) {

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
	<%-- <jsp:include page="../sub/citySide.jsp" flush="false" /> --%>
	<div class="main">
		<section>

			<h4>게시글 삭제</h4>
			<hr>
			<br>

			<FORM NAME="BoardDelete" METHOD=POST
				ACTION="BoardDeleteProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>">
				 <input type="hidden" name="name" value="${loginUser.userid}">
				<TABLE WIDTH=620 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

					<TR>
						<TD WIDTH=120 ALIGN=CENTER><B>이름</B></TD>
						<TD WIDTH=500>${loginUser.userid}
						</TD>
					</TR>

					<TR>
						<TD WIDTH=120 ALIGN=CENTER><B>제목</B></TD>
						<TD WIDTH=500><%=subject%></TD>
					</TR>

					<TR>
						<TD WIDTH=120 ALIGN=CENTER><B>내용</B></TD>
						<TD WIDTH=500><%=content%></TD>
					</TR>

					<TR>
						<TD WIDTH="120" ALIGN=CENTER><B>파일첨부</B></TD>
						<TD WIDTH="500">
							<%
								if (filename == null) {
										out.println("첨부된 파일이 없습니다");
									} else {
										String IMGURL = "../images/btn_filedown.gif";
										out.println("<IMG ALIGN=ABSMIDDLE SRC=" + IMGURL + ">");
										out.println(filename + " ( " + filesize + " Kbyte )");
									}
							%>
						</TD>
					</TR>

					<TR>
						<TD WIDTH=120 ALIGN=CENTER><B>패스워드</B></TD>
						<TD WIDTH=500><INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
						</TD>
					</TR>

				</TABLE>

			</FORM>

			<%
				} catch (SQLException e) {

					e.printStackTrace();

				} finally {
					//------------------------------- 생성된 객체 제거
					rs.close();
					pstmt.close();
					conn.close();
				}
			%>

			<TABLE WIDTH=620 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1
				ALIGN=CENTER>

				<TR ALIGN=CENTER>
					<TD>
					<a
						class="board-btn" STYLE="CURSOR: HAND"
						onClick="javascript:CheckForm(BoardDelete)">삭제</a>
					<a
						href="BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">취소</a>	
					</TD>
				</TR>

			</TABLE>
		</section>
	</div>
</BODY>
</HTML>