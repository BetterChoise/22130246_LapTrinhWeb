<%@page import="java.math.BigDecimal"%>
<%@page import="bean.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/infoproduct.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
</head>
<body>
	<header>
		<div class="header_top">
			<div class="menu">
				<li class="logo" href=""><a href="index.jsp"><img
						src="img/logo.jpg" alt=""></a></li>
				<ul class="menu_nav">
					<li><a class="menu_infor navbar_item" href="infor.jsp">
							thông tin</a></li>
					<li><a class="menu_product navbar_item"
						href="allproducts.html">mua sắm</a></li>
					<li><a class="menu_cotrac navbar_item"
						href="shoppingCart.jsp">giỏ hàng</a></li>
					<li><a class="menu_login navbar_item" href=""><i
							class="fa-solid fa-user"></i><i class="fa-solid fa-chevron-down"></i></a>
						<ul class="login_navbar">
							<li><a href="profile.jsp">Thông tin</a></li>
							<li><a href="shoppingCart.jsp">Đơn mua </a></li>
							<li><a href="">Đăng xuất</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</header>

	<main>
		<%
		Product pr = (Product) request.getAttribute("product");
		String productImg = "img/" + pr.getName() + ".jpg";
		BigDecimal productPrice = pr.getPrice();
		%>
		<div class="product-detail">
			<div class="product-image">
				<img src="<%=productImg%>" alt="">
			</div>
			<div class="product-info">
				<h1><%=pr.getDescription()%></h1>
				<p class="price"><%=productPrice%>0đ/1kg
				</p>
				<p>Nơi sản xuất: Đắk Lắk</p>
				<p class="description">Hạt cà phê Robusta được chọn lọc từ các
					nông trại cà phê chất lượng cao tại Việt Nam, mang đến hương vị đậm
					đà, phù hợp với những người yêu thích sự mạnh mẽ.</p>
				<div class="product-buttons">
					<button type="submit" class="add_to_cart"
						data-id="<%=pr.getProduct_id()%>">Thêm vào giỏ hàng</button>
				</div>
			</div>
		</div>
	</main>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
		$(document).ready(function() {
			// Bắt sự kiện click trên nút "Thêm vào giỏ hàng"
			$('.add_to_cart').click(function() {
				const productId = $(this).data('id'); // Lấy ID sản phẩm từ thuộc tính data-id

				$.ajax({
					url : 'addToCart', // Servlet xử lý thêm vào giỏ hàng
					type : 'POST',
					data : {
						product_id : productId
					}, // Dữ liệu gửi lên server
					success : function(response) {
						// Hiển thị thông báo khi thêm thành công
						alert('Sản phẩm đã được thêm vào giỏ hàng!');
					},
					error : function() {
						// Thông báo lỗi nếu thêm không thành công
						alert('Lỗi khi thêm sản phẩm vào giỏ hàng!');
					}
				});
			});
		});
	</script>
</body>
</html>