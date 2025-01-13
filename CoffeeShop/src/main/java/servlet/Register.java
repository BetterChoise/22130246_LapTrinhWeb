package servlet;

import java.io.IOException;

import bean.User;
import database.Dao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class Register extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String newUsername = req.getParameter("username");
		String newPassword = req.getParameter("password");
		String newEmail = req.getParameter("email");

		HttpSession session = req.getSession(true);
		Dao dao = (Dao) session.getAttribute("dao");
		if (dao == null) {
			dao = new Dao();
			session.setAttribute("dao", dao);
		}

		try {
			dao.getConnection();
			User user = dao.register(newUsername, newPassword, newEmail);
			session.setAttribute("user", user);
			session.setAttribute("login", true);
			resp.sendRedirect("index.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
