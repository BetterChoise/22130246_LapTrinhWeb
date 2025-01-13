package bean;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Cart {
	List<Product> cart;
	User user;

	public Cart() {
		this.cart = new ArrayList<Product>();
	}

	public boolean updateUserShoppingCart(Map<String, Integer> newShoppingCart) throws SQLException {
		Map<Product, Integer> userShopingCart = getUserShoppingCart();

		for (String product_id : newShoppingCart.keySet()) {
			for (Product product : userShopingCart.keySet()) {
				if (product_id.equals(product.getProduct_id())) {
					int newQuantity = newShoppingCart.get(product_id);
					int oldQuantity = userShopingCart.get(product);
					if (newQuantity < oldQuantity) {
						for (int i = 0; i < (oldQuantity - newQuantity); i++) {
							removeFromCart(product);
						}
						break;
					}
					if (newQuantity > oldQuantity) {
						for (int i = 0; i < (newQuantity - oldQuantity); i++) {
							addToCart(product);
						}
						break;
					} else {
						break;
					}
				}
			}
		}

		return true;
	}

	public Map<Product, Integer> getUserShoppingCart() throws SQLException {
		Map<Product, Integer> shoppingCart = new HashMap<Product, Integer>();
		Map<String, Integer> shoppingCart_withId = new HashMap<String, Integer>();

		for (Product pr : cart) {
			shoppingCart_withId.put(pr.getProduct_id(), shoppingCart_withId.getOrDefault(pr.getProduct_id(), 0) + 1);
		}
		for (Product pr : cart) {
			shoppingCart.put(pr, shoppingCart_withId.get(pr.getProduct_id()));
		}
		return shoppingCart;
	}

	public void addToCart(Product pr) {
		cart.add(pr);
	}

	public void removeAllFromCart(Product pr) {
		for (Product product : cart) {
			if (product.getProduct_id().equals(pr.getProduct_id())) {
				removeFromCart(product);
			}
		}
	}

	public void removeFromCart(Product pr) {
		cart.remove(pr);
	}

	@Override
	public String toString() {
		return "Cart [cart=" + cart + ", user=" + user + "]";
	}

	public List<Product> getCart() {
		return cart;
	}

	public void setCart(List<Product> cart) {
		this.cart = cart;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
