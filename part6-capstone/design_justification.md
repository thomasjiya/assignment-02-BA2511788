## Storage Systems
For the hospital AI system, four different storage technologies were selected, each chosen specifically for the nature of its goal.
- **Goal 1 (readmission prediction)**, a relational database (MySQL) was chosen to store structured patient records including treatment history, diagnoses, medications, and lab results. MySQL's ACID compliance is non-negotiable here — a patient's medical history must always be accurate and consistent, as incorrect data could directly harm clinical decisions.

- **Goal 2 (plain English doctor queries)**, a vector database (Pinecone) was selected. Patient records are converted into embeddings using sentence-transformers and stored as vectors. When a doctor asks a question like "Has this patient had a cardiac issue?", the query is also embedded and the vector database finds the most semantically similar records instantly. A traditional keyword search would fail here because medical language varies widely — "cardiac arrest", "heart attack", and "myocardial infarction" mean the same thing but share no common keywords.

- **Goal 3 (monthly management reports)**, a data warehouse using a star schema was chosen. The fact table stores transaction-level data like bed assignments and department costs, while dimension tables store dates, departments, and wards. This structure is optimized for analytical queries like total costs per department or monthly bed occupancy rates, which would be extremely slow on a transactional database.

- **Goal 4 (real-time ICU vitals)**, a streaming store using Apache Kafka combined with a time-series database was selected. ICU devices generate thousands of readings per second. Relational databases cannot handle this volume and speed — Kafka ingests the stream instantly while the time-series database stores readings efficiently for anomaly detection and alerting.
_____________________________________________________

## OLTP vs OLAP Boundary
- The OLTP boundary in this system covers all real-time transactional operations — patient admissions, treatment records, ICU vital readings, and doctor interactions. These operations happen continuously throughout the day and require fast, consistent reads and writes. MySQL and Kafka operate on the OLTP side of the architecture.

- The OLAP boundary begins at the ETL pipeline. Once data is cleaned, transformed, and loaded into the data warehouse, it crosses into the analytical layer. The data warehouse is never written to directly by operational systems — it receives processed, historical snapshots of data. The BI engine then runs complex aggregations and trend analyses on this warehouse data to generate management reports. This clear separation ensures that heavy analytical queries never slow down the live patient care systems.
_____________________________________________________

## Trade-offs
The most significant trade-off in this design is complexity versus performance. Using four different storage systems — MySQL, Kafka, a vector database, and a data warehouse — introduces significant operational complexity. The engineering team must maintain multiple systems, handle data synchronization between them, and ensure the ETL pipeline runs reliably without data loss or duplication.

To mitigate this, the hospital could adopt a Data Lakehouse architecture as an intermediate step — storing all raw data in one unified system like Databricks Delta Lake, which supports both real-time streaming and analytical queries. This reduces the number of systems to maintain while preserving performance. Additionally, implementing automated monitoring and alerting on the ETL pipeline would catch synchronization failures early before they affect clinical reporting or AI model accuracy.
_____________________________________________________