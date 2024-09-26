# SQL_Project_OnlineShoppingCart

## Overview

This project is an **Online Shopping Cart** system using **PostgreSQL** as the database backend and **Java** as the application layer. It allows customers to browse products, add them to a cart, place orders, and manage payments. Managers can manage products, update stock, view orders, and handle customer and product records.

## Features

### Customer Features:
- **Register** and log in as a customer.
- **Browse** available products.
- **Add items** to a shopping cart.
- **Place orders** with payment management.
- **View order history** and track status.

### Manager Features:
- **Log in** as a manager.
- **Add, update, and delete** products.
- **Manage stock** levels.
- **View and update** order statuses.
- **Access all customer orders** for management.

## Technologies Used

- **PostgreSQL**: Relational database for storing data.
- **Java**: Application layer to interact with the database.
- **PL/pgSQL**: Stored procedures and triggers for database management.

## Database Structure

- **Customer**: Stores customer details like name, email, address.
- **Product**: Stores product details including name, price, stock, and category.
- **Order**: Manages orders placed by customers and their statuses.
- **Order_Item**: Tracks individual items within an order.
- **Manager**: Stores manager details to handle product and order management.
- **Payment**: Manages payments for customer orders.
- **Logs**: Automatically logs changes in **Customer** and **Product** records via triggers.

## Stored Procedures and Triggers

- **Stored Procedures**: Handle customer, product, and order operations such as adding, updating, and deleting records. Includes transaction handling with rollbacks.
- **Triggers**: Automatically log changes (insert, update, delete) for customer and product records in dedicated log tables.

## Setup Instructions

### Prerequisites
- **PostgreSQL** installed.
- **Java** development environment (e.g., IntelliJ, Eclipse).
- **Git** for version control.
