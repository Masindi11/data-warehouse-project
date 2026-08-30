
/*
==============================================================================================
Quality checks
==============================================================================================
Script purpose:
        This script performs various quality checks for data consistency, accuracy,
        and standardization across the 'sliver' schema. it includes checks for:
       - NULL or duplicate primary keys.
       - Unwanted spaces in string fields.
       - Data standardization and consistency.
       - invalid date ranges and orders.
       - Data consistency between related fields.

Usage Notes:
      - Run these checks after data loading sliver layer.
      - Investigate and resolve any discrepancies found during the checks.
=============================================================================================
*/



-- =======================================================================================
-- check for NULLS or duplicates in primary key
-- expectation: no results
SELECT
  cst_id,
  COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Check for unwanted spaces
-- expectation: no results
SELECT
  cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data standardization & consistency
SELECT DISTINCT
  cst_marital_status
FROM silver.crm_cust_info;

-- ==============================================================================
-- check 'silver.crm_prd_info'
-- ===============================================================================
-- check for NULLS or duplicates in primary key
-- expectation: no results
SELECT
  prd_id,
  COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Check for unwanted spaces
-- expectation: no results
SELECT
  prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- check for NULLS or negative values in cost
-- expectation: no results
SELECT
  prd_cost
  FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;

-- Data standardization & consistency
SELECT DISTINCT
  prd_line
FROM silver.crm_prd_info;

-- check for invalid Date orders (start Date > End Date)
-- expectation: no results
SELECT
  *
FROM silver.crm_prd_info
  WHERE prd_end_dt < prd_start_dt;

-- =======================================================================================
-- checking 'silver.crm_sales_details'
-- ========================================================================================
-- check for invalid Dates 
-- expectation: no invaild Dates 
SELECT
  NULLIF(sls_due_dt,0) AS sls_due_dt
FROM bronze.crm_sales_details
  WHERE sls_due_dt <= 0
  OR LEN(sls_due_dt) != 8
  OR sls_due_dt > 20500101
  OR  sls_due_dt < 19000101;

-- Check for invaild dates orders (order dates > shipping/Due Dates)
--expectation: no results
SELECT
  *
FROM silver.crm_sales_details
  WHERE sls_order_dt > sls_ship_dt
  OR sls_order_dt > sls_due_dt;

-- check data consistency: sales = qUANTITY * price
-- expectation: no results
SELECT DISTINCT
  sls_sales,
  sls_quantity,
  sls_price
FROM silver.crm_sales_details
  WHERE sls_sales != sls_quantity * sls_price
  OR sls_sales IS NULL 
  OR sls_quantity IS NULL 
  OR sls_sales <= 0
  OR sls_quantity <= 0
  OR sls_price <= 0
  ORDER BY sls_sales, sls_quantity, sls_price;

-- checking 'sliver.erp_cust_az12'
--==============================================================================================
-- identify out-of-range dates 
-- expactation: birthdates between 1924-01-01 and today
SELECT DISTINCT
  bdate
  FROM silver.erp_cust_az12
  WHERE bdate < '1924_01-01'
  OR bdate > GETDATE();


-- Data standardization & consistency
SELECT DISTINCT
gen
FROM silver.erp_cust_az12;

--================================================================================================
-- Checking 'silver.erp_loc_a101'
--================================================================================================
-- Data standardization & consistency
SELECT DISTINCT
cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

--================================================================================================
-- checking 'silver.erp_Px_catg1v2'
--================================================================================================
-- checking for unwanted spaces
-- expectation: no results
SELECT
*
FROM silver.erp_cat_g1v2
WHERE cat != TRIM(cat)
OR subcat != TRIM(subcat)
OR maintenance != TRIM(maintenance);

--Data standardization & consistency
SELECT DISTINCT
maintenance
FROM silver.erp_Px_cat_g1v2;






















