package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.BoardDAO;
import com.itfarm.dto.BoardVO;

public class BoardList implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
	BoardDAO bDao = BoardDAO.getInstance();
	
	List<BoardVO> boardList = bDao.selectAllBoard1();
	request.setAttribute("boardList", boardList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/board/boardList.jsp");
		dispatcher.forward(request, response);
	}
}
