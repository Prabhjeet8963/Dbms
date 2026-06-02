# HR Employee Analytics System

This project contains a corporate HR dataset tracking employees and their departments. It showcases scalar functions (string casing, date arithmetic) and non-symmetric self-joins to identify hiring overlaps.

Refer to [inbuilt-functions-requirements.docx](inbuilt-functions-requirements.docx) for the original lab requirements document.

---

## Database Components

The HR schema consists of two tables:
* DEPT: Tracks department names and geographical locations.
* EMP: Identifies employees, job descriptions, managers, salaries, commissions, and department references.

---

## Key SQL Queries

### 1. Non-Symmetric Self-Joins
To find distinct pairs of employees hired on the exact same date without reciprocal duplicates (e.g. returning only one direction), we apply a strict inequality check on primary keys:

```sql
SELECT E1.ENAME AS Employee_1, E2.ENAME AS Employee_2, E1.HIREDATE
FROM EMP E1
JOIN EMP E2 ON E1.HIREDATE = E2.HIREDATE AND E1.EMPNO < E2.EMPNO
ORDER BY E1.HIREDATE;
```

### 2. Scalar Temporal Arithmetic
Calculates the date exactly three days after each employee's hire date:

```sql
SELECT ENAME, HIREDATE,
       DATE_ADD(HIREDATE, INTERVAL 3 DAY) AS Date_After_3_Days
FROM EMP;
```

---

## Execution

1. Deploy schema:
   ```bash
   mysql -u root -p < schema.sql
   ```
2. Execute queries:
   ```bash
   mysql -u root -p < queries.sql
   ```
