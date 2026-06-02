# Corporate Organization Database Design (Company DBMS)

This database design project models a corporate organization tracking employees, departments, projects, and dependents. It is based on the advanced ER layout in [company-diagram.png](company-diagram.png).

---

## Conceptual ER Diagram (Mermaid.js)

```mermaid
erDiagram
    DEPARTMENT {
        int Departmentnumber PK
        string Departmentname UK
        string Deparempmanager
        string Deplocation
    }
    PROJECTS {
        int ProNumber PK
        string Proname UK
        string Prolocation
    }
    EMPLOYEE {
        string EmpSSN PK
        string EmpName
        char Empsex
        string address1
        string address2
        decimal salary
        date birth_date
    }
    DEPENDENTS {
        string Dependent_name PK
        char sex
        date birth_date
        string Relationtoemp
    }

    DEPARTMENT ||--o{ PROJECTS : "Controls (1:N)"
    DEPARTMENT ||--o| EMPLOYEE : "Manages (1:1, startDate)"
    DEPARTMENT ||--o{ EMPLOYEE : "WorksFor (1:N)"
    EMPLOYEE ||--o{ EMPLOYEE : "Supervises (1:N)"
    EMPLOYEE ||--o{ DEPENDENTS : "DependentsOf (1:N identifying)"
    EMPLOYEE ||--o{ PROJECTS : "Handles (N:M, HoursWorkedOn)"
```

---

## Design Features

### 1. Recursive Supervisor Hierarchies
The Supervises recursive loop represents the management structure on the EMPLOYEE entity. One employee acts as supervisor (1) and another acts as supervisee (N).

### 2. Relationship Attributes
The Handles many-to-many relationship holds the attribute HoursWorkedOn. Because hours belong to the specific intersection of an employee and a project, they reside strictly on the relationship itself, mapping physically as a column in the WORKS_ON junction table.

### 3. Weak Entity Identification
DEPENDENTS is modeled as a weak entity depending on the owner EMPLOYEE via the identifying relationship DependentsOf.

---

## References

* [Advanced Corporate Schema (Draw.io)](company-diagram.png)
