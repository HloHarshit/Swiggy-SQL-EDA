# Swiggy SQL Data Analysis

This repository contains the code and documentation for an Exploratory Data Analysis (EDA) of Swiggy data using SQL queries in Python via the `mysql-connector` module. The data is stored in a MySQL database.

## Dataset: [Link](Data)

The dataset comprises multiple tables in the database. Here are the details of the tables used for this analysis:

### Table: users
- **user_id**: User ID.
- **name**: User's name.
- **email**: User's email.
- **password**: User's password.

### Table: restaurants
- **r_id**: Restaurant ID.
- **r_name**: Restaurant name.
- **cuisine**: Cuisine type.

### Table: orders
- **order_id**: Order ID.
- **user_id**: User ID.
- **r_id**: Restaurant ID.
- **amount**: Order amount.
- **date**: Order date.
- **partner_id**: Delivery partner ID.
- **delivery_time**: Delivery time.
- **delivery_rating**: Delivery rating.
- **restaurant_rating**: Restaurant rating.

### Table: order_details
- **id**: Detail ID.
- **order_id**: Order ID.
- **f_id**: Food ID.

### Table: menu
- **menu_id**: Menu ID.
- **r_id**: Restaurant ID.
- **f_id**: Food ID.
- **price**: Food price.

### Table: food
- **f_id**: Food ID.
- **f_name**: Food name.
- **type**: Food type.

### Table: delivery_partner
- **partner_id**: Delivery partner ID.
- **partner_name**: Delivery partner name.

## EDA Files

[swiggy.ipynb](swiggy.ipynb): Jupyter Notebook containing the Python code for the exploratory data analysis of the Swiggy data using SQL queries.

[swiggy solution (SQL code).sql](swiggy%20solution%20(SQL%20code).sql): MySQL script containing the queries for the exploratory data analysis of the Swiggy data.

## Usage

You can clone this repository to your local machine and run the Jupyter Notebook to perform the SQL-based EDA. Ensure you have a MySQL server set up with the necessary database containing the required tables.

```bash
git clone https://github.com/HloHarshit/Swiggy-SQL-EDA.git
cd Swiggy-SQL-EDA
jupyter notebook swiggy.ipynb
```