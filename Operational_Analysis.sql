-- SQL Analysis for Breakaway Tours Operations
-- Objective: Identify revenue leaks and vendor performance issues.

-- 1. Calculate Profit Margin per Trip (Revenue vs Cost)
SELECT 
    Destination, 
    Travel_Date, 
    (Revenue_INR - Cost_INR) AS Net_Profit,
    Margin AS Profit_Percentage
FROM Trip_Operations_Data
WHERE Status = 'Completed'
ORDER BY Net_Profit DESC;

-- 2. Identify High-Risk Vendors (Vendors with frequent issues)
SELECT 
    Vendor, 
    COUNT(Operational_Issue) AS Total_Complaints
FROM Trip_Operations_Data
WHERE Operational_Issue != 'None'
GROUP BY Vendor
HAVING COUNT(Operational_Issue) > 2;

-- 3. Future Pipeline Forecast (2026 Revenue Estimation)
SELECT 
    SUM(Revenue_INR) AS Total_Projected_Revenue
FROM Trip_Operations_Data
WHERE Status IN ('Scheduled', 'Planning')
AND Travel_Date > '2026-01-01';
