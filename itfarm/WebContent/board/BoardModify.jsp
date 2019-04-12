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
		//------------------------------- JDBC 설정
		String jdbcUrl = "";
		String jdbcId = "";
		String jdbcPw = "";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

		//------------------------------- 질의의 수행 및 필드 값 추출
		String Query1 = "SELECT UsrName, UsrSubject, UsrContent, UsrFileName, UsrFileSize FROM board1 WHERE RcdNo=?";
		pstmt = conn.prepareStatement(Query1);
		pstmt.setInt(1, rno);

		rs = pstmt.executeQuery();
		rs.next();

		String name = rs.getString(1);
		String subject = rs.getString(2);
		String content = rs.getString(3);
		String filename = rs.getString(4);
		int filesize = rs.getInt(5);
		filesize = filesize / 1000;
%>

<HTML>
<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8" />
<link rel="stylesheet" href="../assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="../include/style.css" />
<TITLE>게시글 수정</TITLE>

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
	<div class="main">
		<section>

			<h4>게시글 수정</h4>
			<hr>
			<br>


			<FORM NAME="BoardModify" METHOD=POST
				ACTION="BoardModifyProc.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
				ENCTYPE="multipart/form-data">
		  <input type="hidden" name="name" value="${loginUser.userid}">
				<TABLE WIDTH=560 BORDER=1 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>이름</B></TD>
						<TD WIDTH=400>${loginUser.userid}
					   </TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>제목</B></TD>
						<TD WIDTH=400><INPUT TYPE=TEXT NAME="subject" SIZE=70
							style="ime-mode: inactive" VALUE='<%=subject%>'></TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>내용</B></TD>
						<TD WIDTH=400><TEXTAREA NAME="content" COLS=90 ROWS=5><%=content%></TEXTAREA>
						</TD>
					</TR>
					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>첨부파일</B></TD>
						<TD WIDTH=400>
							<%
								if (filename == null) {
										out.println("첨부된 파일이 없습니다");
									} else {
										String IMGURL = "../images/btn_filedown.gif";
										out.println("<IMG ALIGN=ABSMIDDLE SRC=" + IMGURL + ">");
							%> <A HREF="filedownload.jsp?filename=<%=filename%>"> <%=filename%>
								( <%=filesize%> Kbyte)
						</A> <%
 	}
 %>
						</TD>
					</TR>
					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>새첨부파일</B></TD>
						<TD WIDTH=400><INPUT TYPE=FILE NAME="filename" SIZE=50>&nbsp;
						</TD>
					</TR>

					<TR>
						<TD WIDTH=160 ALIGN=CENTER><B>패스워드</B></TD>
						<TD WIDTH=400><INPUT TYPE=PASSWORD NAME="pass" SIZE=20>
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

			<TABLE WIDTH=560 HEIGHT=50 BORDER=0 CELLSPACING=1 CELLPADDING=1
				ALIGN=CENTER>

				<TR ALIGN=CENTER>
					<TD>
						<a onClick="javascript:CheckForm(BoardModify)"
						class="board-btn" STYLE="CURSOR: HAND">수정</a>
						<a href="BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>"
						class="board-btn" STYLE="CURSOR: HAND">취소</a>
					</TD>
				</TR>

			</TABLE>
		</section>
	</div>
</BODY>
</HTML>