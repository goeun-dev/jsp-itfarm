<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder"%>

<%request.setCharacterEncoding("utf-8");%>

<%
//---------------------------------- 전달된 레코드 실별자 추출
int rno = Integer.parseInt(request.getParameter("rno"));

//---------------------------------- 전달된 페이지 번호 추출
int CurrentPage = Integer.parseInt(request.getParameter("CurrentPage"));

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

//------------------------MultipartRequest 객체의 파라미터 지정

String realFolder = ""; 

String savefile = "/images/board";
ServletContext scontext = request.getSession().getServletContext();
realFolder = scontext.getRealPath(savefile);

//String saveFolder = "upload_files";
String encType = "utf-8";

//ServletContext context = getServletContext();
//realFolder = context.getRealPath(saveFolder);

int sizeLimit = 10*1024*1024;
MultipartRequest multi = null;

try {
	//------------------------------- JDBC 설정
	
	String jdbcUrl = "jdbc:mysql://128.134.114.237:3306/db216230029";
	String jdbcId = "216230029";
	String jdbcPw = "lge216230029";
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(jdbcUrl,jdbcId,jdbcPw);
	
	//------------------------------- MultipartRequest 객체과 파일 이름 추출
	multi = new MultipartRequest(request, realFolder, sizeLimit, encType, new DefaultFileRenamePolicy());
	String filename = multi.getFilesystemName("filename");
	
	//---------------------------------- 전달된 데이터의 추출
	String mail = multi.getParameter("mail");
	String subject = multi.getParameter("subject");
	String content = multi.getParameter("content");
	String passwd = multi.getParameter("pass");
	
	//------------------------------- 레코드 패스워드 추출
	String Query1 = "SELECT UsrPass, UsrFileName FROM board2 WHERE RcdNo=?";
	pstmt = conn.prepareStatement(Query1);
	pstmt.setInt(1,rno);
	rs = pstmt.executeQuery();
	
	rs.next();
	String dbPass = rs.getString(1);
	String oldFilename = rs.getString(2);
	
	//------------------------------- 패스워드의 비교와 레코드의 삭제
	if(passwd.equals(dbPass)) {
		
		if(filename != null) { 		// ------ 새로운 업로드 파일이 존재하는 경우
						
			if(oldFilename != null) {		// ------ 첨부 파일이 이미 존재하는 경우 제거
				String PathAndName = realFolder + "\\" + oldFilename;
				File file1 = new File(PathAndName);				
				if (!file1.delete()) {
					out.println("파일 삭제에 실패했습니다.");
				}
			}
			
			//------------------------------- 새로 업로드되는 파일의 크기 추출
			Enumeration files = multi.getFileNames();	
			String fname = (String)files.nextElement();
			File file = multi.getFile(fname);		
			int filesize = (int)file.length();	
			
			//------------------------------- 파일정보를 포함한 데이터베이스 갱신
			String Query2 = "UPDATE board2 SET  UsrSubject=?, UsrContent=?, UsrFileName=?, UsrFileSize=? WHERE RcdNo=?";
			pstmt = conn.prepareStatement(Query2);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setString(3, filename);
			pstmt.setInt(4, filesize);
			pstmt.setInt(5, rno);
			
			pstmt.executeUpdate();
					
		} else {
			
			//------------------------------- 파일정보를 포함하지 않은 데이터베이스 갱신
			String Query2 = "UPDATE board2 SET  UsrSubject=?, UsrContent=? WHERE RcdNo=?";
			pstmt = conn.prepareStatement(Query2);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, rno);
			
			pstmt.executeUpdate();
			
		}
		
		//-------------------------------- 객체의 종료와 페이지 이동
		rs.close();
		pstmt.close();
		conn.close();
		String retUrl = "BoardContent.jsp?rno=" + rno + "&column=" + column + "&key=" + encoded_key + "&CurrentPage=" + CurrentPage ;
		response.sendRedirect(retUrl);
		
	} else {
		
		rs.close();
		pstmt.close();
		conn.close();		
		out.println("<script language=\"javascript\">");
		out.println("alert('패스워드가 틀렸습니다.')");
		out.println("history.back()");		
		out.println("</script>");	
		out.flush();
		
	}
	
} catch (SQLException e) {
	
	out.print(e);
	
} 
%>