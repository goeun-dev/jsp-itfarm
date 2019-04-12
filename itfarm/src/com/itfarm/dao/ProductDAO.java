package com.itfarm.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.itfarm.dto.CartVO;
import com.itfarm.dto.ProductVO;
import com.itfarm.dto.SaleVO;
import com.mysql.jdbc.exceptions.jdbc4.MySQLDataException;

public class ProductDAO {

	public ProductDAO() {
		// TODO Auto-generated constructor stub
	}

	private static ProductDAO instance = new ProductDAO();

	public static ProductDAO getInstance() {
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

	// 최근 등록된 상품 전체 출력하는 메소드
	public List<ProductVO> selectAllProducts(String category, int order) {
		String sql = "select * from product where 1=1";
		String sql2 = "select product.id,product.name, product.price, product.productImg, product.category, product.count,"
				+ " sum(1) as total " + "from saleDetail"
				+ " inner join sale on saleDetail.saleId = sale.id "
				+ " inner join product on saleDetail.productId = product.id"
				+ " where 1=1 and deliveryStatus between 1 and 3";
		String whereQuery = "";
		List<ProductVO> list = new ArrayList<ProductVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (category != "") {
			whereQuery += " and product.category like " + category;
		}

		// 1: 신상품, 2: 낮은가격, 3: 높은가격, 4: 인기순
		if (order == 1) {
			whereQuery += " order by product.id desc";
		}
		if (order == 2) {
			whereQuery += " order by product.price asc";
		}
		if (order == 3) {
			whereQuery += " order by product.price desc";
		}
		if (order == 4) {

			whereQuery += " group by saleDetail.productId" + " order by total desc";
			sql2 += whereQuery;
		}

		sql += whereQuery;
		try {
			conn = getConnection();
			if (order == 4) {
				pstmt = (PreparedStatement) conn.prepareStatement(sql2);
			} else {
				pstmt = (PreparedStatement) conn.prepareStatement(sql);
			}

			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductVO pVo = new ProductVO();
				pVo.setCategory(rs.getString("category"));
				pVo.setName(rs.getString("name"));
				pVo.setPrice(rs.getString("price"));
				pVo.setProductImg(rs.getString("productImg"));
				pVo.setProductNum(rs.getString("id"));
				pVo.setCount(rs.getInt("count"));

				list.add(pVo);
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

	// 제품상세
	public ProductVO selectOneProductByNum(String productNum) {
		String sql = "select * from product where id = ?";
		ProductVO pVo = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, productNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pVo = new ProductVO();
				pVo.setProductNum(rs.getString("id"));
				pVo.setName(rs.getString("name"));
				pVo.setCategory(rs.getString("category"));
				pVo.setPrice(rs.getString("price"));
				pVo.setProductImg(rs.getString("productImg"));
				pVo.setProductDtImg(rs.getString("productDtImg"));
				pVo.setCount(rs.getInt("count"));
				pVo.setDescription(rs.getString("description"));
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
		return pVo;
	}

	// 장바구니 메소드
	public int Cart(CartVO cVo) {
		int result = -1;
		String sql = "insert into cart (mid, pid, date, num) values(?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, cVo.getMid());
			pstmt.setInt(2, cVo.getPid());
			pstmt.setString(3, cVo.getDate());
			pstmt.setInt(4, cVo.getNum());

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

	// 장바구니에 상품 확인 할 때 사용. 해당 상품이 있으면 1, 없으면 -1 리턴
	public int confirmCart(String mid, String pid) {
		int result = -1;
		String sql = "select * from cart where mid=? and pid=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, pid);
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

	public List<CartVO> selectAllCarts(String mid, String[] cid) {
		// 최근 등록한 상품 먼저 출력하기
		String sql = "select cart.id, cart.pid, cart.date, cart.num, product.name, product.price, product.productImg, product.count from cart join product on cart.pid = product.id where 1=1";
		String whereQuery = "";
		List<CartVO> list = new ArrayList<CartVO>();
		if (mid != "") {
			whereQuery += " and mid = '" + mid + "'";
		}
		String cids = "";
		if (cid != null) {
			for (int i = 0; i < cid.length; i++) {
				if (i == cid.length - 1) {
					cids += cid[i];
				} else {
					cids += cid[i] + ",";
				}
			}
			whereQuery += " and cart.id " + "in(" + cids + ")";
		}
		sql += whereQuery;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) { // 이동은 행(로우) 단위로
				CartVO cVo = new CartVO();
				cVo.setId(rs.getString("id"));
				cVo.setPid(rs.getInt("pid"));
				cVo.setPname(rs.getString("name"));
				cVo.setPprice(rs.getString("product.price"));
				cVo.setPimg(rs.getString("product.productImg"));
				cVo.setCount(rs.getInt("product.count"));
				cVo.setDate(rs.getString("cart.date"));
				cVo.setNum(rs.getInt("cart.num"));

				list.add(cVo);
			} // while문 끝
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

	// 장바구니 삭제
	public boolean deleteAllCart(String mid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from cart where mid=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.executeUpdate();

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

	// 장바구니 삭제
	public void deleteOneCart(String id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "delete from cart where id=?";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();

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
	}

	public void updateCart(String id, int num) {
		String sql = "update cart set num=? where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, id);
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

	// 제품구매 메소드
	public int ProductSale(SaleVO sVo) {
		int result = -1;
		String sql = "insert into sale (id, payDate, zipNo, roadAddr, addrDetail, userid, payment, deliveryStatus, name, phone) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);

			// sale
			pstmt.setString(1, sVo.getSaleid());
			pstmt.setString(2, sVo.getpDate());
			pstmt.setString(3, sVo.getZipNo());
			pstmt.setString(4, sVo.getRoadAddr());
			pstmt.setString(5, sVo.getAddrDetail());
			pstmt.setString(6, sVo.getUserid());
			pstmt.setInt(7, sVo.getPayment());
			if (sVo.getPayment() == 1) {
				pstmt.setString(8, "0");
			} else {
				pstmt.setString(8, "1");
			}

			pstmt.setString(9, sVo.getName());
			pstmt.setString(10, sVo.getPhone());

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
		System.out.println(result);
		return result;
	}

	// 제품구매 메소드
	public int ProductSaleDetail(SaleVO sVo) {
		int result = -1;
		String sql2 = "insert into saleDetail (num, unitPrice, productId, saleId) values(?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql2);

			// sale detail
			pstmt.setInt(1, sVo.getNum());
			pstmt.setString(2, sVo.getUnitPrice());
			pstmt.setInt(3, sVo.getProdNo());
			pstmt.setString(4, sVo.getSaleid());
			result = pstmt.executeUpdate();
			pstmt.close();
			// 상품수량 조정
			pstmt = conn.prepareStatement("select count from product where id = ?");
			pstmt.setInt(1, sVo.getProdNo());
			rs = pstmt.executeQuery();
			rs.next();

			int nowCount = rs.getInt(1) - sVo.getNum();

			String sql = "update product set count = ? where id = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, nowCount);
			pstmt.setInt(2, sVo.getProdNo());

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
		return result;
	}

	// 주문 전체
	public List<SaleVO> selectAllOrders(String userid, String saleid, int status) {
		String sql = "select sale.id, sale.deliveryStatus, sale.payDate, sale.userid, sale.payment,"
				+ " saleDetail.num, saleDetail.unitPrice, product.productImg, product.name, count(saleDetail.saleId) as cnt,"
				+ " sum(saleDetail.unitPrice * saleDetail.num) as sumprice, orderStatus.name, sale.deliveryDate, payment.name"
				+ " from sale inner join saleDetail on sale.id = saleDetail.saleId "
				+ " inner join product on saleDetail.productId = product.id"
				+ " inner join payment on sale.payment = payment.id"
				+ " inner join orderStatus on sale.deliveryStatus = orderStatus.id" + " where 1=1";

		String whereQuery = "";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		if (userid != "") {
			whereQuery += " and sale.userid='" + userid + "'";
		}
		if (saleid != "") {
			whereQuery += " and sale.userid like" + " '%" + saleid + "%'";
		}
		if (status == 1) {
			whereQuery += " and sale.deliveryStatus IN(0,1,2,3,7)";
		}
		if (status == 2) {
			whereQuery += " and sale.deliveryStatus between 4 and 6 ";
		}
		whereQuery += " group by saleDetail.saleId";
		whereQuery += " order by sale.payDate desc, sale.id desc";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			// pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setSaleid(rs.getString("sale.id"));
				sVo.setDeliveryStatus(rs.getString("sale.deliveryStatus"));
				sVo.setpDate(rs.getString("sale.payDate"));
				sVo.setNum(rs.getInt("saleDetail.num"));
				sVo.setUnitPrice(rs.getString("sumprice"));
				sVo.setName(rs.getString("product.name"));
				sVo.setProductImg(rs.getString("product.productImg"));
				sVo.setCnt(rs.getInt("cnt"));
				sVo.setUserid(rs.getString("sale.userid"));
				sVo.setPayment(rs.getInt("sale.payment"));
				sVo.setMonth(rs.getString("payment.name"));
				sVo.setDelivery(rs.getString("orderStatus.name"));
				sVo.setAddrDetail(rs.getString("sale.deliveryDate"));
				if (rs.getString("sale.deliveryDate") != null) {
					String delDt = rs.getString("sale.deliveryDate");
					String delDt1 = delDt.split("-")[0];
					String delDt2 = delDt.split("-")[1];
					String delDt3 = delDt.split("-")[2];

					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
					Calendar c1 = Calendar.getInstance();
					Calendar c2 = Calendar.getInstance();
					String strToday = sdf.format(c1.getTime());
					c2.set(Integer.parseInt(delDt1), Integer.parseInt(delDt2) - 1, Integer.parseInt(delDt3));
					String str = sdf.format(c2.getTime());
					sVo.setProdNo(Integer.parseInt(strToday) - Integer.parseInt(str));
					System.out.println(strToday);
					System.out.println(str);
				}
				list.add(sVo);
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

	// 주문상세
	public List<SaleVO> selectOrderDetailByNum(String saleid) {
		String sql = "select saleDetail.saleId, saleDetail.num, saleDetail.unitprice, "
				+ " sale.payDate, sale.name, sale.phone, sale.zipNo, sale.roadAddr,"
				+ " sale.addrDetail, sale.payment, sale.account, sale.reason,"
				+ " product.name, product.productImg, saleDetail.productId, " + " payment.name from saleDetail "
				+ " inner join product on saleDetail.productId = product.id "
				+ " inner join sale on saleDetail.saleId = sale.id" + " inner join payment on sale.payment = payment.id"
				+ " where saleId = ?";

		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, saleid);
			rs = pstmt.executeQuery();
			int x = 0;
			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setSaleid(rs.getString("saleDetail.saleId"));
				sVo.setNum(rs.getInt("saleDetail.num"));
				sVo.setUnitPrice(rs.getString("saleDetail.unitprice"));
				sVo.setPname(rs.getString("product.name"));
				sVo.setProductImg(rs.getString("product.productImg"));
				sVo.setpDate(rs.getString("sale.payDate"));
				sVo.setName(rs.getString("sale.name"));
				sVo.setPhone(rs.getString("sale.phone"));
				sVo.setZipNo(rs.getString("sale.zipNo"));
				sVo.setRoadAddr(rs.getString("sale.roadAddr"));
				sVo.setAddrDetail(rs.getString("sale.addrDetail"));
				sVo.setPayment(rs.getInt("sale.payment"));
				sVo.setProdNo(rs.getInt("saleDetail.productId"));
				sVo.setDelivery(rs.getString("payment.name"));
				sVo.setCnt(x);
				sVo.setMonth(rs.getString("sale.account"));
				sVo.setGprice(rs.getString("sale.reason"));
				list.add(sVo);
				x++;
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

	public String deliveryNo(String saleid) {
		String sql = "select * from sale where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dno = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, saleid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dno = rs.getString("deliveryNo");
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
		return dno;
	}

	public void refundOrder(String id, int status, String date) {
		String sql = "";
		if (date == null) {
			sql = "update sale set deliveryStatus=?" + " where id=?";
		} else {
			if (status == 3) {
				sql = "update sale set deliveryStatus=?, deliveryDate=" + "'" + date + "'" + " where id=?";
			}
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			System.out.println(sql);
			System.out.println(pstmt);
			System.out.println(status);
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

	public void updateAccount(String account, String id, String reason) {
		String sql = "";
		sql = "update sale set account=?, reason=?" + " where id=?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, account);
			pstmt.setString(2, reason);
			pstmt.setString(3, id);
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

	public void updateReason(String reason, String id) {
		String sql = "";
		sql = "update sale set reason=?" + " where id=?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, reason);
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

	public void returnOrder(String id, int status, String date) {
		String sql = "";
		if (date == null) {
			sql = "update sale set deliveryStatus=?" + " where id=?";
		} else {
			if (status == 3) {
				sql = "update sale set deliveryStatus=?, deliveryDate=" + "'" + date + "'" + " where id=?";
			}
		}
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

	// 교환 환불할때 주문상세도 취소 되는거
	public void refundProduct(int id, int count) {
		String sql = "update product set count=count+? where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, count);
			pstmt.setInt(2, id);
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

	// 마이페이지 주문 건수
	public List<SaleVO> orderCount(String userid, int delStatus) {
		String sql = "SELECT sum(1) as cnt, orderStatus.name as name FROM sale\r\n"
				+ "inner join orderStatus on sale.deliveryStatus = orderStatus.id\r\n" + "WHERE\r\n"
				+ "userid = ? and deliveryStatus = ?";

		String whereQuery = "";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, delStatus);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setCnt(rs.getInt("cnt"));
				sVo.setDeliveryStatus(rs.getString("name"));

				list.add(sVo);
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

	// -------------------------------------------------------------------------------
	// 관리자 제품 삭제
	public void deleteProduct(int productNum) {
		String sql = "delete from product where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productNum);
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

	// 관리자 제품 등록
	public void insertProduct(ProductVO pVo) {
		String sql = "insert into product(name, category, price, productImg, productDtImg, count, description) values(?, ?, ?, ?, ?, ?, ?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pVo.getName());
			pstmt.setString(2, pVo.getCategory());
			pstmt.setString(3, pVo.getPrice());
			pstmt.setString(4, pVo.getProductImg());
			pstmt.setString(5, pVo.getProductDtImg());
			pstmt.setInt(6, pVo.getCount());
			pstmt.setString(7, pVo.getDescription());
			pstmt.executeUpdate(); // 실행
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

	// 관리자 제품 수정
	public void updateProduct(ProductVO pVo) {
		String sql = "update product set name=?, category=?, price=?, productImg=?, count=?, description=? where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pVo.getName());
			pstmt.setString(2, pVo.getCategory());
			pstmt.setString(3, pVo.getPrice());
			pstmt.setString(4, pVo.getProductImg());
			pstmt.setInt(5, pVo.getCount());
			pstmt.setString(6, pVo.getDescription());
			pstmt.setString(7, pVo.getProductNum());
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

	// 상품 검색 메소드
	public List<ProductVO> searchProduct(String name, String category) {
		String sql = "select * from product where 1=1";
		String whereQuery = "";
		List<ProductVO> list = new ArrayList<ProductVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (name != "") {
			whereQuery += " and name like" + " '%" + name + "%'";
		}
		if (category != "") {
			whereQuery += " and category like " + category;
		}
		sql += whereQuery;
		System.out.println(sql);
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductVO pVo = new ProductVO();
				pVo.setCategory(rs.getString("category"));
				pVo.setName(rs.getString("name"));
				pVo.setPrice(rs.getString("price"));
				pVo.setProductImg(rs.getString("productImg"));
				pVo.setProductNum(rs.getString("id"));
				pVo.setCount(rs.getInt("count"));

				list.add(pVo);
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

	// 관리자 제품 삭제
	public void deleteOrder(String saleid) {
		String sql = "update sale set deliveryStatus=4 where id=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, saleid);
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

	// 관리자 주문 조회 전체
	public List<SaleVO> adminSelectAllOrders(String userid, String payment, String status, String startDate,
			String endDate) {
		String sql = "select sale.id, sale.deliveryStatus, sale.deliveryNo, sale.payDate, sale.userid, sale.payment, saleDetail.num, saleDetail.unitPrice, "
				+ " product.productImg, product.name, count(saleDetail.saleId) as cnt, sum(saleDetail.unitPrice) as sumprice, orderStatus.name"
				+ " from sale inner join saleDetail on sale.id = saleDetail.saleId "
				+ " inner join product on saleDetail.productId = product.id"
				+ " inner join orderStatus on sale.deliveryStatus = orderStatus.id" + " where 1=1";

		String whereQuery = "";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println(userid + payment + startDate + endDate + startDate);

		if (userid != null && userid != "") {
			whereQuery += " and sale.userid like" + " '%" + userid + "%'";
		}

		if (status != "" && status != null) {
			whereQuery += " and sale.deliveryStatus IN" + "(" + status + "9)";
		}

		if (payment != "" && payment != null) {
			whereQuery += " and sale.payment IN" + "(" + payment + "9)";
		}

		if (startDate != null && startDate != "") {
			whereQuery += " and sale.payDate between '" + startDate + "' and '" + endDate + "'";
		}

		whereQuery += " group by saleDetail.saleId";
		whereQuery += " order by sale.payDate desc, sale.id desc";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			// pstmt.setString(1, userid);
			rs = pstmt.executeQuery();

			// int pagenum; // 페이지 번호
			// int pagesize; // 페이지 당 보여질 행 갯수

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setSaleid(rs.getString("sale.id"));
				sVo.setDeliveryStatus(rs.getString("sale.deliveryStatus"));
				sVo.setpDate(rs.getString("sale.payDate"));
				sVo.setNum(rs.getInt("saleDetail.num"));
				sVo.setUnitPrice(rs.getString("sumprice"));
				sVo.setName(rs.getString("product.name"));
				sVo.setProductImg(rs.getString("product.productImg"));
				sVo.setCnt(rs.getInt("cnt"));
				sVo.setUserid(rs.getString("sale.userid"));
				sVo.setDeliveryNo(rs.getString("sale.deliveryNo"));
				sVo.setDelivery(rs.getString("orderStatus.name"));
				sVo.setPayment(rs.getInt("sale.payment"));

				list.add(sVo);
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

	// 운송장 번호 등록 메소드
	public int DeliveryUpdate(String dno, String saleid) {
		int result = -1;
		String sql = "update sale set deliveryNo=?, deliveryStatus=? where id=? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dno);
			pstmt.setInt(2, 2);
			pstmt.setString(3, saleid);

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

	// 관리자 월별 주문량 통계
	public List<SaleVO> orderTotal() {
		String sql = "select date_format(payDate,'%Y-%m') as month, count(*) as total from sale" + " where 1=1";

		String whereQuery = "";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		whereQuery += " group by `month`";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("month"));
				sVo.setTotal(rs.getString("total"));

				list.add(sVo);
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

	// 관리자 월별 주문금액 통계
	public List<SaleVO> orderPrice(int status) {
		String sql = "select date_format(sale.payDate,'%Y-%m') as month, sum(saleDetail.unitprice*saleDetail.num) as total"
				+ " from saleDetail" + " inner join sale on saleDetail.saleId = sale.id" + " where 1=1";

		String whereQuery = "";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		if (status == 1) {
			whereQuery += " and sale.deliveryStatus between 1 and 3";
		}
		if (status == 2) {
			whereQuery += " and sale.deliveryStatus = 4";
		}

		whereQuery += " group by `month`";
		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("month"));
				sVo.setTotal(rs.getString("total"));

				list.add(sVo);
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

	// 관리자 상품 매출 순위
	public List<SaleVO> productRanking() {
		String sql = "select product.name, sum(saleDetail.unitprice*saleDetail.num) as total " + "from saleDetail"
				+ " inner join sale on saleDetail.saleId = sale.id "
				+ " inner join product on saleDetail.productId = product.id"
				+ " where 1=1 and deliveryStatus between 1 and 3" + " group by saleDetail.productId"
				+ " order by total desc limit 5";

		String whereQuery = "";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		sql += whereQuery;
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setTotal(rs.getString("total"));
				sVo.setTitle(rs.getString("product.name"));

				list.add(sVo);
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

	// 관리자 월별 매출 통계 (구글차트 api)
	public Map<String, Object> getAnnualRevenue(String yyyy, int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			String sql = "select \r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '01', saleDetail.unitprice * saleDetail.num, 0)) as order_price_01,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '02', saleDetail.unitprice * saleDetail.num, 0)) as order_price_02,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '03', saleDetail.unitprice * saleDetail.num, 0)) as order_price_03,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '04', saleDetail.unitprice * saleDetail.num, 0)) as order_price_04,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '05', saleDetail.unitprice * saleDetail.num, 0)) as order_price_05,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '06', saleDetail.unitprice * saleDetail.num, 0)) as order_price_06,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '07', saleDetail.unitprice * saleDetail.num, 0)) as order_price_07,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '08', saleDetail.unitprice * saleDetail.num, 0)) as order_price_08,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '09', saleDetail.unitprice * saleDetail.num, 0)) as order_price_09,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '10', saleDetail.unitprice * saleDetail.num, 0)) as order_price_10,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '11', saleDetail.unitprice * saleDetail.num, 0)) as order_price_11,\r\n"
					+ "SUM(IF(DATE_FORMAT(sale.payDate, '%m') = '12', saleDetail.unitprice * saleDetail.num, 0)) as order_price_12\r\n"
					+ "from saleDetail \r\n" + "inner join sale on saleDetail.saleId = sale.id \r\n"
					+ "where DATE_FORMAT(sale.payDate, '%Y') = '2018'";

			String whereQuery = "";
			Map<String, Object> result = new HashMap<String, Object>();
			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and sale.deliveryStatus between 1 and 3";
			}
			if (status == 2) {
				whereQuery += " and sale.deliveryStatus IN(4,6)";
			}
			sql += whereQuery;
			System.out.println(sql);
			try {
				pstmt = conn.prepareStatement(sql);
				// pstmt.setString(1, yyyy);
				rs = pstmt.executeQuery();
				System.out.println(rs);
				if (rs.next()) {
					result.put("order_price_01", rs.getLong("order_price_01"));
					result.put("order_price_02", rs.getLong("order_price_02"));
					result.put("order_price_03", rs.getLong("order_price_03"));
					result.put("order_price_04", rs.getLong("order_price_04"));
					result.put("order_price_05", rs.getLong("order_price_05"));
					result.put("order_price_06", rs.getLong("order_price_06"));
					result.put("order_price_07", rs.getLong("order_price_07"));
					result.put("order_price_08", rs.getLong("order_price_08"));
					result.put("order_price_09", rs.getLong("order_price_09"));
					result.put("order_price_10", rs.getLong("order_price_10"));
					result.put("order_price_11", rs.getLong("order_price_11"));
					result.put("order_price_12", rs.getLong("order_price_12"));
				} else {
					result.put("order_price_01", 0L);
					result.put("order_price_02", 0L);
					result.put("order_price_03", 0L);
					result.put("order_price_04", 0L);
					result.put("order_price_05", 0L);
					result.put("order_price_06", 0L);
					result.put("order_price_07", 0L);
					result.put("order_price_08", 0L);
					result.put("order_price_09", 0L);
					result.put("order_price_10", 0L);
					result.put("order_price_11", 0L);
					result.put("order_price_12", 0L);
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

	// 관리자 월별 매출 통계 (표)
	public List<SaleVO> getAnnualRevenueTable(String yyyy) {
		String sql = "select" + " date_format(sale.payDate,'%Y-%m') as month,"
				+ " sum(saleDetail.unitprice*saleDetail.num) as total,"
				+ " count(date_format(sale.payDate,'%Y-%m')) as cnt,"
				+ " sum(IF(sale.deliveryStatus between 1 and 3, saleDetail.unitprice * saleDetail.num, 0)) as sale,"
				+ " sum(IF(sale.deliveryStatus IN(4,6), saleDetail.unitprice * saleDetail.num, 0)) as refund, " + " sum("
				+ "IF(sale.deliveryStatus between 1 and 3,"
				+ "IF((saleDetail.unitprice * saleDetail.num) >= 70000, saleDetail.unitprice * saleDetail.num, 0), 0)) as delNoSale,\r\n"

				+ " sum(" + "IF(sale.deliveryStatus between 1 and 3,"
				+ "IF((saleDetail.unitprice * saleDetail.num)-2500 < 70000, (saleDetail.unitprice * saleDetail.num)-2500, 0), 0)) as delYesSale,\r\n"
				+ " sum(IF((saleDetail.unitprice * saleDetail.num)-2500 <  70000, 2500, 0)) as delPrice"
				+ "  from saleDetail inner join sale on saleDetail.saleId = sale.id\r\n"
				+ "where DATE_FORMAT(sale.payDate, '%Y') = ?" + "group by month";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, yyyy);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("month"));
				sVo.setTotal(rs.getString("total"));
				sVo.setCnt(rs.getInt("cnt"));
				sVo.setPrice(rs.getString("sale"));
				sVo.setUnitPrice(rs.getString("refund"));
				// 1. 70000 원 이상 주문의 총 금액
				int delNoSale = rs.getInt("delNoSale");
				// 2. 70000 원 미만 주문의 배송비를 제외한 총 금액
				int delYesSale = rs.getInt("delYesSale");
				// 배송비가 붙은 주문의 총 배송비
				sVo.setDelivery(rs.getString("delPrice"));
				// 1과 2의 합계 (배송비를 제외한 순수 주문금액)
				sVo.setNum(delYesSale + delNoSale);
				list.add(sVo);
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

	// 관리자 금월/전월 매출 증감률 비교 (표)
	public List<SaleVO> getRateChange(String yyyyMM, String yyyyMM2) {
		String sql = "select" + " date_format(sale.payDate,'%Y-%m') as month,"
				+ " sum(saleDetail.unitprice*saleDetail.num) as total,"
				+ " sum(IF(sale.deliveryStatus between 1 and 3, saleDetail.unitprice * saleDetail.num, 0)) as sale,"
				+ " sum(IF(sale.deliveryStatus IN(4,6), saleDetail.unitprice * saleDetail.num, 0)) as refund "
				+ " from saleDetail inner join sale on saleDetail.saleId = sale.id"
				+ " where DATE_FORMAT(sale.payDate, '%Y-%m') between ? and ?" + " group by month order by month desc";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, yyyyMM2);
			pstmt.setString(2, yyyyMM);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("month"));
				// 결제금액합계
				sVo.setTotal(rs.getString("total"));
				// 순매출합계
				sVo.setPrice(rs.getString("sale"));
				// 환불합계
				sVo.setUnitPrice(rs.getString("refund"));
				list.add(sVo);
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

	// 관리자 주별 매출 통계 (구글차트 api)
	public Map<String, Object> getWeakRevenue(String week, int status) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select \r\n"
					+ "DATE_FORMAT(DATE_SUB(sale.payDate, INTERVAL (DAYOFWEEK(sale.payDate)-1) DAY), '%Y/%m/%d') as start, \r\n"
					+ "DATE_FORMAT(DATE_SUB(sale.payDate, INTERVAL (DAYOFWEEK(sale.payDate)-7) DAY), '%Y/%m/%d') as end,\r\n"
					+ "DATE_FORMAT(sale.payDate, '%Y%U') AS `date`,\r\n"
					+ "sum(saleDetail.unitPrice*saleDetail.num) as salePrice \r\n" + "from saleDetail \r\n"
					+ "inner join sale on saleDetail.saleId = sale.id\r\n" + "where 1=1";

			String whereQuery = "";
			Map<String, Object> result = new HashMap<String, Object>();

			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and sale.deliveryStatus between 1 and 3";
			}
			if (status == 2) {
				whereQuery += " and sale.deliveryStatus IN(4,6)";
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
					result.put("order_price_0" + x, rs.getLong("salePrice"));

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

	// 관리자 주별 매출 통계 (표)
	public List<SaleVO> getWeekRevenueTable(String yyyy) {
		String sql = "select \r\n" + "date_format(sale.payDate,'%m') as month,"
				+ "floor((date_format(sale.payDate,'%d')+(date_format(date_format(sale.payDate,'%Y%m%01'),'%w')-1))/7)+1 credate,"
				+ "DATE_FORMAT(DATE_SUB(sale.payDate, INTERVAL (DAYOFWEEK(sale.payDate)-1) DAY), '%Y/%m/%d') as start, "
				+ "DATE_FORMAT(DATE_SUB(sale.payDate, INTERVAL (DAYOFWEEK(sale.payDate)-7) DAY), '%Y/%m/%d') as end,\r\n"
				+ "date_format(sale.payDate,'%Y-%U') as week,\r\n"
				+ "sum(saleDetail.unitprice*saleDetail.num) as total,\r\n"
				+ "count(date_format(sale.payDate,'%Y-%m')) as cnt,\r\n"
				+ "sum(IF(sale.deliveryStatus between 1 and 3, saleDetail.unitprice * saleDetail.num, 0)) as sale,\r\n"
				+ "sum(IF(sale.deliveryStatus IN(4,6), saleDetail.unitprice * saleDetail.num, 0)) as refund, \r\n"
				+ "sum(IF(sale.deliveryStatus between 1 and 3,\r\n"
				+ "IF((saleDetail.unitprice * saleDetail.num) >= 70000, saleDetail.unitprice * saleDetail.num, 0), 0)) as delNoSale,\r\n"
				+ "sum(IF(sale.deliveryStatus between 1 and 3,\r\n"
				+ "IF((saleDetail.unitprice * saleDetail.num)-2500 < 70000, (saleDetail.unitprice * saleDetail.num)-2500, 0), 0)) as delYesSale,\r\n"
				+ "sum(IF((saleDetail.unitprice * saleDetail.num)-2500 <  70000, 2500, 0)) as delPrice\r\n"
				+ "from saleDetail inner join sale on saleDetail.saleId = sale.id\r\n"
				+ "where DATE_FORMAT(sale.payDate, '%Y') = ? group by week";
		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, yyyy);
			rs = pstmt.executeQuery();
			int n = 1;
			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("start") + " ~ " + rs.getString("end"));
				sVo.setTotal(rs.getString("total"));
				sVo.setCnt(rs.getInt("cnt"));
				sVo.setPrice(rs.getString("sale"));
				sVo.setUnitPrice(rs.getString("refund"));
				// 1. 70000 원 이상 주문의 총 금액
				int delNoSale = rs.getInt("delNoSale");
				// 2. 70000 원 미만 주문의 배송비를 제외한 총 금액
				int delYesSale = rs.getInt("delYesSale");
				// 배송비가 붙은 주문의 총 배송비
				sVo.setDelivery(rs.getString("delPrice"));
				// 1과 2의 합계 (배송비를 제외한 순수 주문금액)
				sVo.setNum(delYesSale + delNoSale);
				list.add(sVo);
				n = n + 1;
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

	// 관리자 금주/전주 매출 증감률 비교 (표)
	public List<SaleVO> getWeekRateChange() {
		String sql = "select" + " date_format(sale.payDate,'%Y-%U') as week,"
				+ " DATE_FORMAT(DATE_SUB(sale.payDate, INTERVAL (DAYOFWEEK(sale.payDate)-2) DAY), '%Y/%m/%d') as start,"
				+ " DATE_FORMAT(DATE_SUB(sale.payDate, INTERVAL (DAYOFWEEK(sale.payDate)-8) DAY), '%Y/%m/%d') as end,"
				+ " sum(saleDetail.unitprice*saleDetail.num) as total,"
				+ " sum(IF(sale.deliveryStatus between 1 and 3, saleDetail.unitprice * saleDetail.num, 0)) as sale,"
				+ " sum(IF(sale.deliveryStatus IN(4,6), saleDetail.unitprice * saleDetail.num, 0)) as refund "
				+ " from saleDetail inner join sale on saleDetail.saleId = sale.id" + " where 1"
				+ " group by week order by week desc limit 2";

		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			// pstmt.setString(1, yyyyMM2);
			// pstmt.setString(2, yyyyMM);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("start") + "~" + rs.getString("end"));
				// 결제금액합계
				sVo.setTotal(rs.getString("total"));
				// 순매출합계
				sVo.setPrice(rs.getString("sale"));
				// 환불합계
				sVo.setUnitPrice(rs.getString("refund"));
				list.add(sVo);
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

	// 관리자 일별 매출 통계 (구글차트 api)
	public Map<String, String> getDayRevenue(String week, int status, String startDate, String endDate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "select" + " date(sale.payDate) as date,"
					+ " sum(saleDetail.unitPrice*saleDetail.num) as salePrice" + " from saleDetail"
					+ " inner join sale on saleDetail.saleId = sale.id" + " where 1=1 "
					+ " and date(sale.payDate) >= STR_TO_DATE(?, '%Y%m%d')"
					+ " and date(sale.payDate) <= STR_TO_DATE(?, '%Y%m%d')";

			String whereQuery = "";
			Map<String, String> result = new LinkedHashMap<String, String>();
			System.out.println(startDate+endDate);
			conn = this.getConnection();
			if (status == 1) {
				whereQuery += " and sale.deliveryStatus between 1 and 3";
			}
			if (status == 2) {
				whereQuery += " and sale.deliveryStatus IN(4,6)";
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
					if (rs.getString("salePrice") != null) {
						result.put(rs.getString("date"), rs.getString("salePrice"));
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

	// 관리자 일별 매출 통계 (표)
	public List<SaleVO> getDayRevenueTable(String startDate, String endDate) {
		String sql = "select \r\n" + "date(sale.payDate) as date,"
				+ "sum(saleDetail.unitprice*saleDetail.num) as total,\r\n"
				+ "count(date_format(sale.payDate,'%Y-%m')) as cnt,\r\n"
				+ "sum(IF(sale.deliveryStatus between 1 and 3, saleDetail.unitprice * saleDetail.num, 0)) as sale,\r\n"
				+ "sum(IF(sale.deliveryStatus IN(4,6), saleDetail.unitprice * saleDetail.num, 0)) as refund, \r\n"
				+ "sum(IF(sale.deliveryStatus between 1 and 3,\r\n"
				+ "IF((saleDetail.unitprice * saleDetail.num)-2500 >= 70000, (saleDetail.unitprice * saleDetail.num)-2500, 0), 0)) as delNoSale,\r\n"
				+ "sum(IF(sale.deliveryStatus between 1 and 3,\r\n"
				+ "IF((saleDetail.unitprice * saleDetail.num)-2500 < 70000, (saleDetail.unitprice * saleDetail.num), 0), 0)) as delYesSale,\r\n"
				+ "sum(IF((saleDetail.unitprice * saleDetail.num)-2500 <  70000, 2500, 0)) as delPrice\r\n"
				+ "from saleDetail inner join sale on saleDetail.saleId = sale.id\r\n"
				+ "where 1=1 and date(sale.payDate) >= STR_TO_DATE(?, '%Y%m%d')"
				+ " and date(sale.payDate) <= STR_TO_DATE(?, '%Y%m%d') group by date";

		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			rs = pstmt.executeQuery();
			int n = 1;
			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setMonth(rs.getString("date"));
				sVo.setTotal(rs.getString("total"));
				sVo.setCnt(rs.getInt("cnt"));
				sVo.setPrice(rs.getString("sale"));
				sVo.setUnitPrice(rs.getString("refund"));
				// 1. 70000 원 이상 주문의 총 금액
				int delNoSale = rs.getInt("delNoSale");
				// 2. 70000 원 미만 주문의 배송비를 제외한 총 금액
				int delYesSale = rs.getInt("delYesSale");
				// 배송비가 붙은 주문의 총 배송비
				sVo.setDelivery(rs.getString("delPrice"));
				// 1과 2의 합계 (배송비를 제외한 순수 주문금액)
				sVo.setNum(delYesSale + delNoSale);
				list.add(sVo);
				n = n + 1;
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

	// 관리자 상품 판매 순위(구글 파이 차트)
	public List<SaleVO> getproductCountRank(int status) {
		String sql = "select product.name, unitPrice, sum(num) as num from saleDetail"
				+ " inner join sale on saleDetail.saleId = sale.id "
				+ " inner join product on saleDetail.productId = product.id" + " where 1=1";
		String whereQuery = "";

		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		if (status == 1) {
			whereQuery += " and sale.deliveryStatus between 1 and 3";
		}
		if (status == 2) {
			whereQuery += " and sale.deliveryStatus IN(4,6)";
		}

		whereQuery += " group by saleDetail.productId order by num desc limit 10";
		sql += whereQuery;
		System.out.println(sql);
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setName(rs.getString("product.name"));
				sVo.setUnitPrice(rs.getString("unitPrice"));
				sVo.setNum(rs.getInt("num"));

				list.add(sVo);
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

	// -------------------------------------------------카테고리-------------------------------------------------------

	// 관리자 카테고리별 순위
	public List<SaleVO> categoryRank(int status) {
		String sql = "select a.name, sum(b.num) as num"
				+ " from category as a, saleDetail as b, sale as c, product as d"
				+ " where a.num = d.category and b.saleId = c.id and b.productId = d.id";

		String whereQuery = "";

		List<SaleVO> list = new ArrayList<SaleVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		if (status == 1) {
			whereQuery += " and c.deliveryStatus between 1 and 3";
		}
		if (status == 2) {
			whereQuery += " and c.deliveryStatus IN(4,6)";
		}

		whereQuery += " group by d.category order by num desc";
		sql += whereQuery;
		System.out.println(sql);
		try {
			conn = getConnection();
			pstmt = (PreparedStatement) conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				SaleVO sVo = new SaleVO();
				sVo.setCategory(rs.getString("a.name"));
				sVo.setNum(rs.getInt("num"));

				list.add(sVo);
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
	
		public List<SaleVO> getMainSale(int status) {
			String sql = "select count(*) as cnt, sum(saleDetail.unitPrice*saleDetail.num) as num from saleDetail" + 
					"	inner join sale on saleDetail.saleId = sale.id" + 
					" where 1=1 " + 
					" and date_format(sale.payDate, '%m') ='11'" + 
					"	and sale.deliveryStatus=?";
			
			String whereQuery = "";
			
			List<SaleVO> list = new ArrayList<SaleVO>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			sql += whereQuery;
			System.out.println(sql);
			try {
				conn = getConnection();
				pstmt = (PreparedStatement) conn.prepareStatement(sql);
				pstmt.setInt(1, status);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					SaleVO sVo = new SaleVO();
					sVo.setCategory(rs.getString("cnt"));
					sVo.setNum(rs.getInt("num"));
					
					list.add(sVo);
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
