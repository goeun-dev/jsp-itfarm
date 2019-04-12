package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ProductVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class ProductWriteServlet
 */
@WebServlet("/ProductWrite")
public class ProductWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductWrite() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/product/productWrite.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//HttpSession session = request.getSession();
		// 업로드 할 파일 경로를 서버상의 실제 경로로 찾아 온다.
		ServletContext context = getServletContext();
		System.out.println("context: " + context);

		// local 서버에 업로드 할 폴더이름: upload
		String realFolder = "";
		String path = "/ROOT/images/product/";
		// String path = session.getServletContext().getRealPath("");
		// String path = "upload";
		System.out.println("path: " + path);
		String savefile = "/images/product";

		ServletContext scontext = request.getSession().getServletContext();

		realFolder = scontext.getRealPath(savefile);

		// 업로드 할 파일 명이 한글일 경우 깨지지 않도록 파일 명을 한글로 한다.
		String encType = "UTF-8";
		// 업로드 파일의 크기를 최대 20MB로 제한
		int sizeLimit = 20 * 1024 * 1024;
		/*
		 * HttpServletRequest 객체, 업로드할 경로, 업로드할 파일 사이즈에 제한 값을 주어 MultipartRequest 객체를
		 * 생성. MultipartRequest 객체가 생성되는 순간 서버로 파일이 업로드.
		 */
		MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit, encType, new DefaultFileRenamePolicy());

		//String paths = "";
		// ftp=============================================
//		FTPUploader ftpUploader = null;
//		String orignFilename = multi.getFilesystemName("pictureUrl");
//		try {
//			ftpUploader = new FTPUploader("112.175.184.71", "goeu", "dlrhdms12");
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			System.out.println("connect fail");
//		}
//		try {
//			paths = "G:\\" + orignFilename;
//			ftpUploader.uploadFile(paths, orignFilename, "/html/upload/product/");
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println("upload fail");
//		}
//		ftpUploader.disconnect();
//		System.out.println("Done");
		// ==============================================

		String name = multi.getParameter("name");
		String price = multi.getParameter("price");
		int count = Integer.parseInt(multi.getParameter("count"));
		String description = multi.getParameter("description");
		String category = multi.getParameter("category");

		String pictureUrl = multi.getFilesystemName("pictureUrl");

		if (pictureUrl == null) {
			pictureUrl = "nonmakeImg";
		}
		ProductVO pVo = new ProductVO();
		pVo.setName(name);
		pVo.setPrice(price);
		pVo.setCategory(category);
		pVo.setProductImg(pictureUrl);
		pVo.setProductDtImg(pictureUrl);
		pVo.setCount(count);
		pVo.setDescription(description);
		ProductDAO pDao = ProductDAO.getInstance();
		pDao.insertProduct(pVo);

		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('등록되었습니다.');");
		writer.println("location.href='Admin?command=product_list';");
		writer.println("</script>");
		writer.flush();
		return;
		// response.sendRedirect("ProductList");
	}

}
