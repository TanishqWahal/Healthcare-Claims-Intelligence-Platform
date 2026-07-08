#Total Revenue
SELECT SUM(approved_amount) AS Revenue FROM claims;
#Approval %
SELECT ROUND(SUM(status='Approved')*100.0/COUNT(*),2)
AS Approval_Percentage FROM claims;

#Rejection %
SELECT ROUND(SUM(status='Rejected')*100.0/COUNT(*),2)
AS Rejection_Percentage FROM claims;

#Hospital-wise Revenue
SELECT

h.hospital_name,

SUM(c.approved_amount) AS Revenue

FROM claims c

JOIN doctors d

ON c.doctor_id=d.doctor_id

JOIN hospitals h

ON d.hospital_id=h.hospital_id

GROUP BY

h.hospital_name

ORDER BY Revenue DESC;


#Insurance-wise Claim Amount

SELECT

i.company_name,

SUM(c.claim_amount) AS Total_Claim

FROM claims c

JOIN insurance i

ON c.insurance_id=i.insurance_id

GROUP BY

i.company_name;





