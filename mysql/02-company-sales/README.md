# Company Sales Database System

This database project tracks client accounts receivable, product inventories, and salesman target achievements. It illustrates dynamic schema definitions, database constraints, cost/sell price calculations, and operational schema alterations.

Refer to [sales-database-requirements.docx](sales-database-requirements.docx) for the original lab requirements document.

---

## Database Components

The system models three dimensions:
* CLIENT_MASTER: Stores billing balances (BALDUE) and contact information.
* PRODUCT_MASTER: Manages physical stock levels (QTYONHAND), reorder thresholds (REORDERLVL), cost parameters, and profit percent margins.
* SALESMAN_MASTER: Tracks sales commissions and performance targets.

---

## Key SQL Concepts

### 1. Engine-level Constraints
Enforces that selling and cost prices are strictly positive numeric entries:
```sql
CREATE TABLE PRODUCT_MASTER (
    ...
    SELLPRICE DECIMAL(10, 2) NOT NULL,
    COSTPRICE DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_sell_price CHECK (SELLPRICE > 0),
    CONSTRAINT chk_cost_price CHECK (COSTPRICE > 0)
);
```

### 2. Schema Evolution (DDL Alterations)
Showcases structural database modifications:
* Adding columns:
  ```sql
  ALTER TABLE CLIENT_MASTER ADD COLUMN Telephone VARCHAR(10) NULL;
  ```
* Modifying attributes:
  ```sql
  ALTER TABLE CLIENT_MASTER MODIFY COLUMN NAME VARCHAR(30) NOT NULL;
  ```

---

## Execution

1. Build schema:
   ```bash
   mysql -u root -p < schema.sql
   ```
2. Run database updates and queries:
   ```bash
   mysql -u root -p < queries.sql
   ```
