import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // Method to view all products in the store
    public List<Product> viewAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("All Products:");
            while (rs.next()) {
                int productId = rs.getInt("product_id");
                String productName = rs.getString("product_name");
                String description = rs.getString("description");
                double price = rs.getDouble("price");
                int stockQuantity = rs.getInt("stock_quantity");

                System.out.println("Product ID: " + productId +
                        ", Name: " + productName +
                        ", Description: " + description +
                        ", Price: $" + price +
                        ", Stock: " + stockQuantity);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    // Method to get a product by its ID
    public Product getProductById(int productId) {
        String sql = "SELECT * FROM Product WHERE product_id = ?";
        Product product = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                product = new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return product;
    }

    // Method to add stock to an existing product
    public void addStock(int productId, int quantityToAdd) {
        String sql = "UPDATE Product SET stock_quantity = stock_quantity + ? WHERE product_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, quantityToAdd);
            stmt.setInt(2, productId);
            stmt.executeUpdate();

            System.out.println("Stock updated successfully for product ID: " + productId);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
