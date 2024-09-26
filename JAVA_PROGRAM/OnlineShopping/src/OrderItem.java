public class OrderItem {
    private int orderItemId;
    private Product product;
    private int quantity;
    private double priceAtPurchase;

    // Constructor that only takes Product and quantity
    public OrderItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
        this.priceAtPurchase = product.getPrice();  // Set the price at the time of adding to cart
    }

    // Constructor that takes all four parameters
    public OrderItem(int orderItemId, Product product, int quantity, double priceAtPurchase) {
        this.orderItemId = orderItemId;
        this.product = product;
        this.quantity = quantity;
        this.priceAtPurchase = priceAtPurchase;
    }

    // Getters and setters
    public Product getProduct() {
        return product;
    }

    public int getQuantity() {
        return quantity;
    }

    public double getPriceAtPurchase() {
        return priceAtPurchase;
    }
}
