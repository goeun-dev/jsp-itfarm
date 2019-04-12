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
 * Servlet implementation class ProductUpdateServlet
 */
@WebServlet("/ProductUpdate")
public class ProductUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductUpdate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String productNum = request.getParameter("productNum");
		ProductDAO pDao = ProductDAO.getInstance();
		ProductVO pVo = pDao.selectOneProductByNum(productNum);
		request.setAttribute("product", pVo);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/product/productUpdate.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
//		ServletContext context = getServletContext();
//		String realFolder = context.getRealPath("upload");
		
		String savefile = "/images/product";
		ServletContext scontext = request.getSession().getServletContext();
		String realFolder = scontext.getRealPath(savefile);
		
		String encType = "UTF-8";
		int sizeLimit = 20 * 1024 * 1024;
		
		MultipartRequest multi = new MultipartRequest(request, realFolder, sizeLimit,
				encType, new DefaultFileRenamePolicy());
		String code = multi.getParameter("productNum");
		String name = multi.getParameter("name");
		String price = multi.getParameter("price");
		String category = multi.getParameter("category");
		String description = multi.getParameter("description");
		int count = Integer.parseInt(multi.getParameter("count"));
		String pictureUrl = multi.getFilesystemName("pictureUrl");
		System.out.println(pictureUrl);
		if (pictureUrl == null) {
			pictureUrl = multi.getParameter("nonmakeImg");
		}
		ProductVO pVo = new ProductVO();
		pVo.setProductNum(code);
		pVo.setName(name);
		pVo.setPrice(price);
		pVo.setCategory(category);
		pVo.setProductImg(pictureUrl);
		pVo.setCount(count);
		pVo.setDescription(description);
		ProductDAO pDao = ProductDAO.getInstance();
		pDao.updateProduct(pVo);
		response.setCharacterEncoding("EUC-KR");
		PrintWriter writer = response.getWriter();
		writer.println("<script type='text/javascript'>");
		writer.println("alert('수정되었습니다.');");
		writer.println("location.href='Admin?command=product_list';");
		writer.println("</script>");
		writer.flush();
		return;
		// response.sendRedirect("ProductList");
	}

}
