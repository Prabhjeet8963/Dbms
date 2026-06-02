# Company Database System

This directory implements a relational database modeling a corporate organizational structure consisting of employees, departments, projects, and dependents.

---

## Schema Properties

The schema is built around six tables:
* EMPLOYEE: Tracks salaries, recursive supervision chains (Super_ssn), and department assignments (Dno).
* DEPARTMENT: Manages department identities and links to managers (Mgr_ssn).
* DEPT_LOCATIONS: Models multi-valued department locations.
* PROJECT: Identifies corporate projects and their controlling departments.
* WORKS_ON: A many-to-many associative junction table connecting employees to projects (with Hours).
* DEPENDENT: A weak entity type linked to employees (configured with ON DELETE CASCADE).

---

## Key SQL Formulations

### 1. Relational Division (Universal Quantification)
To find employees who work on all projects in the company, SQL uses a double-nested negative existential quantifier (NOT EXISTS):

```sql
SELECT E.Fname, E.Lname, E.Ssn
FROM EMPLOYEE E
WHERE NOT EXISTS (
    SELECT P.Pnumber
    FROM PROJECT P
    WHERE NOT EXISTS (
        SELECT 1
        FROM WORKS_ON W
        WHERE W.Essn = E.Ssn
          AND W.Pno = P.Pnumber
    )
);
```

### 2. Recursive Supervision Mapping
Finds employees managed directly by Franklin Wong using a self-referencing subquery:

```sql
SELECT Fname, Minit, Lname
FROM EMPLOYEE
WHERE Super_ssn = (
    SELECT Ssn
    FROM EMPLOYEE
    WHERE Fname = 'Franklin' AND Lname = 'Wong'
);
```

---

## Execution

1. Build schema and populate:
   ```bash
   mysql -u root -p < schema.sql
   ```
2. Execute queries:
   ```bash
   mysql -u root -p < queries.sql
   ```
