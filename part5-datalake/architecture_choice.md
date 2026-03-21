## Architecture Recommendation
For a fast-growing food delivery startup collecting GPS logs, customer reviews, payment transactions, and restaurant menu images, I would recommend a Data Lakehouse architecture.

A Data Lakehouse combines the flexibility of a Data Lake with the structure and query performance of a Data Warehouse, making it the ideal fit for this startup's diverse and fast-moving data needs.
- First, the data is multi-format by nature. GPS location logs are continuous streams of raw numerical data, customer text reviews are unstructured, payment transactions are structured tabular data, and restaurant menu images are binary files. A traditional Data Warehouse can only handle structured data, so it would immediately fail for images and text reviews. A Data Lake can store all formats but lacks query performance. A Data Lakehouse handles all four data types in one unified system.
- Second, the startup needs both real-time and historical analysis. Delivery tracking requires low-latency real-time processing of GPS data, while business reporting requires historical analysis of payment trends and customer behaviour. A Data Lakehouse supports both simultaneously, whereas a pure Data Lake struggles with fast structured queries.
- Third, scalability is critical for a fast-growing startup. As the company expands to new cities, data volumes will grow rapidly across all four data types. A Data Lakehouse scales cost-effectively by storing raw data cheaply while still enabling fast analytical queries.

Therefore a Data Lakehouse is the only architecture that handles variety, speed, and scale together in one system.

-----------------------------------------------------