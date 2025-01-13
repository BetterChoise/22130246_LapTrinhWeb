<%@page import="java.math.BigDecimal"%>
<%@page import="bean.Product"%>
<%@page import="database.Dao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thanh Toán</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/pay.css">
</head>
<body>
	<div class="container">
		<h1>Thanh Toán</h1>
		<form action="submit-payment" method="post">
			<!-- Thông tin khách hàng -->
			<div class="section">
				<h2>Thông tin khách hàng</h2>

				<label for="fullname">tên người nhận:</label> <input
					class="infor_list" type="text" id="fullname" name="fullname"
					required> <label for="email">Email:</label> <input
					class="infor_list" type="email" id="email" name="email" required>

				<label for="address">Địa chỉ giao hàng:</label>
				<textarea class="infor_list" id="address" name="address" rows="3"
					required></textarea>

				<label for="phone">Số điện thoại:</label> <input class="infor_list"
					type="text" id="phone" name="phone" required>

			</div>

			<!-- Chi tiết đơn hàng -->
			<div class="section">
				<table class="cart-table">
					<header class="header_table">
						<tr>
							<th class="product">Tên sản Phẩm</th>
							<th class="price">Đơn Giá</th>
							<th class="amount-header">Số Lượng</th>
							<th>thành tiền</th>
							<th class="block"></th>
						</tr>
					</header>
					<tbody class="main_table">
						<%
						List<String> products = (List<String>) request.getAttribute("productList");
						Dao dao = (Dao) session.getAttribute("dao");
						dao.getConnection();
						int totalPrice = 0;
						for (String product_id : products) {
							Product pr = dao.getProductById(product_id);
							String title = pr.getDescription();
							BigDecimal productPrice = pr.getPrice();
							String strPrice = productPrice.stripTrailingZeros().toPlainString();
							totalPrice += Integer.parseInt(strPrice);
						%>
						<tr class="list-product">
							<td class="name"><%=title%></td>
							<td class="Unit-price"><%=productPrice%>0VND</td>
							<td class="amount">1</td>
							<td class="Total-amount"><%=productPrice%>0VND</td>
							<td class="delete-buttom"><button class="action-btn">Xóa</button></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
				<div class="Invoice-total">
					<p>Tổng hóa đơn:</p>
					<p class="Invoice-total_num"><%=totalPrice%>000VND
					</p>
				</div>
			</div>

			<button class="pay-buttom" type="submit">Thanh Toán</button>
		</form>
	</div>
</body>
</html>
