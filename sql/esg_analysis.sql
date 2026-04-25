-- ============================================================
-- ESG Sustainability Analysis — SQL Data Pipeline
-- ============================================================
-- Database: Sustainability_Project
-- Source Table: company_esg_financial_dataset
-- Output View: v_esg_business_insights
-- ============================================================


-- ────────────────────────────────────────────────────────────
-- 1. EXPLORATION: Preview data structure
-- ────────────────────────────────────────────────────────────

SELECT *
FROM Sustainability_Project.company_esg_financial_dataset
LIMIT 10;


-- ────────────────────────────────────────────────────────────
-- 2. DATA QUALITY: Check for missing values in key columns
-- ────────────────────────────────────────────────────────────

SELECT COUNT(*) AS missing_count
FROM Sustainability_Project.company_esg_financial_dataset
WHERE Revenue IS NULL OR ESG_Overall IS NULL;


-- ────────────────────────────────────────────────────────────
-- 3. FEATURE ENGINEERING: Create analysis-ready view
-- ────────────────────────────────────────────────────────────
-- This view adds three derived columns:
--   * Calculated_Profit      = Revenue x (ProfitMargin / 100)
--   * Sustainability_Status  = ESG tier classification
--   * Carbon_Intensity       = CarbonEmissions / Revenue
-- ────────────────────────────────────────────────────────────

CREATE OR REPLACE VIEW v_esg_business_insights AS
SELECT
    CompanyID,
    CompanyName,
    Industry,
    Region,

    -- Financial: calculate actual profit from margin
    Revenue,
    (Revenue * (ProfitMargin / 100)) AS Calculated_Profit,

    -- ESG Classification: tier companies by overall score
    ESG_Overall,
    CASE
        WHEN ESG_Overall >= 70 THEN 'ESG_Leader'
        WHEN ESG_Overall BETWEEN 40 AND 69 THEN 'Average_Performer'
        ELSE 'High Risk / Laggard'
    END AS Sustainability_Status,

    -- Environmental: carbon efficiency metric
    CarbonEmissions,
    (CarbonEmissions / Revenue) AS Carbon_Intensity  -- emissions per dollar earned

FROM Sustainability_Project.company_esg_financial_dataset;


-- ────────────────────────────────────────────────────────────
-- 4. INDUSTRY BENCHMARKING: Compare sectors
-- ────────────────────────────────────────────────────────────

SELECT
    Industry,
    ROUND(AVG(ESG_Overall), 2)       AS Avg_ESG_Score,
    ROUND(AVG(Carbon_Intensity), 4)  AS Avg_Carbon_Intensity,
    SUM(Revenue)                     AS Total_Industry_Revenue
FROM v_esg_business_insights
GROUP BY Industry
ORDER BY Avg_ESG_Score DESC;


-- ────────────────────────────────────────────────────────────
-- 5. EXPORT: Final view for Power BI
-- ────────────────────────────────────────────────────────────

SELECT * FROM Sustainability_Project.v_esg_business_insights;
