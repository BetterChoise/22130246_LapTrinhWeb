package servlet;

import java.io.IOException;

import bean.*;
import database.Dao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = req.getSession(true);
		Dao dao = (Dao) session.getAttribute("dao");
		if (dao == null) {
			dao = new Dao();
		}
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		try {
			dao.getConnection();
			String role = dao.login(username, password);
			if (role != null) {
				User user = dao.getUser(username, password);
				session.setAttribute("login", true);
				Cart cart = (Cart) session.getAttribute("cart");
				if (cart != null) {
					cart.setUser(user);
					dao.addToCart(cart);
				}
				session.setAttribute("user", user);
				session.setAttribute("dao", dao);
				session.setAttribute("role", role);
				resp.sendRedirect("index.jsp");
			} else {
				RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
				req.setAttribute("messege", "Wrong username or password");
				dispatcher.forward(req, resp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
