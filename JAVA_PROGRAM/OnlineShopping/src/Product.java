public class Product {
    private int productId;
    private String productName;
    private String description;
    private double price;
    private int stockQuantity;

    // Constructor
    public Product(int productId, String productName, String description, double price, int stockQuantity) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
    }

    // Getters
    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    // Optionally, add a toString method to easily print product details
    @Override
    public String toString() {
        return "Product ID: " + productId + ", Name: " + productName + ", Price: $" + price + ", Stock: " + stockQuantity;
    }
}
