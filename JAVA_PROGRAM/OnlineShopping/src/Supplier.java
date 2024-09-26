public class Supplier {
    private int supplierId;
    private String supplierName;
    private String contactName;
    private String phone;
    private String address;
    private Manager manager;  // CoordinatesWith relationship

    // Constructor
    public Supplier(int supplierId, String supplierName, String contactName, String phone, String address, Manager manager) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.contactName = contactName;
        this.phone = phone;
        this.address = address;
        this.manager = manager;
    }

    // Getters and Setters
    public int getSupplierId() { return supplierId; }
    public void setSupplierId(int supplierId) { this.supplierId = supplierId; }

    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }

    public String getContactName() { return contactName; }
    public void setContactName(String contactName) { this.contactName = contactName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Manager getManager() { return manager; }
    public void setManager(Manager manager) { this.manager = manager; }

    @Override
    public String toString() {
        return "Supplier: " + supplierName + ", Contact: " + contactName;
    }
}
