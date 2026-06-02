# Hotel Management System (NoSQL - MongoDB)

This project implements a schema-less document-oriented database utilizing MongoDB. It models a hotel registry featuring hierarchical embedded documents, dynamic field allocation, projections, and nested queries.

Refer to [hotel-database-requirements.docx](hotel-database-requirements.docx) for the original lab requirements document.

---

## Relational vs. Document Database Paradigms

| Feature | Relational Databases (SQL) | Document Databases (NoSQL - MongoDB) |
| :--- | :--- | :--- |
| Organization | Normalized tables (Columns and Rows) | Collections of JSON-like BSON Documents |
| Schema | Rigid compile-time schema | Dynamic schema-less structures |
| Relations | Explicit joins (JOIN/Foreign Keys) | Embedded nested structures or references |
| Scaling | Vertical scaling | Horizontal scaling (Sharding/Partitioning) |

---

## Embedded Document Structure

MongoDB stores data as BSON (Binary JSON) documents. This enables nested records inside a single document:

```json
{
  "hotel_id": "H001",
  "name": "Sunrise Inn",
  "Borough": "Bronx",
  "cuisine": "Italian",
  "address": {
    "zipcode": "10451",
    "street": "150 E 149th St"
  }
}
```

* Address Embedding: Storing the address nested within the hotel record avoids the overhead of multi-table joins. The entire record is retrieved in a single read operation.

---

## Key MongoDB Queries

### 1. Traversing Subdocuments using Dot-Notation
Nested properties are queried by specifying the path in dot-notation (wrapped in quotes):

```javascript
db.hotel.find({ "address.zipcode": "10451" });
```

### 2. Output Projection Filters
To limit bandwidth, projections specify which fields to include (1) or exclude (0):

```javascript
db.hotel.find(
  { Borough: "Manhattan" },
  { name: 1, cuisine: 1, _id: 0 }
);
```

---

## Execution

1. Connect to MongoDB shell (mongosh):
   ```bash
   mongosh "mongodb://localhost:27017/hotelDB" queries.js
   ```
