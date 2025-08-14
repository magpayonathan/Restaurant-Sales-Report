-- 1.) Changing null values to 'Unknown'
UPDATE "Restaurant_Sales_Report"
SET item_name          = COALESCE(NULLIF(TRIM(item_name::text), ''), 'Unknown'),
    item_type          = COALESCE(NULLIF(TRIM(item_type::text), ''), 'Unknown'),
    transaction_type   = COALESCE(NULLIF(TRIM(transaction_type::text), ''), 'Unknown'),
    received_by        = COALESCE(NULLIF(TRIM(received_by::text), ''), 'Unknown'),
    time_of_sale       = COALESCE(NULLIF(TRIM(time_of_sale::text), ''), 'Unknown');

-- 2.) Checking for duplicate rows and deleting duplicate rows while keeping the first occurrence
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY order_id, date, item_name, item_type, item_price, quantity, transaction_amount, transaction_type, received_by, time_of_sale
               ORDER BY order_id
           ) AS rn
    FROM "Restaurant_Sales_Report"
)
DELETE FROM "Restaurant_Sales_Report"
USING ranked
WHERE "Restaurant_Sales_Report".order_id = ranked.order_id
  AND "Restaurant_Sales_Report".date = ranked.date
  AND "Restaurant_Sales_Report".item_name = ranked.item_name
  AND "Restaurant_Sales_Report".item_type = ranked.item_type
  AND "Restaurant_Sales_Report".item_price = ranked.item_price
  AND "Restaurant_Sales_Report".quantity = ranked.quantity
  AND "Restaurant_Sales_Report".transaction_amount = ranked.transaction_amount
  AND "Restaurant_Sales_Report".transaction_type = ranked.transaction_type
  AND "Restaurant_Sales_Report".received_by = ranked.received_by
  AND "Restaurant_Sales_Report".time_of_sale = ranked.time_of_sale
  AND ranked.rn > 1;

-- 3.) Standardizing text
UPDATE "Restaurant_Sales_Report"
SET item_name = INITCAP(TRIM(REGEXP_REPLACE(item_name, '\s+', ' ', 'g'))),
    item_type = INITCAP(TRIM(REGEXP_REPLACE(item_type, '\s+', ' ', 'g'))),
    transaction_type = INITCAP(TRIM(REGEXP_REPLACE(transaction_type, '\s+', ' ', 'g'))),
    received_by = INITCAP(TRIM(REGEXP_REPLACE(received_by, '\s+', ' ', 'g'))),
    time_of_sale = INITCAP(TRIM(REGEXP_REPLACE(time_of_sale, '\s+', ' ', 'g')));

SELECT * FROM "Restaurant_Sales_Report"
ORDER BY order_id ASC;

CREATE TABLE "Restaurant_Sales_Report_Cleaned" AS
SELECT * FROM "Restaurant_Sales_Report";



