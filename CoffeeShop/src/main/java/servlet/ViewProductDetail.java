package servlet;

import java.io.IOException;

import bean.Product;
import database.Dao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/viewProductDetail")
public class ViewProductDetail extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String product_id = req.getParameter("product_id");
		HttpSession session = req.getSession();
		Dao dao = (Dao) session.getAttribute("dao");
		if (dao == null) {
			dao = new Dao();
			session.setAttribute("dao", dao);
		}
		try {
			dao.getConnection();
			Product product = dao.getProductById(product_id);
			req.setAttribute("product", product);
		} catch (Exception e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = req.getRequestDispatcher("productDetail.jsp");
		dispatcher.forward(req, resp);
	}
}
