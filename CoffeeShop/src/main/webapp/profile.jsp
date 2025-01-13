<%@page import="bean.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/profile.css">
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
					<li><a class="menu_infor navbar_item" href="infor.html">
							thông tin</a></li>
					<li><a class="menu_product navbar_item"
						href="allproducts.html">mua sắm</a></li>
					<li><a class="menu_cotrac navbar_item" href="shoppingCart.jsp">giỏ
							hàng</a></li>
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
	<div class="profile_block">
		<div class="profile_main">
			<form method="POST" class="profile" id="profile">
				<h1>Hồ sơ của tôi</h1>
				<h4>Quản lý thông tin người dùng</h4>
				<div class="profile-container">
					<%
					User user = (User) session.getAttribute("user");
					String full_name = "";
					String address = "";
					String email = "";
					String phone = "";
					if (user.getFull_name() != null) {
						full_name = user.getFull_name();
					}
					if (user.getAddress() != null) {
						address = user.getAddress();
					}
					if (user.getEmail() != null) {
						email = user.getEmail();
					}
					if (user.getPhone() != null) {
						phone = user.getPhone();
					}
					%>
					<div class="login-name">
						<div class="login_name">
							<p>Họ và tên</p>
						</div>
						<input type="text" class="login-name_data" name="full_name"
							value="<%=full_name%>"></input>
					</div>
					<div class="Address">
						<div class="locate">
							<p>Địa chỉ</p>
						</div>
						<input type="text" class="locate_data" name="address"
							value="<%=address%>"></input>
					</div>
					<div class="phone">
						<div class="phone-number">
							<p>Số điện thoại</p>
						</div>
						<input type="text" class="phonenuber_data" name="phone"
							value="<%=phone%>"></input>
					</div>
					<div class="email">
						<div class="email-header">
							<p>Email</p>
						</div>
						<input type="text" class="email_data" name="email"
							value="<%=email%>"></input>
					</div>
					<div class="save">
						<button type="submit" class="save_button">lưu</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</body>
</html>