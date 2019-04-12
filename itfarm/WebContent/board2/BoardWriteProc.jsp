<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %> 

<%request.setCharacterEncoding("utf-8");%>

<%
//------------------------------------- 파일의 이름과 크기를 위한 변수 선언
String filename = null;
int filesize = 0;

//-------------------------------- 파일 업로드 폴더의 생성
String saveFolder =  "upload_files";

//------------------------------ MultipartRequest 클래스 생성자의 파라미터 설정
String savefile = "/images/board";
ServletContext scontext = request.getSession().getServletContext();
String realFolder = scontext.getRealPath(savefile);

//ServletContext context = getServletContext();
//String realFolder = context.getRealPath(saveFolder);
//System.out.println(realFolder);
int sizeLimit = 10*1024*1024;
String encType = "utf-8";
DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();

//------------------------ 객체의 선언
Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
//------------------------- JDBC 설정
		String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230029";
		String jdbcId = "216230029";
		String jdbcPw = "lge216230029";

	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);
	
	//-------------------------- MultipartRequest 객체 생성(파일 업로드 발생)
	MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType);
	
	//-------------------------- 업로드되어 서버에 저장된 파일 이름
	filename = multi.getFilesystemName("filename");
	
	//-------------------------- file 객체의 선언과 파일의 크기 추출
	if(filename != null) {
		Enumeration files = multi.getFileNames();
		String fname = (String)files.nextElement();
		File file = multi.getFile(fname);
		filesize = (int)file.length();
	}
	
	//------------------------------- 전송된 데이터의 추출
	String name = multi.getParameter("name");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	String pass = multi.getParameter("pass");
	
	//------------------------------- 새로운 레코드의 RcdNo와 GrpNo 생성
	String Query1 = "SELECT max(RcdNo), max(GrpNo) FROM board2";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(Query1);
	
	rs.next();
	
	int uid = (rs.getInt(1))+1;
	int gid = (rs.getInt(2))+1;
	
	//------------------------------- 기타 입력 데이터 생성
	int refer = 0;
	int level = 0;
	int order = 1;
	
	// Date date = rs2.getDate("UsrDate"); 
	SimpleDateFormat Current = new SimpleDateFormat("yyyy-MM-dd"); 

	Calendar c1 = Calendar.getInstance();

	//String today = Current.format(date);
	String today = Current.format(c1.getTime());
	
	//---------------------------- 입력 질의 수행
	String Query2 = "INSERT INTO board2 (RcdNo, GrpNo, UsrName, UsrSubject, UsrContent, UsrPass, UsrFileName, UsrFileSize, UsrDate, UsrRefer, RcdLevel, RcdOrder) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(Query2);
	pstmt.setInt(1, uid);
	pstmt.setInt(2, gid);
	pstmt.setString(3, name);
	pstmt.setString(4, subject);
	pstmt.setString(5, content);
	pstmt.setString(6, pass);
	pstmt.setString(7, filename);
	pstmt.setInt(8, filesize);
	pstmt.setString(9, today);
	pstmt.setInt(10, refer);
	pstmt.setInt(11, level);
	pstmt.setInt(12, order);
	
	pstmt.executeUpdate();
	
} catch (SQLException e) {
	out.print(e);
	
} finally {

	//---------------------------- 생성된 객체의 제거와 페이지 이동
	if(rs != null) {
		try {
			rs.close();		
		}catch(Exception e) {}
	}
	
	if(pstmt != null) {
		try {
			pstmt.close();	
		}catch(Exception e) {}
	}
	
	if(conn != null) {
		try {
			conn.close();	
		}catch(Exception e) {}
	}
	
	//response.sendRedirect("BoardList.jsp");
	
}
%>

  <script language=javascript>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="BoardList.jsp"; 

</script>


