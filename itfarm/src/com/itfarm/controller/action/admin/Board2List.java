package com.itfarm.controller.action.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.dao.Board2DAO;
import com.itfarm.dto.BoardVO;

public class Board2List implements AdminAction {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
	Board2DAO bDao = Board2DAO.getInstance();
	
	List<BoardVO> boardList = bDao.selectAllBoard2();
	request.setAttribute("boardList", boardList);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("admin/board2/board2List.jsp");
		dispatcher.forward(request, response);
	}
}
