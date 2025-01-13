<%@page import="java.math.BigDecimal"%>
<%@page import="bean.Product"%>
<%@page import="database.Dao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Coffee Shop</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/allProducts.css">
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link
	href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@latest/css/boxicons.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
	integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.css"
	integrity="sha512-UTNP5BXLIptsaj5WdKFrkFov94lDx+eBvbKyoe1YAfjeRPC+gT5kyZ10kOHCfNZqEui1sxmqvodNUx3KbuYI/A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css"
	integrity="sha512-sMXtMNL1zRzolHYKEujM2AqCLUR9F2C4/05cdbxjjLSRvMQIciEPCQZo++nk7go3BtSuK9kfa/s+a4f4i5pLkw=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous"></script>

</head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
</head>
<body>
	<header>
		<jsp:useBean id="a" class="database.Dao"></jsp:useBean>
		<div class="logo">
			<a href="index.jsp"><img src="img/logo.jpg"
				alt="Coffee Shop Logo"></a>
		</div>
		<form class="searchForm" action="search" method="get">
			<div class="search">
				<input type="text" id="search_text" name="searchData"
					placeholder="Tìm kiếm sản phẩm...">
				<button type="submit" id="search_btn">
					<i class="fa-solid fa-magnifying-glass"></i>
				</button>
			</div>
		</form>
		<div class="shoppingcard">
			<a href="shoppingCart.jsp"> <i class="fa-solid fa-cart-shopping"></i>
			</a>
		</div>
	</header>
	<div class="home-slide-show">
		<div class="owl-carousel owl-theme">
			<div class="item">
				<img src="img/bestcoffee.jpg" alt="">

			</div>
			<div class="item">
				<img src="img/capheslide.jpg" alt="">

			</div>
			<div class="item">
				<img src="img/doicaphe4.jpg" alt="">

			</div>
			<div class="item">
				<img src="img/ruongcaphe.jpeg" alt="">

			</div>
			<div class="item">
				<img src="img/hatcaphe.jpeg" alt="">

			</div>
		</div>
	</div>
	<div class="allproduct">
		<div id="products" class="products">
			<div class="products_main">
				<%
				Dao dao = new Dao();
				dao.getConnection();
				for (Product pr : dao.getProducts(request.getParameter("searchData"))) {
					String productImg = "img/" + pr.getName() + ".jpg";
					String productTitle = pr.getDescription();
					BigDecimal productPrice = pr.getPrice();
				%>
				<div class="products1">
					<div class="products_img">
						<img src="<%=productImg%>" alt="">
					</div>
					<div class="products_name">
						<h3><%=productTitle%></h3>
						<p><%=productPrice%>0
						</p>
					</div>
					<div class="products_buttons">
						<button type="submit" class="add_to_cart"
							data-id="<%=pr.getProduct_id()%>">Thêm vào giỏ hàng</button>
					</div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<footer>
		<div>
			<h3>Coffee Shop</h3>
			<p>Chúng tôi mang đến những hạt cà phê chất lượng nhất từ Việt
				Nam.</p>
		</div>
		<div>
			<p>
				<strong>Địa chỉ:</strong> Số 123, Đường Cà Phê, Quận 1, TP. Hồ Chí
				Minh
			</p>
			<p>
				<strong>Email:</strong> contact@coffeeshop.vn
			</p>
			<p>
				<strong>Điện thoại:</strong> 0901 234 567
			</p>
		</div>
		<div>
			<p>&copy; 2024 Coffee Shop. All Rights Reserved.</p>
		</div>
	</footer>
	<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"
		integrity="sha512-bPs7Ae6pVvhOSiIcyUClR7/q2OAsRiovw4vAkX+zJbw3ShAeeqezq50RIIcIURq7Oa20rW2n2q+fyXBNcU9lrw=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.js"
		integrity="sha512-gY25nC63ddE0LcLPhxUJGFxa2GoIyA5FLym4UJqHDEMHjp8RET6Zn/SHo1sltt3WuVtqfyxECP38/daUc/WVEA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script>
		$('.owl-carousel').owlCarousel({
			loop : true,
			margin : 0,
			nav : true,
			autoplay : true,
			autoplayTimeout : 1500,
			autoplayHoverPause : true,
			nav : false,
			responsive : {
				0 : {
					items : 1
				},
				800 : {
					items : 1
				},
				1000 : {
					items : 1
				}
			}
		})
	</script>
	nav : false, responsive : { 0 : { items : 1 }, 800 : { items : 1 },
	1000 : { items : 1 } } })
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
