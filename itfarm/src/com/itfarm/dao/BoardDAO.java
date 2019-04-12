package com.itfarm.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.itfarm.dto.BoardVO;
import com.itfarm.dto.ProductVO;
import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class BoardDAO {
	private BoardDAO() {
	}

	private static BoardDAO instance = new BoardDAO();

	public static BoardDAO getInstance() {
		return instance;
	}

	// db 커넥션 객체 얻어오는 메소드
	public Connection getConnection() {
		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "";
			String user = "";
			String pw = "";

			conn = DriverManager.getConnection(url, user, pw);
		} catch (ClassNotFoundException e) {
			System.out.println("MySQL exception");
		} catch (MySQLDataException e) {
			System.out.println("MySQLDataException");
		} catch (SQLException e) {
			System.out.println("SQLException");
		}
		return conn;
	}
	
	// 관리자 게시물 조회
	public List<BoardVO> selectAllBoard1() {
		String sql = "select RcdNo,UsrName,UsrSubject,UsrDate,UsrRefer from board1";
		List<BoardVO> list = new ArrayList<BoardVO>();		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardVO bVo = new BoardVO();
				bVo.setRcdNo(rs.getString("RcdNo"));
				bVo.setUsrName(rs.getString("UsrName"));
				bVo.setUsrSubject(rs.getString("UsrSubject"));
				bVo.setUsrDate(rs.getString("UsrDate"));
				bVo.setUsrRefer(rs.getString("UsrRefer"));
				list.add(bVo);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 게시판 상세
	public BoardVO selectOneBoardByNum(String RcdNo) {
		String sql = "select RcdNo, UsrName, UsrSubject, UsrDate, UsrContent, UsrPass from board1 where RcdNo = ?";
		BoardVO bVo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, RcdNo);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bVo = new BoardVO();
				bVo.setRcdNo(rs.getString("RcdNo"));
				bVo.setUsrName(rs.getString("UsrName"));
				bVo.setUsrSubject(rs.getString("UsrSubject"));
				bVo.setUsrDate(rs.getString("UsrDate"));
				bVo.setUsrContent(rs.getString("UsrContent"));
				bVo.setUsrPass(rs.getString("UsrPass"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return bVo;
	}
	
	// 관리자 게시물 삭제
	public void deleteBoard(String RcdNo) {
		String sql = "delete from board1 where RcdNo=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, RcdNo);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
}
