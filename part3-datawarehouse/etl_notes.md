## ETL Decisions
**Decision 1 —** Standardizing inconsistent date formats.

**Problem:** The date column in retail_transactions.csv contained three different date formats across rows. Some rows used DD/MM/YYYY (e.g. 29/08/2023), others used DD-MM-YYYY (e.g. 12-12-2023), and others used the standard YYYY-MM-DD (e.g. 2023-02-05). This inconsistency would cause errors when loading into the warehouse as SQL expects one consistent date format.

**Resolution:** All dates were standardized to the YYYY-MM-DD format before loading into dim_date. For example, 29/08/2023 was transformed to 2023-08-29 and 12-12-2023 was transformed to 2023-12-12. This is the internationally recognized ISO 8601 date standard and ensures all date-based queries and sorting work correctly.
_____________________________________________________
**Decision 2 —** Fixing inconsistent category casing

**Problem:** The category column had three different variations of the same values. Electronics appeared as both Electronics and electronics (lowercase). Groceries appeared as both Groceries and Grocery (singular). This means the same category was being treated as two different categories which would produce incorrect results in any GROUP BY query.

**Resolution:** All category values were standardized to proper case during the transformation step before loading into dim_product. Specifically electronics was corrected to Electronics and Grocery was corrected to Groceries. This ensures that all queries produces accurate and complete results.
_____________________________________________________
**Decision 3 —** Handling NULL values in store_city.

**Problem:** The store_city column contained 19 NULL or empty values across the dataset. Since store_city is an important dimension for store-level reporting and filtering, loading these NULLs into dim_store would make those rows useless for any city-based analysis and violate the NOT NULL constraint defined in the schema.

**Resolution:** Since store_name was always present even when store_city was missing, the correct city was derived from the store name itself. For example rows with store_name = 'Chennai Anna' but empty store_city were filled in as Chennai. This lookup-based resolution ensured all 5 stores had complete and accurate city information in dim_store.