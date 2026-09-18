

/* 
===================================================================
create database, schemas, And Tables
===================================================================
*/

use master;

--Drop and recreate the 'Projectsql' database 
if exits (select 1 from sys.databases where name = 'Projectsql')
begin
    Alter DATABASE Projectsql SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Projectsql;
End;

--create the database Projectsql;

create database projectsql;
use projectsql

CREATE SCHEMA bookstore;

/*
===================================================================
DDL Script: Create Tables of customers, orders, books
==============================================
Script purpose - Create table in the Bookstore schema, dropping existing table if they already exist.
*/

IF OBJECT_ID('customers','U') is not null
	drop table bookstore.customers

CREATE TABLE bookstore.customers (
	Customer_ID	int,
	Name	nvarchar(50),
	Email	nvarchar(100),
	Phone	int,
	City	nvarchar(50),
	Country nvarchar(100)
	)
	

IF OBJECT_ID('books','U') is not null
	drop table bookstore.books

CREATE TABLE bookstore.books (
	Book_ID	int,
	Title	nvarchar(100),
	Author	nvarchar(50),
	Genre	nvarchar(50),
	Published_Year	date,
	Price	float,
	Stock	int
	)


IF OBJECT_ID('orders','U') is not null
	drop table bookstore.orders

CREATE TABLE bookstore.orders (
	Order_ID	int,
	Customer_ID	int,
	Book_ID	int,
	Order_Date	date,
	Quantity	int,
	Total_Amount float
)

