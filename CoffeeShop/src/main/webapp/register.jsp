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
</head>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.register-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.8);
	width: 400px;
}

.register-container h2 {
	margin-bottom: 20px;
	text-align: center;
	color: #333;
}

.register-container label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

.register-container input {
	width: 379px;
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.register-container .register-buttom {
	width: 100%;
	padding: 10px;
	background-color: #5cb85c;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
}

.register-container .register-buttom:hover {
	background-color: #4cae4c;
}

.register-container a {
	display: block;
	text-align: center;
	margin-top: 10px;
	color: #007bff;
	text-decoration: none;
}

.register-container a:hover {
	text-decoration: underline;
}

.arrow {
	height: 30px;
	width: 30px;
}

.arrow a i {
	width: 30px;
	height: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
}

.arrow a {
	color: black;
	border-radius: 50%;
	margin-top: 0;
}

.arrow a:hover {
	background-color: rgba(0, 0, 0, 0.4);
	text-decoration: none;
}

.valid {
	color: green;
}
.invalid {
	color: red;
}
</style>
<body>
	<div class="register-container">
		<form action="register" method="POST" class="form" id="form-1">
			<div class="arrow">
				<a href="index.jsp"><i class="fa-solid fa-arrow-left"></i> </a>
			</div>
			<h2>Đăng kí</h2>
			<div>
				<label for="username">Tên đăng nhập</label> <input class="username"
					type="text" id="username" name="username"
					placeholder="Nhập tên đăng nhập" required> <label
					for="email">Email</label> <input type="email" class="email"
					id="email" name="email" placeholder="Nhập email của bạn" required>

				<label for="password"> Mật khẩu</label> <input type="password"
					class="password" id="password" name="password"
					placeholder="Nhập mật khẩu" required> <label for="password">Nhập
					lại mật khẩu</label> <input type="password" class="password"
					id="re_password" name="re_password" placeholder="Nhập lại mật khẩu"
					required>
				<p id="message"></p>
				<button type="submit" class="register-buttom" type="submit">Đăng
					kí</button>
			</div>
			<a href="login.jsp">Đã có tài khoản? Đăng nhập!</a>
		</form>
	</div>
	<script src="js/register.js" type="text/javascript"></script>
</body>
</html>