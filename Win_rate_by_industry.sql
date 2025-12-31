--Win rate by industry
SELECT  c.industry,
        COUNT(d.*) total_deals,
		COUNT(CASE WHEN d.is_won THEN 1 END) total_win,
		ROUND(100.0 * (COUNT(CASE WHEN d.is_won THEN 1 END) )/(COUNT(d.*)),2) win_pct
		
FROM deals d JOIN companies c 
ON d.company_id = c.company_id
GROUP BY c.industry
ORDER BY win_pct DESC
