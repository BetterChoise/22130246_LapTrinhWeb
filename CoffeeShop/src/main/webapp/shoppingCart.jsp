<%@page import="bean.Cart"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="bean.User"%>
<%@page import="bean.Product"%>
<%@page import="java.util.Map"%>
<%@page import="database.Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
<style>
html {
	scroll-behavior: smooth;
}

body {
	padding: 0;
	margin: 0;
}

header {
	background-color: rgba(186, 158, 131, 0.4);
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid #ddd;
	height: 80px;
}

header .logo img {
	height: 60px;
	border-radius: 50%;
}

header .shopping {
	margin-right: 70px;
}

.logo {
	margin-left: 20px;
	padding-right: 30px;
	border-right: 1px solid black;
}

.search {
	width: 60%;
	height: 40px;
	border: 1px solid #000;
	border-radius: 20px;
	display: flex;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
	margin-right: 70px;
}

.search button {
	background-color: #f8f9fa;
	border: none;
	padding-right: 20px;
	border-radius: 0 25px 25px 0px;
	padding-left: 20px;
}

.search button:hover {
	background-color: #ddd;
}

header input {
	width: 100%;
	padding-left: 25px;
	border: none;
	border-radius: 25px 0 0px 25px;
	outline: none;
}

.shoppingcard {
	margin-right: 30px;
	color: rgb(164, 82, 0);
}

.cart-table-container {
	margin: 20px auto;
	max-width: 1200px;
	background-color: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.cart-table {
	width: 100%;
	border-collapse: collapse;
}

.cart-table th, .cart-table td {
	text-align: left;
	padding: 10px;
	border-bottom: 1px solid #ddd;
}

.cart-table th {
	background-color: #f3f3f3;
	font-weight: bold;
}

.cart-table td input[type="number"] {
	width: 50px;
	padding: 5px;
	text-align: center;
}

.cart-table td input[type="checkbox"] {
	margin: 0 auto;
}

.cart-table .action-btn {
	background-color: #ff4d4d;
	color: white;
	border: none;
	padding: 5px 10px;
	border-radius: 3px;
	cursor: pointer;
}

.cart-table .action-btn:hover {
	background-color: #e60000;
}

.pay {
	display: flex;
	align-items: center;
	width: 100%;
	justify-content: center;
}

.save-btn {
	margin-right: -15px;
	width: 100px;
	height: 60px;
	background-color: #00CC00;
	border-radius: 6px;
	border: 1px black;
	color: #333333;
	background-color: #7AE582;
	cursor: pointer;
	font-size: 18px;
	font-weight: bold;
}

.save-btn:hover {
	color: #006600;
}

.pay-btn {
	margin-left: 30px;
	width: 100px;
	height: 60px;
	background-color: #00CC00;
	border-radius: 6px;
	border: 1px black;
	color: #333333;
	background-color: #7AE582;
	cursor: pointer;
	font-size: 18px;
	font-weight: bold;
}

.pay-btn:hover {
	color: #006600;
}
</style>
</head>
<body>
	<header>
		<div class="logo">
			<a href="index.jsp"><img src="img/logo.jpg"
				alt="Coffee Shop Logo"></a>
		</div>
		<div class="shopping">
			<h2>GIỎ HÀNG</h2>
		</div>
		<div class="search">
			<input type="text" id="search_text"
				placeholder="Tìm kiếm sản phẩm...">
			<button id="search_btn">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
		</div>
	</header>
	<form action="submitShoppingCart" method="POST" id="shoppingCart_form">
		<div class="cart-table-container">
			<table class="cart-table">
				<thead>
					<tr>
						<th>Sản Phẩm</th>
						<th>Đơn Giá</th>
						<th>Số Lượng</th>
						<th>Số Tiền</th>
						<th>Thao Tác</th>
					</tr>
				</thead>
				<tbody>
					<%
					session = request.getSession(false);
					if (session != null) {
						Boolean login = (Boolean) session.getAttribute("login");
						if (login != null) {
							if (login) {
						Dao dao = (Dao) session.getAttribute("dao");
						dao.getConnection();
						Map<Product, Integer> shoppingCart = dao.getUserShoppingCart((User) session.getAttribute("user"));
						for (Product pr : shoppingCart.keySet()) {
							String title = pr.getDescription();
							BigDecimal productPrice = pr.getPrice();
							int quantity = shoppingCart.get(pr);
							String strPrice = productPrice.stripTrailingZeros().toPlainString();
							int totalPrice = Integer.parseInt(strPrice) * quantity;
					%>
					<tr>
						<td><%=title%></td>
						<input type="hidden" name="product_id"
							value="<%=pr.getProduct_id()%>">
						<td><%=productPrice%>0VND</td>
						<td><input type="number" name="quantity"
							value="<%=quantity%>"></td>
						<td><%=totalPrice%>.000VND</td>
						<td><button type="button" class="action-btn"
								data-id="<%=pr.getProduct_id()%>">Xóa</button></td>
					</tr>
					<%
					}
					} else {
					Cart cart = (Cart) session.getAttribute("cart");
					Map<Product, Integer> shoppingCart = cart.getUserShoppingCart();
					for (Product pr : shoppingCart.keySet()) {
					String title = pr.getDescription();
					BigDecimal productPrice = pr.getPrice();
					int quantity = shoppingCart.get(pr);
					String strPrice = productPrice.stripTrailingZeros().toPlainString();
					int totalPrice = Integer.parseInt(strPrice) * quantity;
					%>
					<tr>
						<td><%=title%></td>
						<input type="hidden" name="product_id"
							value="<%=pr.getProduct_id()%>">
						<td><%=productPrice%>0VND</td>
						<td><input type="number" name="quantity"
							value="<%=quantity%>"></td>
						<td><%=totalPrice%>.000VND</td>
						<td><button type="button" class="action-btn"
								data-id="<%=pr.getProduct_id()%>">Xóa</button></td>
					</tr>
					<%
					}
					}
					}
					}
					%>
				</tbody>
			</table>
		</div>
		<div class="pay">
			<button type="submit" name="option" value="save" class="save-btn">Lưu</button>
			<button type="submit" name="option" value="order" class="pay-btn">Đặt
				hàng</button>
		</div>
	</form>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			$('.action-btn').click(function() {
				const productId = $(this).data('id'); // Lấy ID sản phẩm từ thuộc tính data-id
				var row = $(this).closest('tr'); // Lấy hàng (row) cha của nút
				row.hide();
			});
		});
	</script>
</body>
</html>