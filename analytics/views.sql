CREATE OR REPLACE VIEW vw_claim_summary AS
SELECT
    c.claim_id,

    CONCAT(p.first_name,' ',p.last_name) AS patient_name,

    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,

    h.hospital_name,

    dep.department_name,

    i.company_name,

    i.plan_name,

    c.claim_amount,

    c.approved_amount,

    c.status,

    c.claim_date,

    c.payment_date,

    c.diagnosis

FROM claims c

JOIN patients p
ON c.patient_id = p.patient_id

JOIN doctors d
ON c.doctor_id = d.doctor_id

JOIN hospitals h
ON d.hospital_id = h.hospital_id

JOIN departments dep
ON d.department_id = dep.department_id

JOIN insurance i
ON c.insurance_id = i.insurance_id;


CREATE OR REPLACE VIEW vw_patient_history AS
SELECT

    p.patient_id,

    CONCAT(p.first_name,' ',p.last_name) AS patient_name,

    COUNT(DISTINCT a.appointment_id) AS total_appointments,

    COUNT(DISTINCT c.claim_id) AS total_claims,

    SUM(c.claim_amount) AS total_claim_amount,

    SUM(c.approved_amount) AS total_approved_amount

FROM patients p

LEFT JOIN appointments a
ON p.patient_id=a.patient_id

LEFT JOIN claims c
ON p.patient_id=c.patient_id

GROUP BY
p.patient_id,
patient_name;


CREATE OR REPLACE VIEW vw_hospital_performance AS
SELECT

    h.hospital_id,

    h.hospital_name,

    COUNT(DISTINCT d.doctor_id) AS total_doctors,

    COUNT(DISTINCT a.patient_id) AS unique_patients,

    COUNT(c.claim_id) AS total_claims,

    SUM(c.claim_amount) AS total_claim_amount,

    SUM(c.approved_amount) AS total_approved_amount

FROM hospitals h

LEFT JOIN doctors d
ON h.hospital_id=d.hospital_id

LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id

LEFT JOIN claims c
ON d.doctor_id=c.doctor_id

GROUP BY
h.hospital_id,
h.hospital_name;


CREATE OR REPLACE VIEW vw_insurance_performance AS
SELECT

    i.insurance_id,

    i.company_name,

    i.plan_name,

    COUNT(c.claim_id) AS total_claims,

    SUM(c.claim_amount) AS total_claim_amount,

    SUM(c.approved_amount) AS total_approved_amount,

    AVG(c.claim_amount) AS average_claim

FROM insurance i

LEFT JOIN claims c
ON i.insurance_id=c.insurance_id

GROUP BY

i.insurance_id,
i.company_name,
i.plan_name;


CREATE OR REPLACE VIEW vw_doctor_performance AS
SELECT

    d.doctor_id,

    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,

    h.hospital_name,

    dep.department_name,

    COUNT(DISTINCT a.patient_id) AS patients_treated,

    COUNT(c.claim_id) AS total_claims,

    SUM(c.claim_amount) AS total_claim_amount,

    SUM(c.approved_amount) AS total_approved_amount

FROM doctors d

JOIN hospitals h
ON d.hospital_id=h.hospital_id

JOIN departments dep
ON d.department_id=dep.department_id

LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id

LEFT JOIN claims c
ON d.doctor_id=c.doctor_id

GROUP BY

d.doctor_id,
doctor_name,
h.hospital_name,
dep.department_name;