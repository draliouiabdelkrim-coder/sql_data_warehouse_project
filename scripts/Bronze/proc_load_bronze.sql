/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
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
    EXEC bronze.load_bronze;
===============================================================================


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	Declare @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE ();
		Print '===================================================';
		Print 'Loading Bronze Layer';
		Print '===================================================';

		print'----------------------------------------------------';
		Print'Loading CRM Tables';
		print'----------------------------------------------------';

		SET @start_time = GETDATE();
		Print '>> Truncating Table : [bronze].[crm_cust_info]';
		TRUNCATE TABLE [bronze].[crm_cust_info];

		Print '>> Inserting Data into :[bronze].[crm_cust_info]';
		BULK INSERT [bronze].[crm_cust_info]
		FROM 'G:\DATA ANALYSTE\New folder\sql\New folder\Udemy - The Complete SQL Bootcamp (30 Hours) Go from Zero to Hero 2025-6\25. SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			Firstrow = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		Print '>>Load Duration: '+ cast(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
		Print '----------------------------------------------------------'

		-- INSERT crm_prd_info TABLE
		SET @start_time = GETDATE();
		Print '>> Truncating Table : [bronze].[crm_prd_info]';
		TRUNCATE TABLE  [bronze].[crm_prd_info];

		Print '>> Inserting Data into :[bronze].[crm_prd_info]';
		BULK INSERT [bronze].[crm_prd_info]
		from 'G:\DATA ANALYSTE\New folder\sql\New folder\Udemy - The Complete SQL Bootcamp (30 Hours) Go from Zero to Hero 2025-6\25. SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH ( 
				FIRSTROW = 2, 
				FIELDTERMINATOR = ',' ,
				TABLOCK
		);
		SET @end_time = GETDATE();
		Print '>> Load duration: ' +cast ( DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR ) + 'Seconds';
		Print '----------------------------------------------------------'

		SET @start_time = GETDATE();
		-- INSERT sales_details TABLE
		Print '>> Truncating Table : [bronze].[crm_sales_details]';
		TRUNCATE TABLE [bronze].[crm_sales_details];

		Print '>> Inserting Data into :[bronze].[crm_sales_details]';
		BULK INSERT [bronze].[crm_sales_details]
		from 'G:\DATA ANALYSTE\New folder\sql\New folder\Udemy - The Complete SQL Bootcamp (30 Hours) Go from Zero to Hero 2025-6\25. SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Loading Duration; '+ CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR )+ 'Secondes'; 
		Print '----------------------------------------------------------'

		
		print'----------------------------------------------------';
		Print'Loading ERP Tables';
		print'----------------------------------------------------';
		-- INSERT erp.CUST_AZ12 TABLE
		SET @start_time = GETDATE();
		Print '>> Truncating Table : [bronze].[erp_CUST_AZ12]';
		TRUNCATE TABLE [bronze].[erp_CUST_AZ12];

		Print '>> Inserting Data into :[bronze].[erp_CUST_AZ12]';
		BULK INSERT [bronze].[erp_CUST_AZ12]
		FROM 'G:\DATA ANALYSTE\New folder\sql\New folder\Udemy - The Complete SQL Bootcamp (30 Hours) Go from Zero to Hero 2025-6\25. SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Loading Duration: ' + Cast( DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'Secondes'
		Print '----------------------------------------------------------'

		-- INSERT erp.LOC_A101 TABLE
		SET @start_time = GETDATE();
		Print '>> Truncating Table : [bronze].[erp_LOC_A101]';
		TRUNCATE TABLE [bronze].[erp_LOC_A101];

		Print '>> Inserting Data into :[bronze].[erp_LOC_A101]';
		BULK INSERT [bronze].[erp_LOC_A101]
		FROM 'G:\DATA ANALYSTE\New folder\sql\New folder\Udemy - The Complete SQL Bootcamp (30 Hours) Go from Zero to Hero 2025-6\25. SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Loadin Duration: ' + CAST( DaTEDIFF( second, @start_time, @end_time) AS nvARCHAR) + 'Secondes';
		Print '----------------------------------------------------------'

		--INSERT erp.PX_CAT_G1V2
		SET @start_time = GETDATE ();
		Print '>> Truncating Table : [bronze].[erp_PX_CAT_G1V2]';
		TRUNCATE TABLE [bronze].[erp_PX_CAT_G1V2];

		Print '>> Inserting Data into :[bronze].[erp_PX_CAT_G1V2]';
		BULK INSERT [bronze].[erp_PX_CAT_G1V2]
		FROM 'G:\DATA ANALYSTE\New folder\sql\New folder\Udemy - The Complete SQL Bootcamp (30 Hours) Go from Zero to Hero 2025-6\25. SQL Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
		);
		SET @end_time = GETDATE ();
		Print '>> Loaing Duration: ' + CAST( DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Secondes';
		Print '----------------------------------------------------------'
		SET @batch_end_time = GETDATE();
		Print'==========================================================='
		Print 'Loading Bronze Layer is Completed';
		Print'     = Total Load Duration: ' + CAST( DATEDIFF(second, @batch_start_time, @batch_end_time) AS VARCHAR ) + 'Seconds';
		Print'==========================================================='
	END TRY

	BEGIN CATCH
		PRINT '========================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '========================================================';
	END CATCH
END;



EXEC [bronze].[load_bronze]
