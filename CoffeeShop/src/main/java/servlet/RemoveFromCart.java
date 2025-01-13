package servlet;

import java.io.IOException;
import java.sql.SQLException;

import bean.Cart;
import bean.User;
import database.Dao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/removeFromCart")
public class RemoveFromCart extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(true);
		Boolean login = (Boolean) session.getAttribute("login");
		String product_id = req.getParameter("product_id");
		Cart cart = (Cart) session.getAttribute("cart");
		Dao dao = (Dao) session.getAttribute("dao");
		User user = (User) session.getAttribute("user");

		try {
			if (login) {
				dao.removeAllFromCart(dao.getProductById(product_id), user);
			} else {
				cart.removeAllFromCart(dao.getProductById(product_id));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
