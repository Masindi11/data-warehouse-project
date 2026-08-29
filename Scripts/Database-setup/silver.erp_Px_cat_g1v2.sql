INSERT INTO silver.erp_Px_cat_g1v2
(id,     
  cat,
  subcat,
  maintenance)
SELECT 
  id,     
  cat,
  subcat,
  maintenance
 FROM bronze.erp_Px_cat_g1v2
