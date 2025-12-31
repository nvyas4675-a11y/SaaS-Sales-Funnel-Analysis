-- Leads by Source
SELECT 
    marketing_source,
    COUNT(*) AS total_leads,
    COUNT(DISTINCT company_id) AS unique_companies
FROM contacts
GROUP BY marketing_source
ORDER BY total_leads DESC;

-- Conversion by Source (Company-level, since multiple contacts per company)
WITH source_companies AS (
    SELECT DISTINCT marketing_source, company_id
    FROM contacts
),
companies_with_deals AS (SELECT DISTINCT company_id FROM deals),
companies_with_wins AS (SELECT DISTINCT company_id FROM customers)
SELECT 
    sc.marketing_source,
    COUNT(DISTINCT sc.company_id) AS companies_touched,
    COUNT(DISTINCT cwd.company_id) AS companies_with_deals,
    COUNT(DISTINCT cww.company_id) AS companies_with_wins,
    ROUND(100.0 * COUNT(DISTINCT cwd.company_id) / COUNT(DISTINCT sc.company_id), 2) AS source_to_opp_pct,
    ROUND(100.0 * COUNT(DISTINCT cww.company_id) / COUNT(DISTINCT cwd.company_id), 2) AS opp_to_win_pct
FROM source_companies sc
LEFT JOIN companies_with_deals cwd ON sc.company_id = cwd.company_id
LEFT JOIN companies_with_wins cww ON sc.company_id = cww.company_id
GROUP BY sc.marketing_source
ORDER BY source_to_opp_pct DESC;