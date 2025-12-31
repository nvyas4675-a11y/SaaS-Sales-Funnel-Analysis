-- Overview of funnel
SELECT
    (SELECT COUNT(*) FROM companies) AS total_companies,
    (SELECT COUNT(DISTINCT company_id) FROM contacts) AS companies_with_contacts,
    (SELECT COUNT(*) FROM contacts) AS total_contacts,
    (SELECT COUNT(DISTINCT company_id) FROM deals) AS companies_with_deals,
    (SELECT COUNT(*) FROM deals) AS total_deals,
    (SELECT COUNT(*) FROM customers) AS total_wins_customers,
    (SELECT COUNT(*) FROM subscriptions WHERE status = 'active') AS active_subscriptions,
    (SELECT COUNT(*) FROM subscriptions WHERE status = 'canceled') AS churned_subscriptions;