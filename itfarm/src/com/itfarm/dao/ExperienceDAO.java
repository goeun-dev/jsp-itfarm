package com.itfarm.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.itfarm.dto.ReservationVO;
import com.itfarm.dto.SaleVO;
import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class ExperienceDAO {

	public ExperienceDAO() {
		// TODO Auto-generated constructor stub
	}

	private static ExperienceDAO instance = new ExperienceDAO();

	public static ExperienceDAO getInstance() {
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

	// 예약 메소드
	public int reservationExp(ReservationVO rvnVO) {
		int result = -1;
		String sql = "insert into reservationPay (rDate, payment, member, prodcode, adultNum, eDate, childNum, price, expName, imgPath, status) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, rvnVO.getrDate());
			pstmt.setInt(2, rvnVO.getPayment());
			pstmt.setString(3, rvnVO.getUserid());
			pstmt.setString(4, rvnVO.getProdcode());
			pstmt.setInt(5, rvnVO.getAdultNum());
			pstmt.setString(6, rvnVO.geteDate());
			pstmt.setInt(7, rvnVO.getChildNum());
			pstmt.setString(8, rvnVO.getPrice());
			pstmt.setString(9, rvnVO.getExpName());
			pstmt.setString(10, rvnVO.getImgPath());

			result = pstmt.executeUpdate();
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
		return result;
	}

	// 예약내역 전체 출력
	public List<ReservationVO> selectAllRsrvs(String userid, String expName, int status) {
		String sql = "select * from reservationPay where 1=1";
		String whereQuery = "";
		List<ReservationVO> list = new ArrayList<ReservationVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (userid != "") {
			whereQuery += " and member like '%" + userid + "%'";
		}
		if (expName != "") {
			whereQuery += " and expName like '%" + expName + "%'";
		}
		if (status == 1) {
			whereQuery += " and status = 1";
		}
		if (status == 2) {
			whereQuery += " and status = 2";
		}

		whereQuery += " order by rDate desc, id desc";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationVO eVo = new ReservationVO();
				eVo.setExpid(rs.getInt("id"));
				eVo.setAdultNum(rs.getInt("adultNum"));
				eVo.setChildNum(rs.getInt("childNum"));
				eVo.setrDate(rs.getString("rDate"));
				eVo.seteDate(rs.getString("eDate"));
				eVo.setPrice(rs.getString("price"));
				eVo.setProdcode(rs.getString("prodcode"));
				eVo.setExpName(rs.getString("expName"));
				eVo.setImgPath(rs.getString("imgPath"));
				eVo.setUserid(rs.getString("member"));
				eVo.setPayment(rs.getInt("payment"));
				eVo.setStatus(rs.getInt("status"));
				list.add(eVo);
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

	// 예약상세
	public ReservationVO selectOneReservationByNum(int id) {
		String sql = "select reservationPay.id, reservationPay.rDate, reservationPay.eDate, reservationPay.adultNum, reservationPay.childNum, "
				+ "reservationPay.price, reservationPay.prodcode, reservationPay.member, reservationPay.expName, reservationPay.imgPath, payment.name from"
				+ " reservationPay join payment on reservationPay.payment = payment.id where reservationPay.id=?";
		ReservationVO eVo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				eVo = new ReservationVO();
				eVo.setExpid(rs.getInt("id"));
				eVo.setAdultNum(rs.getInt("adultNum"));
				eVo.setChildNum(rs.getInt("childNum"));
				eVo.setrDate(rs.getString("rDate"));
				eVo.seteDate(rs.getString("eDate"));
				eVo.setPrice(rs.getString("price"));
				eVo.setProdcode(rs.getString("prodcode"));
				eVo.setPaymentName(rs.getString("payment.name"));
				eVo.setExpName(rs.getString("expName"));
				eVo.setImgPath(rs.getString("imgPath"));
				eVo.setUserid(rs.getString("reservationPay.member"));
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
		return eVo;
	}

	// 예약 인원수 제약
	public List<ReservationVO> reservationNum(String prodCode, int intStdCnt) {
		String sql = "select prodcode, eDate, sum(adultNum), sum(childNum)" + " from reservationPay where 1=1";
		String whereQuery = "";
		List<ReservationVO> list = new ArrayList<ReservationVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		if (prodCode != "") {
			whereQuery += " and prodcode='" + prodCode + "'";
		}
		whereQuery += " and status=1";
		whereQuery += " group by eDate";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationVO eVo = new ReservationVO();
				eVo.setAdultNum(rs.getInt("sum(adultNum)") + rs.getInt("sum(childNum)"));
				eVo.seteDate(rs.getString("eDate"));
				eVo.setProdcode(rs.getString("prodcode"));
				list.add(eVo);
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

	// 예약 취소
	public void refundReservation(String id, int status) {
		String sql = "update reservationPay set status=? where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, id);
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

	// -------------------------------------------------------------------------------

	// 관리자 예약 리스트
	public List<ReservationVO> selectAllRsrvs() {
		String sql = "select * from reservationPay";
		List<ReservationVO> list = new ArrayList<ReservationVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationVO eVo = new ReservationVO();
				eVo.setExpid(rs.getInt("id"));
				eVo.setAdultNum(rs.getInt("adultNum"));
				eVo.setChildNum(rs.getInt("childNum"));
				eVo.setrDate(rs.getString("rDate"));
				eVo.seteDate(rs.getString("eDate"));
				eVo.setPrice(rs.getString("price"));
				eVo.setProdcode(rs.getString("prodcode"));
				eVo.setExpName(rs.getString("expName"));
				eVo.setImgPath(rs.getString("imgPath"));
				eVo.setPayment(rs.getInt("payment"));
				System.out.println(rs.getString("expName"));
				list.add(eVo);
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

	// 관리자 예약 수정
	public void updateReservation(ReservationVO rVo) {
		String sql = "update reservationPay set adultNum=?, childNum=?, eDate=?, price=? where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rVo.getAdultNum());
			pstmt.setInt(2, rVo.getChildNum());
			pstmt.setString(3, rVo.geteDate());
			pstmt.setString(4, rVo.getPrice());
			pstmt.setInt(5, rVo.getExpid());

			pstmt.executeUpdate();// 쿼리문 실행한다.
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

	// 관리자 예약내역 조회
	public List<ReservationVO> adminSelectRsrvs(String userid, String expName, String status, String payment) {
		String sql = "select * from reservationPay where 1=1";
		String whereQuery = "";
		List<ReservationVO> list = new ArrayList<ReservationVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (userid != "" || userid != null) {
			whereQuery += " and member like '%" + userid + "%'";
		}
		if (expName != "") {
			whereQuery += " and expName like '%" + expName + "%'";
		}
		if (status != "") {
			whereQuery += " and status " + "in(" + status + ")";
		}
		if (payment != "") {
			whereQuery += " and payment " + "in(" + payment + ")";
		}

		whereQuery += " order by rDate desc, id desc";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			// pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ReservationVO eVo = new ReservationVO();
				eVo.setExpid(rs.getInt("id"));
				eVo.setAdultNum(rs.getInt("adultNum"));
				eVo.setChildNum(rs.getInt("childNum"));
				eVo.setrDate(rs.getString("rDate"));
				eVo.seteDate(rs.getString("eDate"));
				eVo.setPrice(rs.getString("price"));
				eVo.setProdcode(rs.getString("prodcode"));
				eVo.setExpName(rs.getString("expName"));
				eVo.setImgPath(rs.getString("imgPath"));
				eVo.setUserid(rs.getString("member"));
				eVo.setPayment(rs.getInt("payment"));
				list.add(eVo);
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

	// 관리자 예약 취소
	public void deleteReservation(int expid) {
		String sql = "update reservationPay set status=2 where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, expid);
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

	// 관리자
	// 예약내역 전체 출력
		public List<ReservationVO> adminSelectAllRsrvs(String userid, String expName, String status, String payment, String startDate, String endDate) {
			String sql = "select * from reservationPay where 1=1";
			String whereQuery = "";
			List<ReservationVO> list = new ArrayList<ReservationVO>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			if (userid != "" && userid != null) {
				whereQuery += " and member like '%" + userid + "%'";
			}
			if (expName != "" && expName != null) {
				whereQuery += " and expName like '%" + expName + "%'";
			}
			if (status != "" && status != null) {
				whereQuery += " and status IN" + "(" + status + "9)";
			}
			
			if (payment != "" && payment != null) {
				whereQuery += " and payment IN" + "(" + payment + "9)";
			}
			if (startDate != null && startDate != "") {
				whereQuery += " and rDate between '" +startDate+ "' and '" + endDate + "'";
			}

			whereQuery += " order by rDate desc, id desc";
			sql += whereQuery;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				// pstmt.setString(1, userid);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ReservationVO eVo = new ReservationVO();
					eVo.setExpid(rs.getInt("id"));
					eVo.setAdultNum(rs.getInt("adultNum"));
					eVo.setChildNum(rs.getInt("childNum"));
					eVo.setrDate(rs.getString("rDate"));
					eVo.seteDate(rs.getString("eDate"));
					eVo.setPrice(rs.getString("price"));
					eVo.setProdcode(rs.getString("prodcode"));
					eVo.setExpName(rs.getString("expName"));
					eVo.setImgPath(rs.getString("imgPath"));
					eVo.setUserid(rs.getString("member"));
					eVo.setPayment(rs.getInt("payment"));
					eVo.setStatus(rs.getInt("status"));
					list.add(eVo);
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
	// 통계------------------------------------------------------------------------
	// 관리자 월별 매출 통계 (구글차트 api)
	public Map<String, Object> getAnnualRevenue(String yyyy, int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			String sql = "select \r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '01', price, 0)) as reserv_price_01,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '02', price, 0)) as reserv_price_02,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '03', price, 0)) as reserv_price_03,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '04', price, 0)) as reserv_price_04,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '05', price, 0)) as reserv_price_05,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '06', price, 0)) as reserv_price_06,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '07', price, 0)) as reserv_price_07,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '08', price, 0)) as reserv_price_08,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '09', price, 0)) as reserv_price_09,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '10', price, 0)) as reserv_price_10,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '11', price, 0)) as reserv_price_11,\r\n"
					+ "SUM(IF(DATE_FORMAT(rDate, '%m') = '12', price, 0)) as reserv_price_12\r\n"
					+ "from reservationPay \r\n" + "where DATE_FORMAT(rDate, '%Y') = '2018'";

			String whereQuery = "";
			Map<String, Object> result = new HashMap<String, Object>();
			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and status = 1";
			}
			if (status == 2) {
				whereQuery += " and status = 2";
			}
			sql += whereQuery;
			System.out.println(sql);
			try {
				pstmt = conn.prepareStatement(sql);
				// pstmt.setString(1, yyyy);
				rs = pstmt.executeQuery();
				System.out.println(rs);
				if (rs.next()) {
					result.put("reserv_price_01", rs.getLong("reserv_price_01"));
					result.put("reserv_price_02", rs.getLong("reserv_price_02"));
					result.put("reserv_price_03", rs.getLong("reserv_price_03"));
					result.put("reserv_price_04", rs.getLong("reserv_price_04"));
					result.put("reserv_price_05", rs.getLong("reserv_price_05"));
					result.put("reserv_price_06", rs.getLong("reserv_price_06"));
					result.put("reserv_price_07", rs.getLong("reserv_price_07"));
					result.put("reserv_price_08", rs.getLong("reserv_price_08"));
					result.put("reserv_price_09", rs.getLong("reserv_price_09"));
					result.put("reserv_price_10", rs.getLong("reserv_price_10"));
					result.put("reserv_price_11", rs.getLong("reserv_price_11"));
					result.put("reserv_price_12", rs.getLong("reserv_price_12"));
				} else {
					result.put("reserv_price_01", 0L);
					result.put("reserv_price_02", 0L);
					result.put("reserv_price_03", 0L);
					result.put("reserv_price_04", 0L);
					result.put("reserv_price_05", 0L);
					result.put("reserv_price_06", 0L);
					result.put("reserv_price_07", 0L);
					result.put("reserv_price_08", 0L);
					result.put("reserv_price_09", 0L);
					result.put("reserv_price_10", 0L);
					result.put("reserv_price_11", 0L);
					result.put("reserv_price_12", 0L);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return result;
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
	}

	// 관리자 주별 매출 통계 (구글차트 api)
	public Map<String, Object> getWeakRevenue(String week, int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select \r\n"
					+ "DATE_FORMAT(DATE_SUB(rDate, INTERVAL (DAYOFWEEK(rDate)-1) DAY), '%Y/%m/%d') as start, \r\n"
					+ "DATE_FORMAT(DATE_SUB(rDate, INTERVAL (DAYOFWEEK(rDate)-7) DAY), '%Y/%m/%d') as end,\r\n"
					+ "DATE_FORMAT(rDate, '%Y%U') AS `date`,\r\n"
					+ "sum(price) as reservPrice \r\n" + "from reservationPay where 1=1";

			String whereQuery = "";
			Map<String, Object> result = new HashMap<String, Object>();

			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and status = 1";
			}
			if (status == 2) {
				whereQuery += " and status = 2";
			}
			whereQuery += " group by date limit ?";
			sql += whereQuery;
			System.out.println(sql);
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, Integer.parseInt(week));
				rs = pstmt.executeQuery();
				System.out.println(rs);
				int x = 0;
				while (rs.next()) {
					x += 1;
					result.put("order_price_0" + x, rs.getLong("reservPrice"));

				} /*
					 * else { // ???????????????? result.put("order_price_0"+x, 0L); }
					 */
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return result;
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
	}

	// 관리자 일별 매출 통계 (구글차트 api)
	public Map<String, String> getDayRevenue(String week, int status, String startDate, String endDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select" + " date(rDate) as date,"
					+ " sum(price) as reservPrice" + " from reservationPay"
					+ " where 1=1 "
					+ " and date(rDate) >= STR_TO_DATE(?, '%Y%m%d')"
					+ " and date(rDate) <= STR_TO_DATE(?, '%Y%m%d')";

			String whereQuery = "";
			Map<String, String> result = new LinkedHashMap<String, String>();

			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and status = 1";
			}
			if (status == 2) {
				whereQuery += " and status = 2";
			}
			whereQuery += " group by date order by date desc";
			sql += whereQuery;
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, startDate);
				pstmt.setString(2, endDate);
				rs = pstmt.executeQuery();
				int x = 0;
				while (rs.next()) {
					x += 1;
					if (rs.getString("reservPrice") != null) {
						result.put(rs.getString("date"), rs.getString("reservPrice"));
					} else {
						result.put(rs.getString("date"), "0");
					}

				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return result;
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
	}
	
	// 관리자 상품 매출 순위
		public List<ReservationVO> expRanking() {
			String sql = "select prodcode, expName, sum(1) as total from reservationPay"
					+ " where 1=1 and status = 1 group by"
					+ " prodcode order by total desc limit 10";

			String whereQuery = "";
			List<ReservationVO> list = new ArrayList<ReservationVO>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			sql += whereQuery;
			try {
				conn = getConnection();
				pstmt = (PreparedStatement) conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					ReservationVO rVo = new ReservationVO();
					rVo.setExpName(rs.getString("expName"));
					rVo.setExpid(rs.getInt("total"));
					
					list.add(rVo);
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
		public List<ReservationVO> adminMainMonthRsrv(int status) {
			String sql = "SELECT sum(price) as total, count(*) as cnt"
					+ " FROM reservationPay WHERE 1=1 and DATE_FORMAT(rDate, '%m') = '11'";
			String whereQuery = "";
			List<ReservationVO> list = new ArrayList<ReservationVO>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			if (status ==1) {
				whereQuery += " and status = 1";
			}
			if (status ==2) {
				whereQuery += " and status = 2";
			}
			sql += whereQuery;
			try {
				conn = getConnection();
				pstmt = (PreparedStatement) conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					ReservationVO rVo = new ReservationVO();
					rVo.setExpName(rs.getString("cnt"));
					rVo.setPrice(rs.getString("total"));
					
					list.add(rVo);
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
}