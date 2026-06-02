# Student Athletics System

This database project tracks student athletes, sports matches, and their play schedules. It highlights the mapping of ternary relationships, composite primary keys, multi-table joins, and advanced group filtering.

Refer to [student-athletics-requirements.docx](student-athletics-requirements.docx) for the original lab requirements document.

---

## Database Components

The system models a three-way (ternary) association:
* Student: Stores athlete profiles (age, name).
* Matches: Identifies sports codes and venues.
* Play: A ternary junction table linking student, match, and day as a composite primary key (sid, mid, day).

---

## Key SQL Queries

### 1. Multi-Dimensional Conditional Grouping
Finds student names and IDs of athletes who played at least two different matches on the same day:

```sql
SELECT sid, sname
FROM Student
WHERE sid IN (
  SELECT sid
  FROM Play
  GROUP BY sid, day
  HAVING COUNT(DISTINCT mid) >= 2
);
```

### 2. Multi-Level Nested Query
Retrieves names of students who played matches hosted in 'Delhi':

```sql
SELECT DISTINCT S.sname
FROM Student S
WHERE S.sid IN (
  SELECT P.sid 
  FROM Play P
  WHERE P.mid IN (
    SELECT M.mid 
    FROM Matches M
    WHERE M.venue = 'Delhi'
  )
);
```

---

## Execution

1. Build schema:
   ```bash
   mysql -u root -p < schema.sql
   ```
2. Run analytics:
   ```bash
   mysql -u root -p < queries.sql
   ```
