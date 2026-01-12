-- SQL Portfolio: Operational Analysis for Breakaway Tours
-- Data Source: Trip_Operations_Data.csv
-- Objective: To identify revenue leaks, vendor performance issues, and forecast 2026 growth.

-- ---------------------------------------------------------
-- 1. PROFITABILITY ANALYSIS
-- Calculating Net Profit and Margin % for completed trips to identify most profitable destinations.
-- ---------------------------------------------------------
SELECT 
    Destination, 
    Travel_Date, 
    Client_Type,
    (Revenue_INR - Cost_INR) AS Net_Profit_INR,
    Margin AS Profit_Percentage
FROM Trip_Operations_Data
WHERE Status = 'Completed'
ORDER BY Net_Profit_INR DESC;

-- ---------------------------------------------------------
-- 2. RISK MANAGEMENT: HIGH-RISK VENDORS
-- Identifying vendors who have caused operational issues (Delays, Complaints) more than twice.
-- This helps in supply chain decision making (Blacklisting vs Retaining).
-- ---------------------------------------------------------
SELECT 
    Vendor, 
    COUNT(Operational_Issue) AS Total_Complaints,
    STRING_AGG(Operational_Issue, ', ') AS Issue_Types
FROM Trip_Operations_Data
WHERE Operational_Issue != 'None'
GROUP BY Vendor
HAVING COUNT(Operational_Issue) > 2;

-- ---------------------------------------------------------
-- 3. FUTURE PIPELINE FORECAST (2026)
-- Estimating projected cash flow from Scheduled and Planning phase trips for the next fiscal year.
-- ---------------------------------------------------------
SELECT 
    Status,
    COUNT(Booking_ID) AS Total_Upcoming_Trips,
    SUM(Revenue_INR) AS Projected_Revenue_INR
FROM Trip_Operations_Data
WHERE Travel_Date BETWEEN '2026-01-01' AND '2026-12-31'
GROUP BY Status;
