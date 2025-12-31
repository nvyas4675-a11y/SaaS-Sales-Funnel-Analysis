-- Overall
SELECT
    SUM(CASE WHEN s.status = 'active' THEN s.mrr ELSE 0 END) AS total_active_mrr,
    ROUND(AVG(s.mrr)) AS avg_mrr_all,
    ROUND(AVG(d.deal_amount)) AS avg_won_deal_amount
FROM subscriptions s
CROSS JOIN (SELECT AVG(deal_amount) AS deal_amount FROM deals WHERE is_won) d;

-- By Segment (Active Subscriptions)
SELECT 
    comp.segment,
    SUM(CASE WHEN s.status = 'active' THEN s.mrr ELSE 0 END) AS total_active_mrr,
    ROUND(AVG(CASE WHEN s.status = 'active' THEN s.mrr END)) AS avg_mrr,
    ROUND(AVG(d.deal_amount)) AS avg_deal_amount
FROM subscriptions s
JOIN customers cust ON s.customer_id = cust.customer_id
JOIN companies comp ON cust.company_id = comp.company_id
JOIN deals d ON d.company_id = comp.company_id AND d.close_date = cust.created_at AND d.is_won
GROUP BY comp.segment;