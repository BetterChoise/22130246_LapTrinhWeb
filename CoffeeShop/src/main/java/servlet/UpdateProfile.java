package servlet;

import java.io.IOException;
import java.sql.SQLException;

import bean.User;
import database.Dao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateProfile")
public class UpdateProfile extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		Dao dao = (Dao) session.getAttribute("dao");

		String full_name = req.getParameter("full_name");
		String address = req.getParameter("address");
		String phone = req.getParameter("phone");
		String email = req.getParameter("email");

		user.setFull_name(full_name);
		user.setAddress(address);
		user.setPhone(phone);
		user.setEmail(email);

		try {
			dao.updateUserProfile(user);
			resp.sendRedirect("profile.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
		}
	}
}
