// Q 2.2

use("ecommerce_db");

// ============================================
// OP1: insertMany() — insert all 3 documents from sample_documents.json
// ============================================
db.products.insertMany([
  {
    "_id": "prod_001",
    "product_name": "Samsung 65-inch 4K Smart TV",
    "category": "Electronics",
    "brand": "Samsung",
    "price": 75000,
    "currency": "INR",
    "in_stock": true,
    "quantity_available": 15,
    "images": [
      "samsung_tv_front.jpg",
      "samsung_tv_side.jpg",
      "samsung_tv_remote.jpg"
    ],
    "specs": {
      "screen_size_inches": 65,
      "resolution": "4K Ultra HD",
      "voltage": "220V",
      "power_consumption_watts": 120,
      "connectivity": ["WiFi", "Bluetooth", "HDMI", "USB"],
      "operating_system": "Tizen OS"
    },
    "warranty": {
      "duration_years": 2,
      "type": "Manufacturer Warranty",
      "covers": ["hardware defects", "panel issues"]
    },
    "ratings": {
      "average": 4.5,
      "total_reviews": 238
    },
    "tags": ["smart tv", "4k", "samsung", "electronics"]
  },
  {
    "_id": "prod_002",
    "product_name": "Men's Slim Fit Denim Jacket",
    "category": "Clothing",
    "brand": "Levi's",
    "price": 3500,
    "currency": "INR",
    "in_stock": true,
    "quantity_available": 42,
    "images": [
      "denim_jacket_front.jpg",
      "denim_jacket_back.jpg"
    ],
    "variants": [
      {
        "size": "S",
        "color": "Dark Blue",
        "sku": "LV-DJ-S-DB",
        "stock": 8
      },
      {
        "size": "M",
        "color": "Dark Blue",
        "sku": "LV-DJ-M-DB",
        "stock": 15
      },
      {
        "size": "L",
        "color": "Light Blue",
        "sku": "LV-DJ-L-LB",
        "stock": 12
      },
      {
        "size": "XL",
        "color": "Black",
        "sku": "LV-DJ-XL-BK",
        "stock": 7
      }
    ],
    "attributes": {
      "material": "100% Cotton Denim",
      "fit": "Slim Fit",
      "gender": "Men",
      "care_instructions": [
        "Machine wash cold",
        "Do not bleach",
        "Tumble dry low"
      ],
      "country_of_origin": "India"
    },
    "ratings": {
      "average": 4.3,
      "total_reviews": 156
    },
    "tags": ["jacket", "denim", "mens", "clothing", "levis"]
  },
  {
    "_id": "prod_003",
    "product_name": "Organic Rolled Oats",
    "category": "Groceries",
    "brand": "Quaker",
    "price": 320,
    "currency": "INR",
    "in_stock": true,
    "quantity_available": 200,
    "images": [
      "quaker_oats_front.jpg"
    ],
    "packaging": {
      "weight_grams": 1000,
      "type": "Resealable Bag"
    },
    "dates": {
      "manufactured": "2025-01-10",
      "expiry": "2026-01-09",
      "best_before_days": 365
    },
    "nutritional_info": {
      "serving_size_grams": 40,
      "calories_per_serving": 150,
      "nutrients": {
        "protein_g": 5,
        "carbohydrates_g": 27,
        "fat_g": 3,
        "fiber_g": 4,
        "sugar_g": 1,
        "sodium_mg": 0
      }
    },
    "ingredients": ["Whole Grain Rolled Oats"],
    "dietary_info": {
      "is_organic": true,
      "is_vegan": true,
      "is_gluten_free": false,
      "contains_allergens": ["Oats"]
    },
    "storage_instructions": "Store in a cool, dry place away from direct sunlight",
    "ratings": {
      "average": 4.7,
      "total_reviews": 512
    },
    "tags": ["oats", "breakfast", "organic", "healthy", "groceries"]
  }
]);

// ============================================
// OP2: find() — retrieve all Electronics products with price > 20000
// ============================================
db.products.find(
  {
    category: "Electronics",
    price: { $gt: 20000 }
  },
  {
    product_name: 1,
    brand: 1,
    price: 1,
    category: 1
  }
);

// ============================================
// OP3: find() — retrieve all Groceries expiring before 2025-01-01
// ============================================
db.products.find(
  {
    category: "Groceries",
    "dates.expiry": { $lt: "2025-01-01" }
  },
  {
    product_name: 1,
    brand: 1,
    "dates.expiry": 1,
    category: 1
  }
);

// ============================================
// OP4: updateOne() — add a "discount_percent" field to a specific product
// ============================================
db.products.updateOne(
  { _id: "prod_001" },
  {
    $set: {
      discount_percent: 10
    }
  }
);

// ============================================
// OP5: createIndex() — create an index on category field and explain why
// ============================================
db.products.createIndex({ category: 1 });

/*
  WHY THIS INDEX?
  
  The category field is the most frequently used filter in this
  e-commerce platform. Queries like OP2 and OP3 both filter by
  category first before applying other conditions.

  Without an index, MongoDB performs a COLLSCAN (collection scan) i.e.,
  reading every single document to find matches.

  With this index, MongoDB performs an IXSCAN (index scan) i.e.,
  jumps directly to matching documents.

  As the product catalogue grows to thousands of products across
  Electronics, Clothing and Groceries, this index ensures fast
  query performance without scanning the entire collection.
*/