package com.itfarm.controller.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.ProductDAO;
import com.itfarm.dto.ProductVO;

public class CartUpdateForm implements Action{

	public CartUpdateForm() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String num = request.getParameter("num");
		String pnum = request.getParameter("productNum");
		ProductDAO pDao = ProductDAO.getInstance();
		ProductVO pVo = pDao.selectOneProductByNum(pnum);
		request.setAttribute("id", id);
		request.setAttribute("num", num);
		request.setAttribute("product", pVo);
		RequestDispatcher dispatcher = request.getRequestDispatcher("product/cartUpdate.jsp");
		dispatcher.forward(request, response);
	}

}
