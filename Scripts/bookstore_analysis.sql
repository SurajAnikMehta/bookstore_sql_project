
/* 
===================================================================
Data Vaildiation Null, duplicate checked
===================================================================
*/

SELECT * from bookstore.books
where book_id is null or title is null or Genre is null or published_year is null or price is null or stock is null

Select * from bookstore.customers
--where customer_id is null or name is null or email is null or phone is null or city is null or country is null

Select * from bookstore.orders
where order_id is null or customer_id is null or book_id is null or order_date is null or quantity is null or total_amount is null


/* 
===================================================================
Practice questions
===================================================================
*/

-- 1) Retrieve all books in the "Fiction" genre
Select * from bookstore.books
Where genre = 'Fiction';

-- 2) Find books published after the year 1950
Select Title, Year(published_year) from bookstore.books
where year(published_year) = 1950;

-- 3) List all customers from the Canada
Select * from bookstore.customers
where country = 'Canada'

-- 4) Show orders placed in November 2023
select *, Datetrunc(month,order_date) as yr_mnth from bookstore.Orders
where Datetrunc(month,order_date) = '2023-11-01'

-- 5) Retrieve the total stock of books available
Select Title,Stock from bookstore.books
where stock >  0

-- 6) Find the details of the most expensive book
Select top 10 Title,price,Stock from bookstore.books
order by price desc

-- 7) Show all customers who ordered more than 1 quantity of a book
Select c.Name, c.city, o.Quantity, o.total_amount from
bookstore.orders o left join bookstore.customers c
on o.customer_id = c.customer_id 
where o.quantity > 1

-- 8) Retrieve all orders where the total amount exceeds $20
Select c.Name, c.city, o.Quantity, o.total_amount from
bookstore.orders o left join bookstore.customers c
on o.customer_id = c.customer_id 
where o.total_amount > 20

-- 9) List all genres available in the Books table
select distinct genre from bookstore.books 

-- 10) Find the book with the lowest stock
Select top 10 Title,Stock from bookstore.books
order by stock asc

-- 11) Calculate the total revenue generated from all orders
Select sum(Total_Amount) as total_revenue from bookstore.Orders

-- 1) Retrieve the total number of books sold for each genre
Select Genre, count(*) total_books From bookstore.books
group by genre

-- 2) Find the average price of books in the "Fantasy" genre
Select Genre, Round(avg(price),2) From bookstore.books
where Genre = 'Fantasy'
group by Genre

-- 3) List customers who have placed at least 2 orders
Select c.Name, count(o.customer_id) as total_order from 
bookstore.Orders o left join bookstore.Customers c
On o.customer_id = c.customer_id
group by o.customer_id, c.Name having count(o.customer_id) >2

-- 4) Find the most frequently ordered book
Select b.Title, count(o.Book_id) as no_of_times_sold from
bookstore.orders o left join bookstore.books b
on o.book_id = b.book_id 
Group by o.Book_id, b.Title
Order by 2 desc

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
Select Top 3 Title, price  From bookstore.books
where Genre = 'Fantasy'
order by price desc

-- 6) Retrieve the total quantity of books sold by each author
Select b.Author, Sum(o.quantity) as total_quantity_sold
From bookstore.orders o left join bookstore.books b
On o.book_id = b.book_id
group by b.Author
order by 2 desc

-- 7) List the cities where customers who spent over $30 are located
Select c.city, sum(o.total_amount) as total_spent from 
bookstore.orders o left join bookstore.customers c
on o.customer_id = c.customer_id
group by c.city having sum(o.total_amount) < 30

-- 8) Find the customer who spent the most on orders
Select c.Name, count(c.customer_id) as total_orders, 
sum(o.quantity) total_quan, 
sum(o.total_amount) as total_spent from 
bookstore.orders o left join bookstore.customers c
on o.customer_id = c.customer_id
Group by c.Name order by sum(o.total_amount) desc

-- 9) Calculate the stock remaining after fulfilling all orders

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM bookstore.books b
left JOIN bookstore.orders o ON b.book_id=o.book_id
GROUP BY b.book_id, b.title, b.stock ORDER BY 5 desc;

