/*Create a virtual table to summarize data*/
/*Task 1
In the first task, Little Lemon need you to create a virtual table called OrdersView that focuses on OrderID,
Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2. */

CREATE VIEW OrdersView AS 
SELECT OrderID, TotalCost, Quantity 
FROM orders WHERE Quantity > 2;


/*Task 2
For your second task, Little Lemon need information from four tables on all customers with orders that cost more than $150. Extract the required information from each of the following tables by using the relevant JOIN clause: 

Customers table: The customer id and full name.

Orders table: The order id and cost.

Menus table: The menus name.

MenusItems table: course name and starter name.*/

CREATE VIEW CustomersView AS 
SELECT customers.CustomerID, customers.Name,
orders.OrderID, orders.TotalCost,
menu.MenuName, menuitems.Courses, menuitems.starters
FROM customers 
INNER JOIN orders ON customers.CustomerID = orders.Customers_CustomerID
INNER JOIN menu ON orders.Menu_MenuID
INNER JOIN menuitems ON menuitems.MenuItemsID = menu.MenuItems_MenuItemsID
WHERE orders.TotalCost > 150
ORDER BY orders.TotalCost ASC;


/*Task 3
For the third and final task, Little Lemon need you to find all menu items for 
which more than 2 orders have been placed.You can carry out this task by creating a subquery that lists 
the menu names from the menus table for any order quantity with more than 2.*/

CREATE VIEW ItemsView AS
SELECT menu.MenuName FROM menu JOIN orders
ON menu.MenuID = orders.Menu_MenuID
WHERE orders.OrderID = ANY(SELECT OrderID FROM Orders WHERE Quantity > 2);

/* Create optimized queries to manage and analyze data*/
/*Task 1
In this first task, Little Lemon need you to create a procedure that displays
the maximum ordered quantity in the Orders table. */

DELIMITER //
CREATE PROCEDURE GetMaxQuantity()
BEGIN SELECT MAX(Quantity)
FROM Orders;
END//
DELIMITER ;

/*Task 2
In the second task, Little Lemon need you to help them to create a prepared statement called GetOrderDetail. This prepared statement will help to reduce the parsing time of queries. It will also help to secure the database from SQL injections.

The prepared statement should accept one input argument, the CustomerID value, from a variable. 

The statement should return the order id, the quantity and the order cost from the Orders table. 

Once you create the prepared statement, you can create a variable called id and assign it value of 1. 

Then execute the GetOrderDetail prepared statement using the following syntax:*/

PREPARE GetOrderDetail FROM 'SELECT orders.OrderID, orders.Quantity, orders.TotalCost FROM orders JOIN customers WHERE customers.CustomerID = ?';

/*Task 3
Your third and final task is to create a stored procedure called CancelOrder. Little Lemon want to use this stored procedure to delete 
an order record based on the user input of the order id.*/

DELIMITER //
CREATE PROCEDURE CancelOrder(IN custID INT)
BEGIN
DELETE FROM customers WHERE CustomerID = custID;
SELECT CONCAT("Order ",custID," has been removed") AS "Cancellations";
END
DELIMITER ;
