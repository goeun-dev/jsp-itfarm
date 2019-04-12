package com.itfarm.controller.action.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.Board2DAO;
import com.itfarm.dto.BoardVO;


public class Board2DeleteForm implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RcdNo = request.getParameter("rcdNo");
		System.out.println(RcdNo);
		Board2DAO bDao = Board2DAO.getInstance();
		BoardVO bVo = bDao.selectOneBoardByNum(RcdNo);
		System.out.println(bVo);
		request.setAttribute("board", bVo);

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/board2/board2Delete.jsp");
		dispatcher.forward(request, response);

	}

}
