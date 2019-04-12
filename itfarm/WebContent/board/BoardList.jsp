<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.URLEncoder"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<%
	//---------------------------------- 변수 및 객체 선언

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;

	int TotalRecords = 0;

	//---------------------------------- 페이지 네비게이션에 필요한 변수 지정
	int CurrentPage = 0;
	int Number = 0;
	int TotalPages = 0;
	int TotalPageSets = 0;
	int CurrentPageSet = 0;

	//---------------------------------- 페이지의 크기와 페이지 집합의 크기 지정
	int PageRecords = 10;
	int PageSets = 10;

	//---------------------------------- 페이지 번호 전달이 없을 경우 페이지 번호의 지정
	if (request.getParameter("CurrentPage") == null) {
		CurrentPage = 1;
	} else {
		CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));
	}

	String Query1 = "";
	String Query2 = "";
	String encoded_key = "";

	//---------------------------------- 페이지별 첫 레코드 인덱스 추출
	int FirstRecord = PageRecords * (CurrentPage - 1);

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

	try {
		//------------------------------- JDBC 설정

		String jdbcUrl = "";
		String jdbcId = "";
		String jdbcPw = "";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, jdbcId, jdbcPw);

		//------------------------------- 질의의 생성과 객체의 생성
		if (column.equals("") || key.equals("")) {
			Query1 = "select count(RcdNo) FROM board1";
			Query2 = "select RcdNo, UsrName, UsrSubject,  UsrDate, UsrRefer, RcdLevel FROM board1 ORDER BY GrpNo DESC, RcdOrder ASC LIMIT "
					+ FirstRecord + " , " + PageRecords;
		} else {
			Query1 = "select count(RcdNo) FROM board1 WHERE " + column + " LIKE '%" + key + "%'";
			Query2 = "select RcdNo, UsrName, UsrSubject, UsrDate, UsrRefer, RcdLevel FROM board1 WHERE " + column
					+ " LIKE '%" + key + "%'" + " ORDER BY GrpNo DESC, RcdOrder ASC LIMIT " + FirstRecord
					+ " , " + PageRecords;
		}

		pstmt = conn.prepareStatement(Query1);
		rs1 = pstmt.executeQuery();
		pstmt = conn.prepareStatement(Query2);
		rs2 = pstmt.executeQuery();

		//------------------------------- 전체 레코드 수 추출
		rs1.next();
		TotalRecords = rs1.getInt(1);

		//------------------------------- 페이지별 가상 시작번호 생성
		Number = TotalRecords - (CurrentPage - 1) * PageRecords;
%>

<!DOCTYPE html>
<head>
<meta HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=utf-8" />


<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />

<link rel="stylesheet" href="../assets/css/main.css" />
<link rel="stylesheet" type="text/css" href="../include/style.css" />
<title>ITFARM - 체험후기</title>
<style type="text/css">
section {
	text-align: center;
}
</style>
</head>

<body>
	<jsp:include page="../sub/subHeader.jsp" flush="false" />

	<div class="main">
		<section>
			<h4>체험 후기</h4>
			<p>체험 후기를 남겨주세요.</p>
			<hr><br>

			<table class="blist">
			<thead>
				<TR ALIGN=CENTER>
					<td>번호</td>
					<td>제목</td>
					<td>작성자</td>
					<td>작성일</td>
					<td>조회수</td>
				</tr>
			</thead>

				<%
					//------------------------------- 순환문을 이용한 레코드 출력 시작
						while (rs2.next()) {

							//--------------------------- 필드 데이터 추출과 출력
							int rno = rs2.getInt("RcdNo");
							String name = rs2.getString("UsrName");
							String subject = rs2.getString("UsrSubject");
						
							Date date = rs2.getDate("UsrDate");
							SimpleDateFormat Current = new SimpleDateFormat("yyyy-MM-dd"); 
							String today = Current.format(date);
							
							int refer = rs2.getInt("UsrRefer");
							int level = rs2.getInt("RcdLevel");
				%>
				<tbody class="tbody">
				<tr>
					<td><%=Number%></td>
					<td>
						<%
							// --------------------------- 페이지 인덴테이션 및 이미지 출력
									for (int i = 0; i < level; i++)
										out.println("&nbsp;&nbsp;");
									if (level > 0) {
										String IMGURL = "fas fa-arrow-right";
										out.println("<i class=\"fa fa-arrow-right\"></i>");
									}
									//---------------------------- 긴 제목문자열 처리 

									int max_length = 34;
									int cut_length = max_length - (level);

									if (subject.length() > cut_length) {
										subject = subject.substring(0, cut_length);
										subject = subject + "..";
									}
									// ----------------------------
						%> <A
						HREF="BoardContent.jsp?rno=<%=rno%>&column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>">
							<%=subject%>
					</A> <%
 	//--------------------------- 최근 24시간 이전에 작성된 레코드에 이미지 출력

 			// --------------------------
 %>

					</td>
					<td><%=name%></td>
					<td><%=today%></td>
					<td align="center"><%=refer%></td>
				</tr>

				<%
					//------------------------------- 순환문을 이용한 레코드 출력  종료
							Number--;
						}
				%>
				</tbody>
			</table>


<!-- ==============검색============== -->
			<FORM NAME="BoardSearch" METHOD=POST action="BoardList.jsp">
				<table>
					<tr>
						<td class="blist-c">
						<a href="BoardWrite.jsp?column=<%=column%>&key=<%=encoded_key%>&CurrentPage=<%=CurrentPage%>" class="board-btn"
						 
						 STYLE="CURSOR: HAND">
						 <!-- onClick="javascript:location.replace('')"; -->
						등록
						</a>
						</td>
						<td class="blist-pg">
							<%
								// ---------------------------- 전체 페이지 수, 전체 페이지집합의 수, 현재 페이지집합 번호 추출
									TotalPages = (int) Math.ceil((double) TotalRecords / PageRecords);
									TotalPageSets = (int) Math.ceil((double) TotalPages / PageSets);
									CurrentPageSet = (int) Math.ceil((double) CurrentPage / PageSets);

									//---------------------------- 네비게이션에서 사용할 이미지 지정 
									String bf_block = "../images/btn_bf_block.gif"; //<<
									String bf_page = "../images/btn_bf_page.gif"; // <
									String nxt_page = "../images/btn_nxt_page.gif"; // >
									String nxt_block = "../images/btn_nxt_block.gif"; // >>

									//---------------------------- 이전 페이지 집합으로의 링크 작성
									if (CurrentPageSet > 1) {
										int BeforePageSetLastPage = PageSets * (CurrentPageSet - 1);
										String retUrl = "BoardList.jsp?CurrentPage=" + BeforePageSetLastPage + "&column=" + column + "&key="
												+ encoded_key;

										String click = "javascript:location.replace('" + retUrl + "')";
										out.println("<i class=\"fa fa-angle-double-left\" onClick=" + click + " STYLE=CURSOR:HAND>"+"</i>");
									} else {
										out.println("<i class=\"fa fa-angle-double-left\"></i>");
									}

									//---------------------------- 이전 페이지로의 링트 작성
									if (CurrentPage > 1) {
										int BeforePage = CurrentPage - 1;
										String retUrl = "BoardList.jsp?CurrentPage=" + BeforePage + "&column=" + column + "&key="
												+ encoded_key;

										String click = "javascript:location.replace('" + retUrl + "')";
										out.println("<i class=\"fa fa-angle-left\" onClick=" + click + " STYLE=CURSOR:HAND>"+"</i>");
									} else {
										out.println("<i class=\"fa fa-angle-left\"></i>");
									}

									//---------------------------- 현재 페이지 집합에서 출력할 첫 패이지번호와 마지막 페이지번호 추출
									int FirstPage = PageSets * (CurrentPageSet - 1);
									int LastPage = PageSets * CurrentPageSet;

									if (CurrentPageSet == TotalPageSets) {
										LastPage = TotalPages;
									}

									//---------------------------- 현재 페이지 집합에서 페이지로의 링크 작성
									for (int i = FirstPage + 1; i <= LastPage; i++) {
										if (CurrentPage == i) {
											out.println("<B>" + i + "</B>");
										} else {
											String retUrl = "BoardList.jsp?CurrentPage=" + i + "&column=" + column + "&key=" + encoded_key;
											out.println("<A HREF=" + retUrl + ">" + i + "</A>");
										}
									}

									//---------------------------- 다음 페이지로의 링크 작성
									if (TotalPages > CurrentPage) {
										int NextPage = CurrentPage + 1;
										String retUrl = "BoardList.jsp?CurrentPage=" + NextPage + "&column=" + column + "&key="
												+ encoded_key;

										String click = "javascript:location.replace('" + retUrl + "')";
										out.println("<i class=\"fa fa-angle-right\" onClick=" + click + " STYLE=CURSOR:HAND>"+"</i>");
									} else {
										out.println("<i class=\"fa fa-angle-right\"></i>");
									}

									//---------------------------- 다음 페이지 집합으로의 링크 작성
									if (TotalPageSets > CurrentPageSet) {
										int NextPageSet = PageSets * CurrentPageSet + 1;
										String retUrl = "BoardList.jsp?CurrentPage=" + NextPageSet + "&column=" + column + "&key="
												+ encoded_key;

										String click = "javascript:location.replace('" + retUrl + "')";
										out.println("<i class=\"fa fa-angle-double-right\"> onClick=" + click + " STYLE=CURSOR:HAND>"+"</i>");
									} else {
										out.println("<i class=\"fa fa-angle-double-right\"></i>");
									}
							%>
						</td>
						<td class="blist-sch">
						<select NAME="column" SIZE=1>
								<option VALUE="" selected>선택</option>
								<option VALUE="UsrSubject">제목</option>
								<option VALUE="UsrContent">내용</option>
						</select> 
						<INPUT TYPE=TEXT NAME="key" SIZE=18 MAXLENGTH=20>
						<button onClick="javascript:submit()" class="board-btn"><i class="fa fa-search"></i>검색</button> 
						</td>
					</tr>

				</table>

			</form>
		</section>
	</div>
	
	<jsp:include page="../footer.jsp" flush="false" />
	<%
		} catch (SQLException e) {

			e.printStackTrace();

		} finally {
			//------------------------------- 생성된 객체 제거
			if (rs2 != null) {
				try {
					rs2.close();
				} catch (Exception e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}

			if (rs1 != null) {
				try {
					rs1.close();
				} catch (Exception e) {
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
				}
			}
		}
	%>

</body>
</html>