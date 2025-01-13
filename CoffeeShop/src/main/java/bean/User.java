package bean;

public class User {
	String user_id;
	String account_id;
	String email;
	String phone;
	String address;
	String full_name;

	public User() {
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getAccount_id() {
		return account_id;
	}

	public void setAccount_id(String account_id) {
		this.account_id = account_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getFull_name() {
		return full_name;
	}

	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}

	@Override
	public String toString() {
		return "User [user_id=" + user_id + ", account_id=" + account_id + ", email=" + email + ", phone=" + phone
				+ ", address=" + address + ", full_name=" + full_name + "]";
	}
}
