--Overall average
SELECT ROUND(AVG(close_date - created_at),1) avg_sales_cycle_days
FROM deals

-- By Segment
SELECT comp.segment,
       ROUND(AVG(d.close_date - d.created_at),1) avg_cycle_days,
	   COUNT(*) num_deals
FROM deals d 
JOIN companies comp ON d.company_id =  comp.company_id
GROUP BY comp.segment