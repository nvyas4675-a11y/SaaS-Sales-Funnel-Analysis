--Conversion Rates
with t1 AS
(SELECT  COUNT(DISTINCT c.company_id) total_companies,
        COUNT(d.company_id) companies_with_deals,
		COUNT(d.*) total_deals,
		COUNT(cust.*) total_wins
FROM companies c
LEFT JOIN deals d ON c.company_id = d.company_id 
LEFT JOIN customers cust ON cust.company_id  = c.company_id)

SELECT ROUND(100.0 * companies_with_deals/total_companies,2) account_to_opportunity_pct,
       ROUND(100.0 * total_wins/total_deals,2) opportunity_to_win_pct,
	   ROUND(100.0 * (SELECT COUNT(*) FROM subscriptions WHERE status = 'canceled')/(SELECT COUNT(*) FROM subscriptions),2) churn_rate_pct
FROM t1