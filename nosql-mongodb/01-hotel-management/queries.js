// ==========================================================
// NOSQL DOCUMENT DATABASE EXERCISES: MONGODB QUERIES
// ==========================================================

// 1. DATABASE & COLLECTION INITIALIZATION
// Switch to the 'hotelDB' database context
use hotelDB;

// Explicitly create the 'hotel' collection
db.createCollection("hotel");

// ----------------------------------------------------------
// 2. DATA POPULATION (BULK DOCUMENT INSERTION)
// ----------------------------------------------------------
// Populates the collection with schema-less BSON documents,
// highlighting dynamic structure and nested subdocuments (address).
db.hotel.insertMany([
  { 
    hotel_id: "H001", 
    name: "Sunrise Inn", 
    Borough: "Bronx", 
    cuisine: "Italian", 
    address: { zipcode: "10451", street: "150 E 149th St" },
    grades: [ { date: new Date("2024-01-15"), grade: "A", score: 11 } ]
  },
  { 
    hotel_id: "H002", 
    name: "Green Garden", 
    Borough: "Manhattan", 
    cuisine: "Chinese", 
    address: { zipcode: "10027", street: "2815 Broadway" },
    grades: [ { date: new Date("2024-02-10"), grade: "B", score: 14 } ]
  },
  { 
    hotel_id: "H003", 
    name: "Royal Stay", 
    Borough: "Queens", 
    cuisine: "Indian", 
    address: { zipcode: "11368", street: "104-12 Roosevelt Ave" },
    grades: [ { date: new Date("2024-03-01"), grade: "A", score: 8 } ]
  },
  { 
    hotel_id: "H004", 
    name: "The Grand Plaza", 
    Borough: "Manhattan", 
    cuisine: "Continental", 
    address: { zipcode: "10019", street: "768 5th Ave" },
    grades: [ { date: new Date("2024-01-20"), grade: "A", score: 5 } ]
  },
  { 
    hotel_id: "H005", 
    name: "Bronx Hub Resto", 
    Borough: "Bronx", 
    cuisine: "Italian", 
    address: { zipcode: "10451", street: "2914 Third Ave" },
    grades: [ { date: new Date("2024-02-18"), grade: "C", score: 20 } ]
  }
]);

// ----------------------------------------------------------
// 3. RETRIEVAL & FILTERING (DQL)
// ----------------------------------------------------------

// Query A. Retrieve all documents in the 'hotel' collection
// Equivalent to: SELECT * FROM hotel;
db.hotel.find().pretty();

// Query B. Field Projections
// Find the name and borough of all hotels, excluding the default '_id' field
// Equivalent to: SELECT name, Borough FROM hotel;
db.hotel.find(
  {}, // Match all documents
  { name: 1, Borough: 1, _id: 0 } // Project only name and Borough
);

// Query C. Nested / Embedded Document Filtering
// Find hotels located in the zipcode '10451'
// Note the dot-notation wrapped in quotes to traverse the 'address' subdocument
db.hotel.find(
  { "address.zipcode": "10451" }
).pretty();

// Query D. Multi-Criteria Matching (AND Logic)
// Find hotels in the 'Bronx' borough that serve 'Italian' cuisine
db.hotel.find({
  $and: [
    { Borough: "Bronx" },
    { cuisine: "Italian" }
  ]
}).pretty();

// Alternative clean syntax for implicit AND:
db.hotel.find({ Borough: "Bronx", cuisine: "Italian" });

// ----------------------------------------------------------
// 4. SORTING, LIMITING, & AGGREGATION
// ----------------------------------------------------------

// Query E. Sorting and Limiting
// Find all hotels in 'Manhattan', sort them alphabetically by name (1 for ASC, -1 for DESC),
// and limit the output to the top 2 results
db.hotel.find({ Borough: "Manhattan" })
        .sort({ name: 1 })
        .limit(2)
        .pretty();

// Query F. Document Counting
// Count the total number of hotels located in the 'Bronx'
db.hotel.countDocuments({ Borough: "Bronx" });
