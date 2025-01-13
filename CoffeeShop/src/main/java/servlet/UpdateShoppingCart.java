package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

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

@WebServlet("/updateShoppingCart")
public class UpdateShoppingCart extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String[] productIds = req.getParameterValues("product_id");
		String[] quantities = req.getParameterValues("quantity");
		if (productIds != null) {
			Map<String, Integer> newShoppingCart = new HashMap<String, Integer>();
			if (productIds != null && quantities != null) {
				for (int i = 0; i < productIds.length; i++) {
					String productId = productIds[i];
					int quantity = Integer.parseInt(quantities[i]);
					newShoppingCart.put(productId, quantity);
				}
			}
			HttpSession session = req.getSession();
			Dao dao;
			try {
				if ((boolean) session.getAttribute("login")) {
					dao = (Dao) session.getAttribute("dao");
					User user = (User) session.getAttribute("user");
					dao.getConnection();
					dao.updateUserShoppingCart(user, newShoppingCart);
				} else {
					Cart cart = (Cart) session.getAttribute("cart");
					cart.updateUserShoppingCart(newShoppingCart);
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		resp.sendRedirect("shoppingCart.jsp");
	}
}
