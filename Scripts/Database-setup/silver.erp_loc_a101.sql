INSERT INTO silver.erp_loc_a101
(cid, cntry)
SELECT
 REPLACE(cid, '-', '') cid, -- Handled invalid values, removed minus with empty string
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
     WHEN TRIM(cntry) = '' OR cntry IS NULL THEN  'n/a'
     ELSE TRIM(cntry)
END AS cntry -- Normalize and handled missing or blank contry codes 
FROM bronze.erp_loc_a101 
