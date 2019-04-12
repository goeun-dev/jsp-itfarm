package com.itfarm.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itfarm.controller.action.Action;

/**
 * Servlet implementation class ProductServlet
 */
// 2. url이 Product로 넘어오는 요청을 처리
@WebServlet("/Product")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 3. command라는 이름의 파라미터 전달받음
		String command = request.getParameter("command");
		// 4. ActionFactory 클래스 사용위해 getInstance()로 호출
		ActionFactory af = ActionFactory.getInstance();
		// 5. 사용자 요청(command)에 알맞은 처리 위해서 ActionFactory.java 안의 getAction()메소드 호출
		Action action = af.getAction(command);
		// 7. 받아온 결과를 실행
		if (action != null) {
			action.execute(request, response);
		}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}

}
