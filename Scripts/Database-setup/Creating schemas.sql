/*
==========================================================
Create  Database and Schemas
===========================================================
Script purpose:
This script creates a new database named 'DataWarehouse' after checking if it already exist.
if the database exist, it is dropped and recreated. Additionall, the script sets up three schemas within t
the database: 'bronze', 'sliver', and 'gold'.
*/





USE master;
GO
--Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

--Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA sliver;
GO

CREATE SCHEMA gold;
GO
