package org.krzysio.games.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author kbarczynski
 */
public class LoginOrRegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String username = req.getParameter("username");
		String newUser = req.getParameter("newUser");
		String pass = req.getParameter("pass");
		String confpass = req.getParameter("confpass");
		
		getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
	}

}
