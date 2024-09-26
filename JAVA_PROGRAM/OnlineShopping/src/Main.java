import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        CustomerDAO customerDAO = new CustomerDAO();
        ManagerDAO managerDAO = new ManagerDAO();
        ProductDAO productDAO = new ProductDAO();  // To manage products
        OrderDAO orderDAO = new OrderDAO();        // To manage orders
        ShoppingCart cart = new ShoppingCart();    // To hold customer cart items

        // Step 1: Login or Register
        System.out.println("Are you logging in as a Manager or Customer? (Enter 'Manager' or 'Customer')");
        String role = scanner.nextLine();

        if (role.equalsIgnoreCase("Manager")) {
            // Manager login
            System.out.println("Enter Manager email:");
            String managerEmail = scanner.nextLine();
            Manager manager = managerDAO.getManagerByEmail(managerEmail);

            if (manager != null) {
                showManagerMenu(scanner, managerDAO, productDAO, orderDAO); // Manager Menu
            } else {
                System.out.println("Manager not found.");
            }
        } else {
            // Customer login or registration
            System.out.println("Enter your email to log in or register:");
            String email = scanner.nextLine();
            Customer customer = customerDAO.getCustomerByEmail(email);

            if (customer == null) {
                System.out.println("Customer not found. Please register.");
                System.out.println("Enter your first name:");
                String firstName = scanner.nextLine();
                System.out.println("Enter your last name:");
                String lastName = scanner.nextLine();
                System.out.println("Enter your phone number:");
                String phone = scanner.nextLine();
                System.out.println("Enter your address:");
                String address = scanner.nextLine();

                customerDAO.addCustomer(firstName, lastName, email, phone, address);
                customer = customerDAO.getCustomerByEmail(email); // Retrieve after registration
            }

            showCustomerMenu(scanner, customer, productDAO, orderDAO, cart); // Customer Menu
        }
    }

    // Manager Menu
    private static void showManagerMenu(Scanner scanner, ManagerDAO managerDAO, ProductDAO productDAO, OrderDAO orderDAO) {
        boolean running = true;
        while (running) {
            System.out.println("\nManager Menu:");
            System.out.println("1. Add quantity to stock");
            System.out.println("2. View all orders");
            System.out.println("3. Change order status");
            System.out.println("4. View all products");
            System.out.println("5. Exit");

            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();  // Consume newline

            switch (choice) {
                case 1:
                    // Add quantity to stock
                    System.out.println("Enter product ID to update stock:");
                    int productId = scanner.nextInt();
                    scanner.nextLine();  // Consume newline
                    System.out.println("Enter quantity to add:");
                    int quantityToAdd = scanner.nextInt();
                    scanner.nextLine();  // Consume newline
                    productDAO.addStock(productId, quantityToAdd);
                    break;

                case 2:
                    // View all orders
                    orderDAO.viewAllOrders();
                    break;

                case 3:
                    // Change order status
                    System.out.println("Enter order ID to change status:");
                    int orderId = scanner.nextInt();
                    scanner.nextLine();  // Consume newline
                    System.out.println("Enter new status (e.g., shipped, completed):");
                    String newStatus = scanner.nextLine();
                    orderDAO.changeOrderStatus(orderId, newStatus);
                    break;

                case 4:
                    // View all products
                    productDAO.viewAllProducts();
                    break;

                case 5:
                    // Exit
                    running = false;
                    break;

                default:
                    System.out.println("Invalid choice. Try again.");
                    break;
            }
        }
    }

    // Customer Menu
    private static void showCustomerMenu(Scanner scanner, Customer customer, ProductDAO productDAO, OrderDAO orderDAO, ShoppingCart cart) {
        boolean running = true;
        while (running) {
            System.out.println("\nCustomer Menu:");
            System.out.println("1. Browse Products");
            System.out.println("2. Add Product to Cart");
            System.out.println("3. View Cart");
            System.out.println("4. Place Order");
            System.out.println("5. View Order History");
            System.out.println("6. Exit");

            System.out.print("Enter your choice: ");
            int choice = scanner.nextInt();
            scanner.nextLine();  // Consume newline

            switch (choice) {
                case 1:
                    // Browse products
                    productDAO.viewAllProducts();
                    break;

                case 2:
                    // Add product to cart
                    System.out.println("Enter product ID:");
                    int productId = scanner.nextInt();
                    System.out.println("Enter quantity:");
                    int quantity = scanner.nextInt();
                    Product product = productDAO.getProductById(productId);
                    cart.addProductToCart(product, quantity);
                    break;

                case 3:
                    // View cart
                    cart.viewCart();
                    break;

                case 4:
                    // Place order
                    orderDAO.placeOrder(customer, cart);
                    cart.clearCart();
                    break;

                case 5:
                    // View order history
                    orderDAO.viewOrderHistory(customer);
                    break;

                case 6:
                    // Exit
                    running = false;
                    break;

                default:
                    System.out.println("Invalid choice. Try again.");
                    break;
            }
        }
    }
}
