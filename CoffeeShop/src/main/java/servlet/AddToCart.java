package servlet;

import java.io.IOException;

import bean.Cart;
import bean.Product;
import bean.User;
import database.Dao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addToCart")
public class AddToCart extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession(true);
		Boolean login = (Boolean) session.getAttribute("login");
		if (login == null) {
			login = false;
			session.setAttribute("login", login);
		}

		Dao dao = (Dao) session.getAttribute("dao");
		if (dao == null) {
			dao = new Dao();
			session.setAttribute("dao", dao);
		}

		User user = (User) session.getAttribute("user");
		if (user == null) {
			user = new User();
			session.setAttribute("user", user);
		}

		Cart cart = (Cart) session.getAttribute("cart");
		if (cart == null) {
			cart = new Cart();
			session.setAttribute("cart", cart);
		}

		String product_id = req.getParameter("product_id");
		try {
			dao.getConnection();
			Product pr = dao.getProductById(product_id);
			if (!login) {
				cart.addToCart(pr);
			} else {
				dao.addToCart(pr, user);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
