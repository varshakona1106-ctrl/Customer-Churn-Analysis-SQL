CREATE TABLE telco_customer_churn (
    customerID VARCHAR(20),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(10,2),
    Churn VARCHAR(5)
);

SELECT * FROM telco_customer_churn
LIMIT 5;

DROP TABLE IF EXISTS telco_customer_churn;

SELECT COUNT(*) 
FROM telco_customer_churn;


-- 1. Overall Churn Rate or Average Churn Rate
SELECT COUNT(*),
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND( 100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT (*), 2) AS churn_rate_percent
FROM telco_customer_churn;
/* Overall Churn Rate Analysis
I analyzed the overall customer churn rate to understand how many customers left the company.
The results showed that a noticeable portion of customers discontinued the service.
This indicates that customer retention is an important business challenge for the company.
Understanding the overall churn rate provides a baseline for further churn analysis across different customer segments. */

--2. Which contract type has the highest churn? OR 
-- Which type of contract customers are most likely to leave?
SELECT contract,
    COUNT(*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate_per_contract
FROM telco_customer_churn
GROUP BY contract
ORDER BY churn_rate_per_contract DESC;
/* Contract Type vs Churn Analysis
I analyzed churn rates across different contract types.
Customers with month-to-month contracts had the highest churn rate (42.71%).
Customers with one-year (11.28%) and two-year (2.85%) contracts were much less likely to leave.
This indicates that longer contract commitments improve customer retention. */

-- 3. Does Fiber Optic Service Have a Higher Churn Rate Than Other Internet Services? OR 
-- Do customers using Fiber Optic internet service leave the company more often than customers using DSL or No Internet Service?	
SELECT internetservice,
    COUNT (*) AS total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churned_custrate_percent
FROM telco_customer_churn
GROUP BY internetservice
ORDER BY churned_custrate_percent DESC;
/* I analyzed churn rates across different internet service types to identify which service had the highest customer churn.
The results showed that churn varied significantly across internet service categories.
Fiber Optic customers had the highest churn rate, followed by DSL customers.
Customers without internet service had the lowest churn rate and were more likely to stay with the company. */

SELECT * FROM telco_customer_churn
LIMIT 5;

--4. Do customers with Tech Support churn less? 
SELECT techsupport,
     COUNT(*) AS total_customers,
     SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY techsupport
ORDER BY churnrate_percent DESC;
/* I analyzed churn rates based on whether customers had Tech Support services.
The results showed a clear difference in churn behavior between the groups.
Customers without Tech Support had a significantly higher churn rate than customers who had Tech Support.
This suggests that providing customer support services may help improve customer retention. */

--5. Do Customers with Online Security Churn Less? OR 
-- Does providing Online Security help reduce customer churn?
SELECT onlinesecurity,
     COUNT(*) AS total_customers,
	 SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND( 100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY onlinesecurity
ORDER BY churnrate_percent DESC;
/* I analyzed churn rates based on whether customers had Online Security services.
The results showed a noticeable difference in churn behavior between the groups.
Customers without Online Security had a much higher churn rate than customers who had Online Security.
This suggests that Online Security services may help improve customer retention and reduce customer churn. */
	 
-- 6. Does Monthly Charge Influence Churn? OR 
-- Do customers who leave the company pay higher monthly charges than customers who stay?
SELECT churn,
     COUNT (*) AS total_customers,
     ROUND(AVG(monthlycharges), 2) AS avg_monthlycharges
FROM telco_customer_churn
GROUP BY churn;
/* I analyzed the average monthly charges of customers who stayed and customers who left the company.
The results showed that churned customers paid a higher average monthly charge compared to retained customers.
Customers who left the company had an average monthly charge of 74.44, while retained customers paid 61.31 on average.
This suggests that higher monthly charges may be one of the factors influencing customer churn. */

--7. Which payment method has the highest churn??
SELECT paymentmethod,
     COUNT(*) AS total_customers,
	 SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY paymentmethod
ORDER BY churnrate_percent DESC;
/* I analyzed churn rates across different payment methods.
Churn rates varied noticeably among payment methods.
Electronic Check customers had the highest churn rate (45.29%).
This indicates that Electronic Check users are more likely to leave the company. */

--8. Does Paperless Billing Influence Churn?
SELECT paperlessbilling,
     COUNT (*) AS totsl_customers,
	 SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY paperlessbilling
ORDER BY churnrate_percent;
/* I analyzed churn rates based on paperless billing usage.
Paperless billing customers had a churn rate of 33.59%, compared to 16.38% for non-paperless customers.
Customers using paperless billing were more likely to leave the company.
This suggests paperless billing is associated with higher customer churn. */

--9. Are senior citizens more likely to churn?
SELECT seniorcitizen,
     COUNT(*) AS total_customers,
	 SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY seniorcitizen
ORDER BY churnrate_percent DESC;
/* I analyzed churn rates between senior citizens and non-senior customers.
Senior citizens had a churn rate of 41.68%, compared to 23.65% for non-senior customers.
Senior citizens were significantly more likely to leave the company.
This suggests senior citizens are a higher-risk customer group for churn. */

--10. Do customers with partners churn less?
SELECT partner,
     COUNT(*) AS total_customers,
	 SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY partner
ORDER BY churnrate_percent DESC;
/* I analyzed churn rates based on partner status.
Customers without partners had a churn rate of 32.98%, compared to 19.72% for customers with partners.
Customers without partners were more likely to leave the company.
This suggests having a partner is associated with lower customer churn. */

--11. Do customers with dependents churn less?
SELECT dependents,
     COUNT(*) AS total_customers,
	 SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
	 ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churnrate_percent
FROM telco_customer_churn
GROUP BY dependents
ORDER BY churnrate_percent DESC;
/*  I analyzed churn rates based on dependent status.
Customers without dependents had a churn rate of 31.28%, compared to 15.53% for customers with dependents.
Customers without dependents were more likely to leave the company.
This suggests having dependents is associated with lower customer churn. */

--12. What is the Average Tenure of Churned vs Retained Customers?
-- Do customers who leave the company have shorter tenures than customers who stay?
SELECT churn,
     COUNT(*) AS total_customers,
	 ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_customer_churn
GROUP BY churn;
/* I analyzed the average tenure of churned and retained customers.
Churned customers had an average tenure of 17.98 months.
Retained customers had an average tenure of 37.65 months.
This suggests newer customers are more likely to leave the company. */

--13. How much revenue is lost due to churned customers?
SELECT
     COUNT(*) AS churned_customers,
	 ROUND(SUM(totalcharges), 2) AS revenue_lost
FROM telco_customer_churn
WHERE churn = 'Yes';
/* I analyzed the revenue associated with customers who left the company.
Revenue lost from churned customers was 2,862,926.90.
A significant portion of company revenue is impacted by customer churn.
This highlights the financial importance of improving customer retention.  */

-- 14. What are the characteristics of high-risk churn customers?
SELECT contract,
     internetservice,
	 techsupport,
	 onlinesecurity,
	 paperlessbilling,
	 seniorcitizen,
	 ROUND(AVG(monthlycharges), 2) AS avg_monthlycharges,
	 ROUND(AVG(tenure), 2) AS avg_tenure,
	 COUNT(*) AS churned_customers
FROM telco_customer_churn
WHERE churn = 'Yes'
GROUP BY contract,
     internetservice,
	 techsupport,
	 onlinesecurity,
	 paperlessbilling,
	 seniorcitizen
ORDER BY churned_customers DESC
LIMIT 10;
/* I identified the most common characteristics among churned customers.
Most churned customers were on month-to-month contracts with Fiber Optic service.
Many lacked Tech Support and Online Security while paying higher monthly charges.
This profile represents the highest-risk customer group for churn.  */










