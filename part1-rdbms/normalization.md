## Anomaly Analysis
* **Insert Anomaly**
    - Problem: Cannot add a new product to the system unless it appears in an order.
    - Example: Suppose to add a new product like "Desk Table" (say P009, priced at ₹5000) to the catalogue. Since product_id, product_name, category, and unit_price only exist inside order rows, there is no way to record this product without a customer placing an order for it first. Product information has no independent existence in this table.
    - Columns affected: product_id, product_name, category, unit_price
* **Update Anomaly**
    - Problem: SR01's office address appears in dozens of rows. If it changes, every single row must be updated, miss even one and the data becomes inconsistent.
    - Example: Sales rep Deepak Joshi (SR01) has the office_address as "Mumbai HQ, Nariman Point, Mumbai - 400021" repeated across many rows like in ORD1114, ORD1091, ORD1003, etc.
    But in some later rows like ORD1180, ORD1182, ORD1183, etc  the same SR01 Deepak Joshi has the address recorded as "Mumbai HQ, Nariman Pt, Mumbai - 400021" (shortened "Pt" instead of "Point"). This inconsistency already exists in the dataset as someone partially might have updated the address and missed other rows.
    - Columns affected: sales_rep_id, sales_rep_name, office_address
* **Delete Anomaly**
    - Problem: If we delete the only order placed by a customer, we can lose all information about that customer entirely.
    - Example: If Arjun Nair (C007) had placed only one order (eg Headphones) and was served by one of the sales rep (eg SR01)and the order is cancelled and deleted, all information about that customer — their email, city, and their association with a sales rep — would be permanently lost from the system.
    - Columns affected: customer_id, customer_name,  customer_email, sales_rep_id, sales_rep_name


## Normalization Justification
While storing everything in one flat table may seem simpler at first, the orders_flat dataset proves that this approach creates serious long-term problems that outweigh any short-term convenience.
The flat table in this dataset contains customer details, product information, sales rep data, and order transactions all mixed into one place. This design directly causes three types of anomalies that were identified in the data itself.

First, an insert anomaly — if the business wants to add a new product like "Desk Table" to the catalogue, it cannot do so without a customer first placing an order for it. Product information has no independent existence in the flat table, which is a real operational limitation.

Second, an update anomaly — Sales rep Deepak Joshi (SR01) has his office address repeated across dozens of rows. This inconsistency already exists in the dataset, where some rows show "Nariman Point" and others show "Nariman Pt". A simple address change requires updating every single row, and missing even one creates corrupted, untrustworthy data.

Third, a delete anomaly — if a customer's only order is cancelled and deleted, all information about that customer including their email and city is permanently lost from the system.

Normalization splits the flat table into four clean tables — Customers, Products, SalesReps, and Orders — where each piece of information is stored exactly once. This eliminates all three anomalies completely.
Therefore, calling normalization "over-engineering" ignores the real data integrity problems already visible in this dataset. Simplicity that causes inconsistent and untrustworthy data is not simplicity — it is a design flaw in disguise.