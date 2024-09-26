import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ManagerDAO {

    // Method to get a manager by their email
    public Manager getManagerByEmail(String email) {
        String sql = "SELECT * FROM Manager WHERE email = ?";
        Manager manager = null;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                manager = new Manager(
                        rs.getInt("manager_id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return manager;
    }

    // Method to add a manager (for example)
    public void addManager(String firstName, String lastName, String email, String phone, String role) {
        String sql = "CALL add_manager(?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, email);
            stmt.setString(4, phone);
            stmt.setString(5, role);

            stmt.executeUpdate();
            System.out.println("Manager added successfully!");

        } catch (SQLException e) {
            if (e.getMessage().contains("already exists")) {
                System.out.println("Manager with email " + email + " already exists.");
            } else {
                e.printStackTrace();
            }
        }
    }

    // Method to update manager's role
    public void updateManagerRole(int managerId, String newRole) {
        String sql = "CALL update_manager_role(?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, managerId);
            stmt.setString(2, newRole);

            stmt.executeUpdate();
            System.out.println("Manager role updated successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to delete a manager
    public void deleteManager(int managerId) {
        String sql = "CALL delete_manager(?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, managerId);
            stmt.executeUpdate();

            System.out.println("Manager deleted successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
