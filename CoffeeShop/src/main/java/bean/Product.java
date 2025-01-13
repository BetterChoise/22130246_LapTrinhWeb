package bean;

import java.math.BigDecimal;

public class Product {
	String product_id;
	String name;
	String description;
	BigDecimal price;
	int stock;
	String category_id;

	public Product(String product_id, String name, String description, BigDecimal price, String category_id,
			int stock) {
		this.product_id = product_id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.stock = stock;
		this.category_id = category_id;
	}

	public String getProduct_id() {
		return product_id;
	}

	public void setProduct_id(String product_id) {
		this.product_id = product_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getCategory_id() {
		return category_id;
	}

	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	@Override
	public String toString() {
		return "Product [product_id=" + product_id + ", name=" + name + ", price=" + price + ", stock=" + stock
				+ ", category_id=" + category_id + "]";
	}
}
