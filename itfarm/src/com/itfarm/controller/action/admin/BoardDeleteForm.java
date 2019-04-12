package com.itfarm.controller.action.admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.BoardDAO;
import com.itfarm.dto.BoardVO;


public class BoardDeleteForm implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String RcdNo = request.getParameter("rcdNo");
		System.out.println(RcdNo);
		BoardDAO bDao = BoardDAO.getInstance();
		BoardVO bVo = bDao.selectOneBoardByNum(RcdNo);
		System.out.println(bVo);
		request.setAttribute("board", bVo);

		RequestDispatcher dispatcher = request
				.getRequestDispatcher("admin/board/boardDelete.jsp");
		dispatcher.forward(request, response);

	}

}
