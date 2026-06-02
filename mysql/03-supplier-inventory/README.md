# Supplier Inventory System

This database project manages parts distributions, tracking suppliers, parts, and the supplier-part quantities linking them. It illustrates intermediate subquery patterns, weight boundaries, aggregate metrics, and junction tables.

Refer to [supplier-inventory-requirements.docx](supplier-inventory-requirements.docx) for the original lab requirements document.

---

## Database Components

The system resolves a many-to-many relationship using three tables:
* Supplier: Tracks supplier locations and financial turnovers.
* Part: Tracks physical parameters (enforcing weigh > 0).
* Supplier_Part: Junction table mapping matching supplier-part quantities, referencing parent tables with cascade deletes.

---

## Key SQL Concepts

### 1. Dynamic Comparative Subqueries (Scalar Subquery)
Finds parts whose cost is strictly greater than the average cost of all parts:

```sql
SELECT pcode, weigh, color, cost
FROM Part
WHERE cost > (
    SELECT AVG(cost)
    FROM Part
);
```

### 2. Set Membership Subqueries
Retrieves the names of suppliers who supply part 'P2':

```sql
SELECT sname
FROM Supplier
WHERE scode IN (
    SELECT scode
    FROM Supplier_Part
    WHERE pcode = 'P2'
);
```

---

## Execution

1. Build schema:
   ```bash
   mysql -u root -p < schema.sql
   ```
2. Run analytical query suite:
   ```bash
   mysql -u root -p < queries.sql
   ```
