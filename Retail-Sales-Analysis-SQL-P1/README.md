
```markdown
# 🛒 Retail Sales SQL Analysis Project

This project showcases how to use **SQL** for real-world business insights and data cleaning. Using a retail sales dataset, we analyze customer behavior, category performance, and sales patterns across time and customer demographics.

---

## 🧠 Project Overview

- **Database Name:** `p1_retail_db`
- **Table:** `retail_sales`
- **SQL Engine:** MySQL
- **Skills Used:** Data Cleaning, Aggregation, Window Functions, Conditional Logic

---


### 🗂️ **Entity: `retail_sales`**

Since this is a single-table project, we’ll treat each conceptual component (like customer, product category, and transaction) as logical entities that can be split later for normalization. But for this simplified form, here is the **ER diagram structure**:

---

### 🧩 **ER Diagram (Simplified)**

```plaintext
+-------------------+
|   retail_sales    |
+-------------------+
| transactions_id PK|
| sale_date         |
| sale_time         |
| customer_id       |
| gender            |
| age               |
| category          |
| quantity          |
| price_per_unit    |
| cogs              |
| total_sale        |
+-------------------+
```

#### 🔄 Relationships (in normalized form):

If you wanted to normalize this into separate tables (for scalability or relational analysis), here's how the ERD would look logically:

```plaintext
+-------------------+         +------------------+         +------------------+
|   Customers       |         |  Categories       |         |  Transactions     |
+-------------------+         +------------------+         +------------------+
| customer_id   PK  |<------- | category_name PK  |<------- | transactions_id PK|
| gender            |         +------------------+         | sale_date         |
| age               |                                         sale_time         |
+-------------------+                                         category_name FK  |
                                                              customer_id   FK  |
                                                              quantity           |
                                                              price_per_unit     |
                                                              cogs               |
                                                              total_sale         |
                                                             +------------------+
```


## 🧹 Data Cleaning Steps

- ✅ Counted total records in the table
- ✅ Counted unique customers
- ✅ Extracted unique product categories
- ✅ Removed rows with `NULL` values

---

## 📊 Business Insights (Key SQL Queries)

### 1. 🗓️ Sales on a Specific Date
```sql
SELECT * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';
````

### 2. 👕 High-Quantity Clothing Sales in November 2022

```sql
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >= 4;
```

### 3. 💰 Total Sales Per Category

```sql
SELECT category, 
       SUM(total_sale) AS net_sale, 
       COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

### 4. 👵 Average Age of Customers Buying Beauty Products

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 5. 📈 Transactions Where Sales > 1000

```sql
SELECT * 
FROM retail_sales 
WHERE total_sale > 1000;
```

### 6. 👨‍👩‍👧 Gender-Wise Transaction Count Per Category

```sql
SELECT category, gender, COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category, gender;
```

### 7. 🏆 Best-Selling Month (by Avg Sale) Each Year

```sql
SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) AS ranked_months
WHERE rank = 1;
```

### 8. 🥇 Top 5 Customers by Total Sales

```sql
SELECT customer_id, 
       SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### 9. 📦 Unique Customers Per Category

```sql
SELECT category, 
       COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

### 10. 🕐 Shift-wise Order Counts (Morning, Afternoon, Evening)

```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift
ORDER BY shift;
```

---

## 🎓 Learning Outcomes

* ✅ Writing clean, efficient SQL for data exploration
* ✅ Using `CASE`, `CTE`, `GROUP BY`, `RANK()`, `EXTRACT()`, and `DATE_FORMAT()`
* ✅ Applying SQL to solve real-world business questions

---

## 👨‍💻 Author

**Anish** [@Anish62027](https://github.com/Anish62027)
*BTech CSE | Data Analyst | SQL | Python | Power BI*

---

## ⭐ Give a Star

If you found this helpful, feel free to ⭐ star the repository.
Fork and use it for your portfolio, interview prep, or learning journey!

---

## 📎 Extras (On Request)

Let me know if you’d like:

* Sample dataset in `.csv`
* ER Diagram image (PNG)
* Power BI Dashboard based on this dataset
* README in Hindi or bilingual

---
