SQL_Project_OnlineShoppingCart
Overview
This project is an Online Shopping Cart system using PostgreSQL. It allows customers to browse products, add them to a cart, place orders, and manage payments. Managers can handle products, update stock, view orders, and manage customer and product records.

Features
Customer Features:
Register and log in.
Browse products.
Add items to a cart.
Place orders.
View order history.
Manager Features:
Log in as a manager.
Add, update, and delete products.
Manage stock.
View all customer orders.
Update order statuses.
Technologies Used
PostgreSQL: Database management.
Java: Backend for handling database operations.
PL/pgSQL: Stored procedures and triggers.
Database Structure
Customer: Customer information.
Product: Product details.
Order: Manages orders and their statuses.
Order_Item: Tracks individual items in orders.
Manager: Manages product and order operations.
Payment: Payment management.
Logs: Logs changes to customer and product records.
Stored Procedures and Triggers
Stored Procedures: Add, update, and delete records for customers, products, orders, and managers. Rollback on errors.
Triggers: Automatically log insert, update, and delete operations for Customer and Product.
