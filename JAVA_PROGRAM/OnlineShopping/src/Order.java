import java.util.List;

public class Order {
    private int orderId;
    private Customer customer;  // Relationship with Customer
    private String shippingAddress;
    private String status;
    private List<OrderItem> orderItems;  // Contains relationship
    private Payment payment;  // One-to-One relationship with Payment

    // Constructor
    public Order(int orderId, Customer customer, String shippingAddress, String status, List<OrderItem> orderItems, Payment payment) {
        this.orderId = orderId;
        this.customer = customer;
        this.shippingAddress = shippingAddress;
        this.status = status;
        this.orderItems = orderItems;
        this.payment = payment;
    }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<OrderItem> getOrderItems() { return orderItems; }
    public void setOrderItems(List<OrderItem> orderItems) { this.orderItems = orderItems; }

    public Payment getPayment() { return payment; }
    public void setPayment(Payment payment) { this.payment = payment; }

    @Override
    public String toString() {
        return "Order for Customer: " + customer.getFirstName() + " " + customer.getLastName();
    }
}
