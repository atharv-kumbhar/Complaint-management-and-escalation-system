CREATE VIEW vw_complaints_by_technician AS
SELECT 
  t.tech_id,
  t.name AS technician_name,
  c.status,
  COUNT(*) AS total_complaints,
  RANK() OVER (PARTITION BY c.status ORDER BY COUNT(*) DESC) AS tech_rank
FROM 
  complaints c
JOIN 
  technicians t ON c.assigned_technician = t.tech_id
GROUP BY 
  t.tech_id, t.name, c.status;


CREATE OR REPLACE VIEW vw_daily_complaint_trend AS
SELECT 
  TRUNC(created_date) AS complaint_day,
  COUNT(*) AS total_complaints,
  LAG(COUNT(*)) OVER (ORDER BY TRUNC(created_date)) AS previous_day_count,
  COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY TRUNC(created_date)) AS daily_change
FROM 
  complaints
GROUP BY 
  TRUNC(created_date);


CREATE OR REPLACE VIEW vw_escalation_rate AS
SELECT 
  t.tech_id,
  t.name AS technician_name,
  COUNT(c.complaint_id) AS total_assigned,
  COUNT(e.complaint_id) AS escalated_count,
  ROUND(
    (COUNT(e.complaint_id) * 100) / NULLIF(COUNT(c.complaint_id), 0), 2
  ) AS escalation_percentage
FROM 
  technicians t
LEFT JOIN 
  complaints c ON t.tech_id = c.assigned_technician
LEFT JOIN 
  escalations e ON c.complaint_id = e.complaint_id
GROUP BY 
  t.tech_id, t.name;
  

CREATE OR REPLACE VIEW vw_resolution_time AS
SELECT 
  c.complaint_id,
  cu.name AS customer_name,
  c.status,
  c.created_date,
  c.resolved_at,
  ROUND((c.resolved_at - c.created_date) * 24, 2) AS hours_to_resolve,
  DENSE_RANK() OVER (ORDER BY (c.resolved_at - c.created_date)) AS resolution_rank
FROM 
  complaints c
JOIN 
  customers cu ON cu.customer_id = c.customer_id
WHERE 
  c.status = 'Resolved';

CREATE OR REPLACE VIEW vw_customer_frequency AS
SELECT 
  cu.customer_id,
  cu.name AS customer_name,
  COUNT(c.complaint_id) AS complaint_count,
  DENSE_RANK() OVER (ORDER BY COUNT(c.complaint_id) DESC) AS freq_rank
FROM 
  customers cu
LEFT JOIN 
  complaints c ON cu.customer_id = c.customer_id
GROUP BY 
  cu.customer_id, cu.name;
  

CREATE OR REPLACE VIEW vw_open_escalated_complaints AS
SELECT 
  c.complaint_id,
  cu.name AS customer_name,
  c.status,
  e.levels AS escalation_level,
  t.name AS technician,
  ROUND(SYSDATE - c.created_date, 1) AS days_pending
FROM 
  complaints c
JOIN customers cu ON cu.customer_id = c.customer_id
LEFT JOIN technicians t ON t.tech_id = c.assigned_technician
LEFT JOIN escalations e ON e.complaint_id = c.complaint_id
WHERE 
  c.status IN ('Pending', 'Escalated');
