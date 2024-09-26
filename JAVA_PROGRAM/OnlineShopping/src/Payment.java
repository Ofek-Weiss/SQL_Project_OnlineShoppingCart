public class Payment {
    private int paymentId;
    private String paymentMethod;
    private double amountPaid;

    // Constructor
    public Payment(int paymentId, String paymentMethod, double amountPaid) {
        this.paymentId = paymentId;
        this.paymentMethod = paymentMethod;
        this.amountPaid = amountPaid;
    }

    // Getters and Setters
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public double getAmountPaid() { return amountPaid; }
    public void setAmountPaid(double amountPaid) { this.amountPaid = amountPaid; }

    @Override
    public String toString() {
        return "Payment: " + paymentMethod + ", Amount: " + amountPaid;
    }
}
