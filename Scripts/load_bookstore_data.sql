
/*
===============================================================================
Stored Procedure: Load Bookstore Data
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
     EXEC load_bookstore_data  ;
===============================================================================
*/



CREATE OR Alter PROCEDURE load_bookstore_data AS
Begin
    Declare @start_time date, @end_time date, @pro_begin date, @pro_end date;
    Begin try

    Set @pro_begin = GETDATE();
    PRINT '==============================================================';
    PRINT 'Loading Customers Table';
    PRINT '==============================================================';

    SET @start_time = GETDATE();
    PRINT '>> TRUCATING TABLE: bookstore.customers';
    TRUNCATE TABLE bookstore.customers;

    PRINT '>> Inserting Data Into: bookstore.customers';

    BULK INSERT bookstore.customers 
    From 'D:\data analyst\sql\30 Day - SQL Practice Files- SD50\30 Day - SQL Practice Files\Customers.csv'
    with (
	    FIRSTROW = 2,
	    FIELDTERMINATOR =',',
	    TABLOCK
	    );
    
    SET @end_time = GETDATE();
    print '>>> Load duration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'
    
    PRINT '==============================================================';
    PRINT 'Loading books Table';
    PRINT '==============================================================';

    SET @start_time = GETDATE();
    PRINT '>> TRUCATING TABLE: bookstore.books';
    TRUNCATE TABLE bookstore.books;

    PRINT '>> Inserting Data Into: bookstore.books';

    BULK INSERT bookstore.books 
    From 'D:\data analyst\sql\30 Day - SQL Practice Files- SD50\30 Day - SQL Practice Files\Books.csv'
    with (
	    FIRSTROW = 2,
	    FIELDTERMINATOR =',',
	    TABLOCK
	    );
    
    SET @end_time = GETDATE();
    print '>>> Load duration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'
    
    PRINT '==============================================================';
    PRINT 'Loading Orders Table';
    PRINT '==============================================================';

    SET @start_time = GETDATE();
    PRINT '>> TRUCATING TABLE: bookstore.Orders';
    TRUNCATE TABLE bookstore.orders;

    PRINT '>> Inserting Data Into: bookstore.Orders';

    BULK INSERT bookstore.orders 
    From 'D:\data analyst\sql\30 Day - SQL Practice Files- SD50\30 Day - SQL Practice Files\Orders.csv'
    with (
	    FIRSTROW = 2,
	    FIELDTERMINATOR =',',
	    TABLOCK
	    );
    
    SET @end_time = GETDATE();
    print '>>> Load duration :' + cast(datediff(second,@start_time,@end_time) as nvarchar) + 'seconds'
    

    SET @pro_begin = GETDATE();
    print '>>> Table Load duration :' + cast(datediff(second,@pro_begin,@pro_end) as nvarchar) + 'seconds'


    End try
    Begin Catch
    PRINT '----------------------------------------------------'
    Print 'ERROR OCCURED DURING THE LOADING BOOKSTORE TABLE';
    PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
    PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
    PRINT 'ERROR MESSAGE ' + ERROR_MESSAGE();
    PRINT '----------------------------------------------------' 
    End catch
 End ;

