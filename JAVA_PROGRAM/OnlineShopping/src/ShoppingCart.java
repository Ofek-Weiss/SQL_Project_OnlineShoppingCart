import java.util.HashMap;
import java.util.Map;

public class ShoppingCart {
    private Map<Product, Integer> cartItems = new HashMap<>();

    // Add a product to the cart
    public void addProductToCart(Product product, int quantity) {
        cartItems.put(product, cartItems.getOrDefault(product, 0) + quantity);
        System.out.println("Product added to cart: " + product.getProductName() + " - Quantity: " + quantity);
    }

    // View the items in the cart
    public void viewCart() {
        if (cartItems.isEmpty()) {
            System.out.println("Your cart is empty.");
        } else {
            System.out.println("Your Cart:");
            for (Map.Entry<Product, Integer> entry : cartItems.entrySet()) {
                Product product = entry.getKey();
                Integer quantity = entry.getValue();
                System.out.println(product.getProductName() + " - Quantity: " + quantity + " - Price per item: $" + product.getPrice());
            }
        }
    }

    // Get the cart items (returns the map)
    public Map<Product, Integer> getCartItems() {
        return cartItems;
    }

    // Clear the cart after an order is placed
    public void clearCart() {
        cartItems.clear();
        System.out.println("Cart has been cleared.");
    }
}
