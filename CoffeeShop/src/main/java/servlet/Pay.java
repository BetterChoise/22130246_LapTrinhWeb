package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.Cart;
import bean.User;
import database.Dao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/pay")
public class Pay extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String[] productIds = req.getParameterValues("product_id");
		String[] quantities = req.getParameterValues("quantity");
		HttpSession session = req.getSession();
		if ((Boolean) session.getAttribute("login")) {
			if (productIds != null) {
				List<String> products = new ArrayList<String>();
				if (productIds != null && quantities != null) {
					for (int i = 0; i < productIds.length; i++) {
						for (int j = 0; j < Integer.parseInt(quantities[i]); j++) {
							products.add(productIds[i]);
						}
					}
					req.setAttribute("productList", products);
				}
				RequestDispatcher rd = req.getRequestDispatcher("pay.jsp");
				rd.forward(req, resp);
			}
		} else {
			resp.sendRedirect("login.jsp");
		}
	}
}