````markdown
# 🛒 Retail Sales SQL Analysis Project

This project demonstrates data cleaning and business insights using **SQL queries** on a retail sales dataset. It involves analyzing customer behavior, sales trends, and transaction patterns.

---

## 🧠 Project Overview

- **Database Name:** `p1_retail_db`
- **Table:** `retail_sales`
- **Tech Stack:** MySQL
- **Focus:** SQL for data cleaning, transformation, and business reporting.

---

## 🧾 Dataset Schema

| Column Name      | Data Type   | Description                            |
|------------------|-------------|----------------------------------------|
| transactions_id  | INT         | Unique transaction ID                  |
| sale_date        | DATE        | Date of the sale                       |
| sale_time        | TIME        | Time of the sale                       |
| customer_id      | INT         | Unique customer ID                     |
| gender           | VARCHAR(10) | Gender of the customer                 |
| age              | INT         | Age of the customer                    |
| category         | VARCHAR(35) | Product category                       |
| quantity         | INT         | Quantity sold                          |
| price_per_unit   | FLOAT       | Price per unit of the product          |
| cogs             | FLOAT       | Cost of goods sold                     |
| total_sale       | FLOAT       | Total sale amount                      |

---

## 🧹 Data Cleaning

- ✅ Checked total number of records
- ✅ Counted unique customers
- ✅ Extracted distinct product categories
- ✅ Deleted records with any `NULL` values

---

## 📊 Business Insights Queries

### 1. 🗓️ Sales on a Specific Date
```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
````

### 2. 👕 High-Quantity Clothing Sales in Nov-2022

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND quantity >= 4;
```

### 3. 💰 Total Sales per Category

```sql
SELECT category, SUM(total_sale) AS net_sale, COUNT(*) AS total_order
FROM retail_sales
GROUP BY category;
```

### 4. 👵 Average Age of Beauty Category Buyers

```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 5. 📈 Transactions Over 1000 in Value

```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

### 6. 👨‍👩‍👧 Gender-wise Transaction Count per Category

```sql
SELECT category, gender, COUNT(*) AS total_trans
FROM retail_sales
GROUP BY category, gender;
```

### 7. 🏆 Best-Selling Month per Year by Avg Sale

```sql
SELECT year, month, avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) 
                    ORDER BY AVG(total_sale) DESC) AS ran
    FROM retail_sales
    GROUP BY 1, 2
) AS t1
WHERE ran = 1;
```

### 8. 🥇 Top 5 Customers by Total Sales

```sql
SELECT customer_id, SUM(total_sale) AS sales
FROM retail_sales
GROUP BY customer_id
ORDER BY sales DESC
LIMIT 5;
```

### 9. 📦 Unique Customers per Category

```sql
SELECT category, COUNT(DISTINCT customer_id) AS uni_cut_cou
FROM retail_sales
GROUP BY category;
```

### 10. 🕐 Shift-wise Order Count (Morning, Afternoon, Evening)

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

## 📚 Learning Outcomes

* SQL syntax mastery (SELECT, WHERE, GROUP BY, CTEs, CASE, RANK)
* Data cleaning with conditional filters and null checks
* Business-focused analysis using aggregation and window functions

---

## 📎 Author

**Anish [@Anish62027](https://github.com/Anish62027)**
*BTech CSE | Data Analyst | SQL | Python | Power BI*

---

⭐ Star this repo if you find it useful! Feel free to fork and customize for your own learning or interviews!

```

---

Let me know if you'd like:
- A sample dataset in `.csv`
- ER diagram
- Power BI visuals based on this
- README in Hindi or dual language

I'm happy to help you make this repo standout!
```
