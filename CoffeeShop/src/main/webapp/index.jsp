<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>cửa hàng cà phê</title>
<!-- <link rel="stylesheet" href="index.css"> -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/index.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/about.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/products.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/js/scrip.js">
</head>
<style></style>
<body>
	<header>
		<div class="header_top">
			<div class="menu">
				<li class="logo"><a href="#home"><img
						src="<%=request.getContextPath()%>/img/logo.jpg" alt=""></a></li>
				<ul class="menu_nav">
					<li><a class="menu_infor navbar_item" href="#infor"> thông
							tin</a></li>
					<li><a class="menu_product navbar_item" href="#products">Sản
							Phẩm</a></li>
					<li><a class="menu_cotrac navbar_item" href="allProduct.jsp">mua
							sắm</a></li>
					<%
					Boolean login = (Boolean) session.getAttribute("login");
					if (login == null) {
						login = false;
					}
					if (login) {
					%>
					<li><a class="menu_login navbar_item" href=""><i
							class="fa-solid fa-user"></i> <i class="fa-solid fa-chevron-down"></i></a>
						<ul class="login_navbar">
							<li><a href="profile.jsp">Thông tin</a></li>
							<li><a href="shoppingCart.jsp">Đơn mua </a></li>
							<li><form action="logout" method="POST">
									<a href="#" onclick="document.forms[0].submit(); return false;">Đăng
										xuất</a>
								</form></li>

						</ul></li>
					<%
					} else {
					%>
					<li><a class="menu_login navbar_item" href="">đăng nhập</a>
						<ul class="login_navbar">
							<li><a href="login.jsp"> đăng nhập </a></li>
							<li><a href="register.jsp">đăng kí</a></li>
						</ul></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
		<div class="header_background">
			<img alt="" src="img/background3.jpg">
		</div>
		<div class="content">
			<h1>Cửa hàng cà phê số 10</h1>
			<p>thưởng thức theo cách của bạn!</p>
		</div>
		<div class="despription"></div>
	</header>
	<div class="container">
		<div class="infor" id="infor"></div>
		<div class="about_body">
			<div class="about_main">
				<div class="about_container">
					<h1 style="font-size: 40px;">
						<STRong>THÔNG TIN</STRong>
					</h1>
					<p>Chúng tôi tự hào cung cấp những hạt cà phê tốt nhất đến từ
						khu vực Tây Nguyên(khu vực trồng cà phê tốt nhất ở Việt Nam hiện
						nay). Cửa hàng có sứ mệnh cung cấp cho bạn những trải nghiệm tuyệt
						vời nhất cho khách hàng.</p>
					<div class="about_readmore">
						<div class="about-readmore_body">
							<div class="about-btn-view-more ">
								<a href="infor.jsp" style="text-decoration: none;"><span
									style="font-size: 25px;">chi tiết</span> </a>
							</div>
						</div>
					</div>
				</div>
				<div class="about_slideshow">
					<div class="about_list_img">
						<div class="about_aboutSlides fade">
							<img src="img/doicaphe1.jpg" style="width: 100%">
						</div>

						<div class="about_aboutSlides fade">
							<img src="img/doicaphe4.jpg" style="width: 100%">
						</div>

						<div class="about_aboutSlides fade">
							<img src="img/doicaphe3.jpg" style="width: 100%">
						</div>

						<a class="prev" onclick="plusSlides3(-1)">❮</a> <a class="next"
							onclick="plusSlides3(1)">❯</a>

					</div>
					<br>
				</div>
			</div>
		</div>

		<div id="products" class="products">
			<div class="AllProducts">
				<a href="allProduct.jsp"> tất cả sản phẩm></a>
			</div>
			<div class="products_main">
				<div class="products1">
					<div class="products_img">
						<img src="img/robusta.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Robusta</h3>
						<p>300.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
				<div class="products1">
					<div class="products_img">
						<img src="img/arabica.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Arabica</h3>
						<p>250.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
				<div class="products1">
					<div class="products_img">
						<img src="img/Culi.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Culi</h3>
						<p>200.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
				<div class="products1">
					<div class="products_img">
						<img src="img/mocas16.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Moca cầu đất s16</h3>
						<p>550.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
				<div class="products1">
					<div class="products_img">
						<img src="img/mocas168jpeg.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Moca cầu đất s18</h3>
						<p>750.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
				<div class="products1">
					<div class="products_img">
						<img src="img/Cherry.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Cherry</h3>
						<p>200.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
				<div class="products1">
					<div class="products_img">
						<img src="img/Catimor.jpg" alt="">
					</div>
					<div class="products_name">
						<h3>hạt cà phê Catimor</h3>
						<p>200.000đ/1kg</p>
					</div>
					<div class="products_buttons"></div>
				</div>
			</div>
		</div>

	</div>

	<footer
		style="margin-top: 40px; background-color: #fff; color: black; padding: 20px; text-align: center;">
		<div style="max-width: 1200px; margin: auto;">
			<div style="margin-bottom: 20px;">
				<h3>Coffee Shop</h3>
				<p>Chúng tôi mang đến những hạt cà phê chất lượng nhất.</p>
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
			<div style="margin-top: 20px;">
				<p>&copy; 2024 Coffee Shop. All Rights Reserved.</p>
			</div>
		</div>

	</footer>

	<script>
		let slide3Index = 1;
		showSlides3(slide3Index);

		function plusSlides3(n) {
			showSlides3(slide3Index += n);
		}

		function currentSlide3(n) {
			showSlides3(slide3Index = n);
		}

		function showSlides3(n) {
			let i;
			let slides = document.getElementsByClassName("about_aboutSlides");
			if (n > slides.length) {
				slide3Index = 1
			}
			if (n < 1) {
				slide3Index = slides.length
			}
			for (i = 0; i < slides.length; i++) {
				slides[i].style.display = "none";
			}

			slides[slide3Index - 1].style.display = "block";
		};
	</script>

</body>
</html>