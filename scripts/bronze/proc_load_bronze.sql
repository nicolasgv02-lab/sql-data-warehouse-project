/*
===================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===================================================================================
Script Purpose: 
    This stored procedure loads data into the bronze schema from external CSV files.
    It performs the following actions:
    - Truncade the bronze tables from loading data
    - uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
    None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
===================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @startTime DATETIME, @endTime DATETIME, @batchstartTime DATETIME, @batchendTime DATETIME;
	BEGIN TRY
		SET @batchstartTime = GETDATE();
		PRINT '===============================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================';

		PRINT '-------------------------------';
		PRINT 'Loading CRM Data';
		PRINT '-------------------------------';

		SET @startTime = GETDATE();
		PRINT '>> Truncating table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Loading data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\SQL\SQL Data Warehouse Project\nic-version\sql-dwh-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';

		SET @startTime = GETDATE();
		PRINT '>> Truncating table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Loading data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\SQL\SQL Data Warehouse Project\nic-version\sql-dwh-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';

		SET @startTime = GETDATE();
		PRINT '>> Truncating table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Loading data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\SQL\SQL Data Warehouse Project\nic-version\sql-dwh-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';

		PRINT '-------------------------------';
		PRINT 'Loading ERP Data';
		PRINT '-------------------------------';

		SET @startTime = GETDATE();
		PRINT '>> Truncating table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Loading data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\SQL\SQL Data Warehouse Project\nic-version\sql-dwh-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';

		SET @startTime = GETDATE();
		PRINT '>> Truncating table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Loading data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\SQL\SQL Data Warehouse Project\nic-version\sql-dwh-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';

		SET @startTime = GETDATE();
		PRINT '>> Truncating table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Loading data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\SQL\SQL Data Warehouse Project\nic-version\sql-dwh-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @endTime = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @startTime, @endTime) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';

		SET @batchendTime = GETDATE();
		PRINT '===============================';
		PRINT 'Loading Bronze Layer Completed';
		PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batchstartTime, @batchendTime) AS NVARCHAR) + ' seconds';
		PRINT '===============================';
	END TRY
	BEGIN CATCH
		PRINT '===============================';
		PRINT 'Error loading Bronze Layer';
		PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'Error Message:' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===============================';
	END CATCH
END;
