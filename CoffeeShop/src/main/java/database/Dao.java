package database;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import bean.*;

public class Dao {
	private final static String serverName = "LAPTOP-RL8PCC9A";
	private final static String portNum = "1433";
	private final static String dbName = "CoffeeShop";
	private static String driverClass = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private static String username = "sa";
	private static String password = "123";
	Connection connection = null;

	public Connection getConnection() throws Exception {
		String url = "jdbc:sqlserver://" + serverName + ":" + portNum + ";databaseName=" + dbName
				+ ";encrypt=true;trustServerCertificate=true;integratedSecurity=false;";
		try {
			Class.forName(driverClass);

			connection = DriverManager.getConnection(url, username, password);

			if (connection != null) {
				System.out.println("Kết nối thành công");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return connection;
	}

	public void closeConnection() {
		if (connection != null) {
			try {
				connection.close();
				System.out.println("Đã đóng kết nối.");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void updateUserProfile(User user) throws SQLException {
		String sql = "BEGIN TRANSACTION; BEGIN TRY UPDATE users SET email = ?, phone = ?, address = ?, full_name = ? WHERE user_id = ? COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION; END CATCH;";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, user.getEmail());
		preStmt.setString(2, user.getPhone());
		preStmt.setString(3, user.getAddress());
		preStmt.setString(4, user.getFull_name());
		preStmt.setString(4, user.getUser_id());
		preStmt.executeUpdate();
	}

	public boolean updateUserShoppingCart(User user, Map<String, Integer> newShoppingCart) throws SQLException {
		Map<Product, Integer> userShopingCart = getUserShoppingCart(user);

		for (String product_id : newShoppingCart.keySet()) {
			for (Product product : userShopingCart.keySet()) {
				if (product_id.equals(product.getProduct_id())) {
					int newQuantity = newShoppingCart.get(product_id);
					int oldQuantity = userShopingCart.get(product);
					if (newQuantity < oldQuantity) {
						for (int i = 0; i < (oldQuantity - newQuantity); i++) {
							removeFromCart(product, user);
						}
						break;
					}
					if (newQuantity > oldQuantity) {
						for (int i = 0; i < (newQuantity - oldQuantity); i++) {
							addToCart(product, user);
						}
						break;
					} else {
						break;
					}
				}
			}
		}

		return true;
	}

	public Map<Product, Integer> getUserShoppingCart(User user) throws SQLException {
		Map<Product, Integer> shoppingCart = new HashMap<Product, Integer>();
		Map<String, Integer> shoppingCart_withId = new HashMap<String, Integer>();
		List<String> productIdList = new ArrayList<String>();

		String sql = "SELECT * FROM cart WHERE user_id = ?";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, user.getUser_id());
		ResultSet rs = preStmt.executeQuery();
		while (rs.next()) {
			productIdList.add(rs.getString("product_id"));
		}
		for (String id : productIdList) {
			shoppingCart_withId.put(id, shoppingCart_withId.getOrDefault(id, 0) + 1);
		}
		for (String id : shoppingCart_withId.keySet()) {
			shoppingCart.put(getProductById(id), shoppingCart_withId.get(id));
		}
		return shoppingCart;
	}

	public List<Product> getProducts(String searchData) throws SQLException {
		List<Product> products = new ArrayList<Product>();
		String sql = "SELECT * FROM products where name like ?";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, "%" + searchData + "%");
		ResultSet rs = preStmt.executeQuery();
		while (rs.next()) {
			String id = rs.getString("product_id");
			String name = rs.getString("name");
			String description = rs.getString("description");
			BigDecimal price = rs.getBigDecimal("price");
			int stock = rs.getInt("stock");
			String category_id = rs.getString("category_id");
			Product pr = new Product(id, name, description, price, category_id, stock);
			products.add(pr);
		}
		return products;
	}

	public List<Product> getAllProducts() throws SQLException {
		List<Product> products = new ArrayList<Product>();
		String sql = "SELECT * FROM products";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();
		while (rs.next()) {
			String id = rs.getString("product_id");
			String name = rs.getString("name");
			String description = rs.getString("description");
			BigDecimal price = rs.getBigDecimal("price");
			int stock = rs.getInt("stock");
			String category_id = rs.getString("category_id");
			Product pr = new Product(id, name, description, price, category_id, stock);
			products.add(pr);
		}
		return products;
	}

	// select COUNT(product_id) from cart where product_id='P001' Group by user_id;
	// lấy số lượng product_id - quantity với dk product_id là P001 theo user
	public int getQuantity(Product product, User user) throws SQLException {
		String sql = "select COUNT(product_id) from cart where product_id= ? AND user_id = ? Group by user_id";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, product.getProduct_id());
		preStmt.setString(2, user.getUser_id());
		ResultSet rs = preStmt.executeQuery();
		while (rs.next()) {
			int count = rs.getInt(1);
			return count;
		}
		return -1;
	}
	public boolean removeAllFromCart(Product product, User user) throws SQLException {
		String sql = "BEGIN TRANSACTION; BEGIN TRY DELETE FROM cart WHERE cart_id IN (SELECT cart_id FROM cart where user_id = ? AND product_id = ? ) COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION; END CATCH;";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, user.getUser_id());
		preStmt.setString(2, product.getProduct_id());
		preStmt.executeUpdate();

		return true;
	}
	
	public boolean removeFromCart(Product product, User user) throws SQLException {
		String sql = "BEGIN TRANSACTION; BEGIN TRY DELETE FROM cart WHERE cart_id IN (SELECT TOP(1) cart_id FROM cart where user_id = ? AND product_id = ? ORDER BY cart_id DESC) COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION; END CATCH;";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, user.getUser_id());
		preStmt.setString(2, product.getProduct_id());
		preStmt.executeUpdate();

		return true;
	}

	public boolean addToCart(Cart cart) throws SQLException {
		for (Product pr : cart.getCart()) {
			addToCart(pr, cart.getUser());
		}
		return true;
	}

	public boolean addToCart(Product product, User user) throws SQLException {
		String cartId = getLastShoppingCartId();
		int cart = Integer.parseInt(cartId.substring(1, cartId.length())) + 1;
		String newCartId = "c" + cart;
		String sql = "BEGIN TRANSACTION; BEGIN TRY INSERT INTO cart (cart_id, user_id, product_id, quantity) VALUES (?,?,?,?) COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION; END CATCH;";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, newCartId);
		preStmt.setString(2, user.getUser_id());
		preStmt.setString(3, product.getProduct_id());
		preStmt.setInt(4, 1);
		preStmt.executeUpdate();

		return true;
	}

	public int count(String table) throws SQLException {
		String sql = "SELECT COUNT(*) FROM " + table;
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();
		while (rs.next()) {
			int count = rs.getInt(1);

			return count;
		}
		return 0;
	}

	public Product getProductById(String productId) throws SQLException {
		Product pr = null;

		String sql = "SELECT * FROM products WHERE product_id = ?";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, productId);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			String id = rs.getString("product_id");
			String name = rs.getString("name");
			String description = rs.getString("description");
			BigDecimal price = rs.getBigDecimal("price");
			int stock = rs.getInt("stock");
			String category_id = rs.getString("category_id");
			pr = new Product(id, name, description, price, category_id, stock);
		}
		return pr;

	}

	public void getAccounts() throws Exception {
		String sql = "SELECT * FROM account";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			String id = rs.getString("account_id");
			String name = rs.getString("username");
			String password = rs.getString("password");
			String role = rs.getString("role");

			System.out.println(id + " | " + name + " | " + password + " | " + role);
		}
	}

	public User getUser(String username, String password) throws SQLException {
		User user = null;
		String sql = "Select * from users where account_id IN (SELECT account_id FROM account WHERE username = ? AND password = ?)";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, username);
		preStmt.setString(2, password);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			user = new User();
			user.setUser_id(rs.getString("user_id"));
			user.setAccount_id(rs.getString("account_id"));
			user.setAddress(rs.getString("address"));
			user.setEmail(rs.getString("email"));
			user.setFull_name(rs.getString("full_name"));
			user.setPhone(rs.getString("phone"));
		}
		return user;
	}

	public String login(String username, String password) throws SQLException {
		String role = null;
		String sql = "SELECT * FROM account WHERE username = ? AND password = ?";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, username);
		preStmt.setString(2, password);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			role = rs.getString("role");
		}
		return role;
	}

	public User register(String username, String password, String email) throws SQLException {
		if (!exits(username)) {
			User newUser = new User();
			int id = Integer.parseInt(getLastId()) + 1;
			String accountId = "user" + id;
			java.sql.Date currentDate = new java.sql.Date(System.currentTimeMillis());

			String sql = "BEGIN TRANSACTION; BEGIN TRY INSERT INTO account (account_id, username, password, role, created_at) VALUES (?,?,?,?,?) COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION; END CATCH;";
			PreparedStatement preStmt = connection.prepareStatement(sql);
			preStmt.setString(1, accountId);
			preStmt.setString(2, username);
			preStmt.setString(3, password);
			preStmt.setString(4, "customer");
			preStmt.setDate(5, currentDate);
			preStmt.executeUpdate();

			newUser.setAccount_id(accountId);
			return userRegister(accountId, email, newUser);
		}
		return null;
	}

	private boolean exits(String username) throws SQLException {
		List<String> usernames = new ArrayList<String>();
		String sql = "SELECT * FROM account";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			usernames.add(rs.getString("username"));
		}
		if (usernames.contains(username))
			return true;
		return false;
	}

	private User userRegister(String accountId, String email, User user) throws NumberFormatException, SQLException {
		int id = Integer.parseInt(getLastUserId()) + 1;
		String userId = "" + id;
		String sql = "BEGIN TRANSACTION; BEGIN TRY INSERT INTO users (user_id, account_id, email) VALUES (?,?,?) COMMIT TRANSACTION END TRY BEGIN CATCH ROLLBACK TRANSACTION; END CATCH;";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		preStmt.setString(1, userId);
		preStmt.setString(2, accountId);
		preStmt.setString(3, email);
		preStmt.executeUpdate();

		user.setUser_id(userId);
		user.setEmail(email);

		return user;
	}

	private String getLastUserId() throws SQLException {
		String id = null;
		String sql = "SELECT TOP 1 * FROM users ORDER BY user_id DESC";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			id = rs.getString("user_id");
		}
		return id;
	}

	private String getLastShoppingCartId() throws SQLException {
		String id = null;
		String sql = "SELECT TOP 1 * FROM cart ORDER BY   CAST(SUBSTRING(cart_id, PATINDEX('%[0-9]%', cart_id), LEN(cart_id)) AS INT) DESC, cart_id DESC;";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			id = rs.getString("cart_id");
		}
		return id;
	}

	public String getLastId() throws SQLException {
		String id = null;
		String sql = "SELECT TOP 1 * FROM account ORDER BY account_id DESC";
		PreparedStatement preStmt = connection.prepareStatement(sql);
		ResultSet rs = preStmt.executeQuery();

		while (rs.next()) {
			String userId = rs.getString("account_id");
			id = userId.substring(4, userId.length());
		}
		return id;
	}

	public static void main(String[] args) throws Exception {
		Dao dao = new Dao();
		dao.getConnection();
		User user = new User();
		user.setUser_id("1");
		Product product = dao.getProductById("P005");
		Product product2 = dao.getProductById("P007");
//		System.out.println(dao.login("admin", "a01663498879"));
//		System.out.println(dao.getLastId());
//		System.out.println(dao.getLastUserId());
//		System.out.println(dao.register("vodaithanhtai", "a01677369456", "votantoan2702@gmail.com"));
//		System.out.println(dao.exits("vodaithanhtai"));
//		System.out.println(dao.count("cart"));
//		System.out.println(product);
		System.out.println(dao.addToCart(product, user));
//		System.out.println(dao.getLastShoppingCartId());
//		System.out.println(dao.removeFromCart(product, user));
//		System.out.println(dao.getQuntity(product2, user));
		System.out.println(dao.getUser("user1", "a01663498898"));
//		System.out.println(dao.getAllProducts());
//		System.out.println(dao.getProducts("ara"));
//		dao.getUserShoppingCart(user);
		System.out.println();
	}

}