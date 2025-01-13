<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>đăng nhập</title>
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

.login-container {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 5px 10px rgba(0, 0, 0, 0.8);
	width: 400px;
}

.login-container h2 {
	margin-bottom: 20px;
	text-align: center;
	color: #333;
}

.login-container label {
	display: block;
	font-weight: bold;
}

.login-container .username, .login-container .password {
	width: 379px;
	padding: 10px;
	margin-bottom: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.login-container .submitBtn {
	width: 400px;
	padding: 10px;
	background-color: #5cb85c;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 16px;
	cursor: pointer;
	margin-top: 20px;
}

.login-container .submitBtn:hover {
	background-color: #4cae4c;
}

.login-container a {
	display: block;
	text-align: center;
	margin-top: 10px;
	color: #007bff;
	text-decoration: none;
}

.login-container a:hover {
	text-decoration: underline;
}

.form-group {
	margin-top: 20px;
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
	<div class="login-container">
		<form action="login" method="POST" class="form" id="form-1">
			<div class="arrow">
				<a href="index.jsp"><i class="fa-solid fa-arrow-left"></i> </a>
			</div>
			<h2>Login</h2>

			<div class="form-group">
				<label for="username">Username</label> <input class="username"
					name="username" id="username" placeholder="Enter your username">
				<span class="form-message"></span>
			</div>
			<div class="form-group">
				<label for="password">Password</label> <input type="password"
					class="password" name="password" id="password"
					placeholder="Enter your password">
				<p id="message"></p>
			</div>
			<input type="submit" class="submitBtn" id="validateBtn" value="Login">
			<div class="register">
				<a href="register.jsp">Chưa có tài khoản? Đăng kí ngay! </a>
			</div>
		</form>
	</div>
	<script src="js/login.js" type="text/javascript"></script>
</body>
</html>