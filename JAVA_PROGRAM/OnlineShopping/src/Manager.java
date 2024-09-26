public class Manager {
    private int managerId;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String role;  // Missing role attribute added

    // Constructor
    public Manager(int managerId, String firstName, String lastName, String email, String phone, String role) {
        this.managerId = managerId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.role = role;
    }

    // Getters and Setters
    public int getManagerId() { return managerId; }
    public void setManagerId(int managerId) { this.managerId = managerId; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRole() { return role; }  // Getter for role
    public void setRole(String role) { this.role = role; }  // Setter for role

    @Override
    public String toString() {
        return "Manager: " + firstName + " " + lastName + ", Role: " + role;
    }
}
