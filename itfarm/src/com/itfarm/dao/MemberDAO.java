package com.itfarm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.itfarm.dto.MemberVO;
import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

//회원 정보를 처리하는 DAO
public class MemberDAO {
	private MemberDAO() {
	}

	private static MemberDAO instance = new MemberDAO();

	public static MemberDAO getInstance() {
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

	// 사용자 인증 시 사용되는 메소드. 아이디 존재시 -1, 존재X시 0, 모두 일치시 1
	public int userCheck(String userid, String pwd) {
		int result = -1;
		String sql = "select pwd, isAdmin from members where userid=? and status=1";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString("pwd") != null && rs.getString("pwd").equals(pwd)) {
					if (rs.getInt("isAdmin") == 1) {
						result = 2;
					} else {
						result = 1;
					}

				} else {
					result = 0;
				}
			} else {
				result = -1;
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
		return result;
	}

	// members 테이블에서 아이디로 해당 회원을 찾아 회원 정보를 가져오는 메소드
	public MemberVO getMember(String userid) {
		MemberVO mVo = null;
		String sql = "select * from members where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {

				// 이메일을 @ 기준으로 자른다.
				String mail = rs.getString("email");
				String email1 = mail.split("@")[0];
				String email2 = mail.split("@")[1];

				// 휴대전화를 - 기준으로 자른다.
				String ph = rs.getString("phone");
				String phone1 = ph.split("-")[0];
				String phone2 = ph.split("-")[1];
				String phone3 = ph.split("-")[2];

				mVo = new MemberVO();
				mVo.setName(rs.getString("name"));
				mVo.setUserid(rs.getString("userid"));
				mVo.setPwd(rs.getString("pwd"));
				mVo.setEmail1(email1);
				mVo.setEmail2(email2);
				mVo.setPhone1(phone1);
				mVo.setPhone2(phone2);
				mVo.setPhone3(phone3);
				mVo.setZipNo(rs.getString("zipNo"));
				mVo.setRoadAddr(rs.getString("roadAddr"));
				mVo.setAddrDetail(rs.getString("addrDetail"));
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
		return mVo;
	}

	// members 테이블에서 아이디로 해당 회원을 찾아 회원 정보를 가져오는 메소드
	public int isAdmin(String userid) {
		int result = 0;
		String sql = "select * from members where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			if (rs.getInt("isAdmin") == 1) {
				result = 1;

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
		return result;
	}

	// 회원 가입 시 아이디 중복을 확인 할 때 사용. 해당 아이디가 있으면 1, 없으면 -1 리턴
	public int confirmID(String userid) {
		int result = -1;
		String sql = "select userid from members where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = 1;
			} else {
				result = -1;
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
		return result;
	}

	// 매개변수로 받은 VO 객체 내의 아이디로 members 테이블에서 검색해서 VO 객체에 저장된 정보로 회원정보를 수정.
	public int insertMember(MemberVO mVo) {
		int result = -1;
		String sql = "insert into members(name, userid, pwd, email, phone, roadAddr, addrDetail, zipNo, regDate)"
				+ " values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			Date today = new Date();
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");

			pstmt.setString(1, mVo.getName());
			pstmt.setString(2, mVo.getUserid());
			pstmt.setString(3, mVo.getPwd());
			pstmt.setString(4, mVo.getEmail1() + "@" + mVo.getEmail2());
			pstmt.setString(5, mVo.getPhone1() + "-" + mVo.getPhone2() + "-" + mVo.getPhone3());
			pstmt.setString(6, mVo.getRoadAddr());
			pstmt.setString(7, mVo.getAddrDetail());
			pstmt.setString(8, mVo.getZipNo());
			pstmt.setString(9, date.format(today));

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

	// 매개 변수로 받은 VO 객체 내의 아이디로 members 테이블에서 검색해서 VO 객체에 저장된 정보로 회원 정보를 수정.
	public int updateMember(MemberVO mVo) {
		int result = -1;
		String sql = "update members set email=?," + "phone=?, roadAddr=?, addrDetail=?, zipNo=? where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mVo.getEmail1() + "@" + mVo.getEmail2());
			pstmt.setString(2, mVo.getPhone1() + "-" + mVo.getPhone2() + "-" + mVo.getPhone3());
			pstmt.setString(3, mVo.getRoadAddr());
			pstmt.setString(4, mVo.getAddrDetail());
			pstmt.setString(5, mVo.getZipNo());
			pstmt.setString(6, mVo.getUserid());
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

	// 매개 변수로 받은 VO 객체 내의 아이디로 members 테이블에서 검색해서 VO 객체에 저장된 정보로 회원 정보를 수정.
	public int passUpdate(MemberVO mVo) {
		int result = -1;
		String sql = "update members set pwd=? where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mVo.getPwd());
			pstmt.setString(2, mVo.getUserid());
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

	// 회원 탈퇴 처리(deletePro.jsp)에서 회원 정보를 삭제하는 메소드
	public boolean deleteMember(String userid, String pwd) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update members set" + " email = '', phone = '', roadAddr = '', addrDetail = '',"
				+ "zipNo = 0, pwd = '', status=2" + " where userid=? and pwd=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, pwd);
			int x = pstmt.executeUpdate();
			return x == 1;
		} catch (Exception ex) {
			ex.printStackTrace();
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
		return false;
	}

	// 아이디 찾는 메소드
	public String findID(String name, String phone1, String phone2, String phone3) {
		// MemberVO mVo = null;
		String result = "";
		String sql = "select userid from members where name=? and phone=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone1 + "-" + phone2 + "-" + phone3);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = "고객님의 아이디는 " + rs.getString("userid") + "입니다.";
				System.out.println(result);
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
		System.out.println("dao" + result);
		return result;
	}

	// 관리자 회원 조회
	public List<MemberVO> selectAllMembers(String name, String userid, int status) {
		String sql = "select * from members where 1=1";
		String whereQuery = "";
		List<MemberVO> list = new ArrayList<MemberVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (name != null) {
			whereQuery += " and name like" + " '%" + name + "%'";
		}
		if (userid != null) {
			whereQuery += " and userid like" + " '%" + userid + "%'";
		}
		if (status == 1) {
			whereQuery += " and status=1";
		}
		if (status == 2) {
			whereQuery += " and status=2";
		}
		whereQuery += " order by regDate desc";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberVO mVo = new MemberVO();
				mVo.setName(rs.getString("name"));
				mVo.setUserid(rs.getString("userid"));
				mVo.setPwd(rs.getString("pwd"));
				mVo.setEmail1(rs.getString("email"));
				mVo.setPhone1(rs.getString("phone"));
				mVo.setRoadAddr(rs.getString("roadAddr"));
				mVo.setAddrDetail(rs.getString("addrDetail"));
				mVo.setZipNo(rs.getString("zipNo"));
				mVo.setRegDate(rs.getString("regDate"));

				list.add(mVo);
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

	// 관리자 회원 삭제
	public int adminDeleteMember(String userid) {
		int result = -1;
		String sql = "update members set" + " email = '', phone = '', roadAddr = '',"
				+ " addrDetail = '', zipNo = 0, pwd = '', status=2 where userid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
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

	// 관리자 월별 가입자수 통계 (구글차트 api)
	public Map<String, Object> getAnnualCount(String yyyy, int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			String sql = "select \r\n" + "SUM(IF(DATE_FORMAT(regDate, '%m') = '01', 1, 0)) as member_01,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '02', 1, 0)) as member_02,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '03', 1, 0)) as member_03,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '04', 1, 0)) as member_04,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '05', 1, 0)) as member_05,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '06', 1, 0)) as member_06,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '07', 1, 0)) as member_07,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '08', 1, 0)) as member_08,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '09', 1, 0)) as member_09,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '10', 1, 0)) as member_10,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '11', 1, 0)) as member_11,\r\n"
					+ "SUM(IF(DATE_FORMAT(regDate, '%m') = '12', 1, 0)) as member_12\r\n" + "from members\r\n"
					+ "where DATE_FORMAT(regDate, '%Y') = ?";

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
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, yyyy);
				rs = pstmt.executeQuery();
				System.out.println(rs);
				if (rs.next()) {
					result.put("member_01", rs.getLong("member_01"));
					result.put("member_02", rs.getLong("member_02"));
					result.put("member_03", rs.getLong("member_03"));
					result.put("member_04", rs.getLong("member_04"));
					result.put("member_05", rs.getLong("member_05"));
					result.put("member_06", rs.getLong("member_06"));
					result.put("member_07", rs.getLong("member_07"));
					result.put("member_08", rs.getLong("member_08"));
					result.put("member_09", rs.getLong("member_09"));
					result.put("member_10", rs.getLong("member_10"));
					result.put("member_11", rs.getLong("member_11"));
					result.put("member_12", rs.getLong("member_12"));
				} else {
					result.put("member_01", 0L);
					result.put("member_02", 0L);
					result.put("member_03", 0L);
					result.put("member_04", 0L);
					result.put("member_05", 0L);
					result.put("member_06", 0L);
					result.put("member_07", 0L);
					result.put("member_08", 0L);
					result.put("member_09", 0L);
					result.put("member_10", 0L);
					result.put("member_11", 0L);
					result.put("member_12", 0L);
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

	// 관리자 주별 회원 통계 (구글차트 api)
	public Map<String, Object> getWeakCount(String week, int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select \r\n"
					+ "DATE_FORMAT(DATE_SUB(regDate, INTERVAL (DAYOFWEEK(regDate)-1) DAY), '%Y/%m/%d') as start, \r\n"
					+ "DATE_FORMAT(DATE_SUB(regDate, INTERVAL (DAYOFWEEK(regDate)-7) DAY), '%Y/%m/%d') as end,\r\n"
					+ "DATE_FORMAT(regDate, '%Y%U') AS `date`,\r\n" + "sum(1) as cnt \r\n" + "from members where 1=1";

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
					if (rs.getString("cnt") == null) {
						result.put("member_0" + x, 0L);
					} else {
						result.put("member_0" + x, rs.getLong("cnt"));
					}
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

	// 관리자 일별 회원 통계 (구글차트 api)
	public Map<String, String> getDayCount(String week, int status, String startDate, String endDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select" + " date(regDate) as date," + " sum(1) as cnt" + " from members where 1=1 "
					+ " and date(regDate) >= STR_TO_DATE(?, '%Y%m%d')"
					+ " and date(regDate) <= STR_TO_DATE(?, '%Y%m%d')";

			String whereQuery = "";
			Map<String, String> result = new LinkedHashMap<String, String>();

			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and status=1";
			}
			if (status == 2) {
				whereQuery += " and status=2";
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
					if (rs.getString("cnt") != null) {
						result.put(rs.getString("date"), rs.getString("cnt"));
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

	// 관리자 지역별 가입자수 통계 (구글차트 api)
	public Map<String, Object> getAddrCount(String yyyy) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			String sql = "select  \r\n" + "SUM(IF(roadAddr like '서울특별시%', 1, 0)) as member_01,"
					+ "SUM(IF(roadAddr like '부산광역시%', 1, 0)) as member_02,"
					+ "SUM(IF(roadAddr like '대구광역시%', 1, 0)) as member_03,"
					+ "SUM(IF(roadAddr like '인천광역시%', 1, 0)) as member_04,"
					+ "SUM(IF(roadAddr like '광주광역시%', 1, 0)) as member_05,"
					+ "SUM(IF(roadAddr like '대전광역시%', 1, 0)) as member_06,"
					+ "SUM(IF(roadAddr like '울산광역시%', 1, 0)) as member_07,"
					+ "SUM(IF(roadAddr like '세종특별자치시%', 1, 0)) as member_08,"
					+ "SUM(IF(roadAddr like '경기도%', 1, 0)) as member_09,"
					+ "SUM(IF(roadAddr like '강원도%', 1, 0)) as member_10,"
					+ "SUM(IF(roadAddr like '경상남도%', 1, 0)) as member_11,"
					+ "SUM(IF(roadAddr like '경상북도%', 1, 0)) as member_12,"
					+ "SUM(IF(roadAddr like '충청남도%', 1, 0)) as member_13,"
					+ "SUM(IF(roadAddr like '전라남도%', 1, 0)) as member_14,"
					+ "SUM(IF(roadAddr like '전라북도%', 1, 0)) as member_15,"
					+ "SUM(IF(roadAddr like '충청북도%', 1, 0)) as member_16,"
					+ "SUM(IF(roadAddr like '제주특별자치도%', 1, 0)) as member_17" + " from members\r\n"
					+ "where DATE_FORMAT(regDate, '%Y') = 2018 and status = 1";

			Map<String, Object> result = new HashMap<String, Object>();
			conn = this.getConnection();
			try {
				pstmt = conn.prepareStatement(sql);
				// pstmt.setString(1, yyyy);
				rs = pstmt.executeQuery();
				System.out.println(rs);
				if (rs.next()) {
					result.put("member_01", rs.getLong("member_01"));
					result.put("member_02", rs.getLong("member_02"));
					result.put("member_03", rs.getLong("member_03"));
					result.put("member_04", rs.getLong("member_04"));
					result.put("member_05", rs.getLong("member_05"));
					result.put("member_06", rs.getLong("member_06"));
					result.put("member_07", rs.getLong("member_07"));
					result.put("member_08", rs.getLong("member_08"));
					result.put("member_09", rs.getLong("member_09"));
					result.put("member_10", rs.getLong("member_10"));
					result.put("member_11", rs.getLong("member_11"));
					result.put("member_12", rs.getLong("member_12"));
					result.put("member_13", rs.getLong("member_13"));
					result.put("member_14", rs.getLong("member_14"));
					result.put("member_15", rs.getLong("member_15"));
					result.put("member_16", rs.getLong("member_16"));
					result.put("member_17", rs.getLong("member_17"));
				} else {
					result.put("member_01", 0L);
					result.put("member_02", 0L);
					result.put("member_03", 0L);
					result.put("member_04", 0L);
					result.put("member_05", 0L);
					result.put("member_06", 0L);
					result.put("member_07", 0L);
					result.put("member_08", 0L);
					result.put("member_09", 0L);
					result.put("member_10", 0L);
					result.put("member_11", 0L);
					result.put("member_12", 0L);
					result.put("member_13", 0L);
					result.put("member_14", 0L);
					result.put("member_15", 0L);
					result.put("member_16", 0L);
					result.put("member_17", 0L);
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

	// 관리자 메인 회원
	public String getMemberCount() {
		String sql = "SELECT count(*) as cnt FROM members WHERE 1=1 and date_format(regDate, '%m') = '11' and status = 1";
		String whereQuery = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		sql += whereQuery;
		String mem = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				mem = rs.getString("cnt");
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
		return mem;
	}

}
