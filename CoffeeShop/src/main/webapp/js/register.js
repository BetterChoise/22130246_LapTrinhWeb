document
	.getElementById('form-1')
	.addEventListener(
		'submit',
		function(event) {
			const username = document
				.getElementById('username').value;
			const password = document
				.getElementById('password').value;
			const re_password = document
				.getElementById('re_password').value;
			const message = document.getElementById('message');
			message.textContent = "";

			// Validate username
			if (/\s/.test(username)) {
				event.preventDefault();
				message.textContent = "Username must not contain whitespace.";
				message.className = "invalid";
				return;
			}
			if (username.trim() === "") {
				event.preventDefault();
				message.textContent = "Username cannot be empty.";
				message.className = "invalid";
				return false;
			}

			if (username.length < 5) {
				event.preventDefault();
				message.textContent = "Username must be at least 5 characters long.";
				message.className = "invalid";
				return false;
			}

			if (/[^a-zA-Z0-9]/.test(username)) {
				event.preventDefault();
				message.textContent = "Username can only contain letters and numbers.";
				message.className = "invalid";
				return false;
			}

			// Validate password
			if (password.length < 8) {
				event.preventDefault();
				message.textContent = "Password must be at least 8 characters long.";
				message.className = "invalid";
				return;
			}
			/*	if (!/[A-Z]/.test(password)) {
					event.preventDefault();
					message.textContent = "Password must contain at least one uppercase letter.";
					message.className = "invalid";
					return;
				}*/
			if (!/[a-z]/.test(password)) {
				event.preventDefault();
				message.textContent = "Password must contain at least one lowercase letter.";
				message.className = "invalid";
				return;
			}
			if (!/[0-9]/.test(password)) {
				event.preventDefault();
				message.textContent = "Password must contain at least one digit.";
				message.className = "invalid";
				return;
			}/*
			if (!/[@$!%*?&]/.test(password)) {
				event.preventDefault();
				message.textContent = "Password must contain at least one special character.";
				message.className = "invalid";
				return;
			}*/
			if (/\s/.test(password)) {
				event.preventDefault();
				message.textContent = "Password must not contain whitespace.";
				message.className = "invalid";
				return;
			}

			//validate re_password
			if (password != re_password) {
				event.preventDefault();
				message.textContent = " Mật khẩu xác nhận không trùng khớp ";
				message.className = "invalid";
				return;
			}

			message.textContent = "Form is valid! Submitting...";
			message.className = "valid";
		});