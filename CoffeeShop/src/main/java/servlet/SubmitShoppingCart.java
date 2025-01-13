package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/submitShoppingCart")
public class SubmitShoppingCart extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String option = req.getParameter("option");
		if (option.equals("save")) {
			RequestDispatcher rd = req.getRequestDispatcher("/updateShoppingCart");
			rd.forward(req, resp);
		} else {
			RequestDispatcher rd = req.getRequestDispatcher("/pay");
			rd.forward(req, resp);
		}
	}
}
