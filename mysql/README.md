# Relational Database Management Systems (RDBMS) - MySQL Portfolio

This directory contains my relational database implementations utilizing MySQL. It demonstrates database schema designs, standard referential constraints, and analytical query compositions.

Each experiment is self-contained within its own directory, pairing the lab requirements document directly with the schema and query answer scripts.

---

## Directory Index

1. [01-company-database/](./01-company-database/)
   Models an enterprise with employees, departments, projects, and dependents. Showcases recursive self-joins and relational division (NOT EXISTS).

2. [02-company-sales/](./02-company-sales/)
   Tracks client balances, product inventories, and salesman achievements. Details DDL table modifications and numeric range constraints.

3. [03-supplier-inventory/](./03-supplier-inventory/)
   Resolves many-to-many supplier distributions through intermediate nested subqueries.

4. [04-student-athletics/](./04-student-athletics/)
   Models ternary event associations and dynamic groups using aggregate counts (HAVING).

5. [05-inbuilt-functions/](./05-inbuilt-functions/)
   Demonstrates built-in SQL scalar functions, case transformations, date additions, and non-symmetric self-joins.
