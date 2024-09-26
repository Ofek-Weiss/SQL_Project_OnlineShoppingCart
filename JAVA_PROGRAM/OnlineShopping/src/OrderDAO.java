import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public class OrderDAO {

    public void viewAllOrders() {
        String sql = "SELECT * FROM \"Order\"";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            System.out.println("All Orders:");
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int customerId = rs.getInt("customer_id");
                String orderDate = rs.getString("order_date");
                String status = rs.getString("status");
                double totalAmount = rs.getDouble("total_amount");

                System.out.println("Order ID: " + orderId +
                        ", Customer ID: " + customerId +
                        ", Order Date: " + orderDate +
                        ", Total Amount: $" + totalAmount +
                        ", Status: " + status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void changeOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE \"Order\" SET status = ? WHERE order_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                System.out.println("Order ID: " + orderId + " status changed to: " + newStatus);
            } else {
                System.out.println("Order ID: " + orderId + " not found.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to place an order
    public void placeOrder(Customer customer, ShoppingCart cart) {
        String insertOrderSQL = "INSERT INTO \"Order\" (customer_id, order_date, shipping_address, total_amount, status) VALUES (?, CURRENT_DATE, ?, ?, 'pending') RETURNING order_id";
        String insertOrderItemSQL = "INSERT INTO Order_Item (order_id, product_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)";
        String updateStockSQL = "UPDATE Product SET stock_quantity = stock_quantity - ? WHERE product_id = ?"; // New SQL to update stock
        int newOrderId = 0;
        double totalAmount = calculateTotalAmount(cart);

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement insertOrderStmt = conn.prepareStatement(insertOrderSQL, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // Insert the order
            insertOrderStmt.setInt(1, customer.getCustomerId());
            insertOrderStmt.setString(2, customer.getAddress());
            insertOrderStmt.setDouble(3, totalAmount);
            insertOrderStmt.executeUpdate();

            // Retrieve the generated order ID
            ResultSet rs = insertOrderStmt.getGeneratedKeys();
            if (rs.next()) {
                newOrderId = rs.getInt(1);
            }

            // Insert order items and update stock
            try (PreparedStatement insertOrderItemStmt = conn.prepareStatement(insertOrderItemSQL);
                 PreparedStatement updateStockStmt = conn.prepareStatement(updateStockSQL)) {

                for (Map.Entry<Product, Integer> entry : cart.getCartItems().entrySet()) {
                    Product product = entry.getKey();
                    Integer quantity = entry.getValue();

                    // Insert into Order_Item table
                    insertOrderItemStmt.setInt(1, newOrderId);
                    insertOrderItemStmt.setInt(2, product.getProductId());
                    insertOrderItemStmt.setInt(3, quantity);
                    insertOrderItemStmt.setDouble(4, product.getPrice());
                    insertOrderItemStmt.executeUpdate();

                    // Update stock quantity in Product table
                    updateStockStmt.setInt(1, quantity);
                    updateStockStmt.setInt(2, product.getProductId());
                    updateStockStmt.executeUpdate();

                    System.out.println("Ordered product: " + product.getProductName() + ", Quantity: " + quantity);
                    System.out.println("Stock updated for product: " + product.getProductName() + ", New stock: " + (product.getStockQuantity() - quantity));
                }
            }

            System.out.println("Order placed successfully with Order ID: " + newOrderId);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to view order history for a customer
    public void viewOrderHistory(Customer customer) {
        String query = "SELECT order_id, total_amount, status FROM \"Order\" WHERE customer_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, customer.getCustomerId());
            ResultSet rs = stmt.executeQuery();

            System.out.println("Order History for " + customer.getFirstName() + " " + customer.getLastName() + ":");
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                double totalAmount = rs.getDouble("total_amount");
                String status = rs.getString("status");
                System.out.println("Order ID: " + orderId + " | Total Amount: $" + totalAmount + " | Status: " + status);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Helper method to calculate the total order amount
    private double calculateTotalAmount(ShoppingCart cart) {
        double total = 0;
        for (Map.Entry<Product, Integer> entry : cart.getCartItems().entrySet()) {
            Product product = entry.getKey();
            int quantity = entry.getValue();
            total += product.getPrice() * quantity;
        }
        return total;
    }
}
