DELIMITER $$

CREATE PROCEDURE GetPatientHistory(IN p_patient_id INT)

BEGIN

SELECT

    p.patient_id,

    CONCAT(p.first_name,' ',p.last_name) AS patient_name,

    d.doctor_id,

    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,

    h.hospital_name,

    a.appointment_date,

    c.claim_amount,

    c.approved_amount,

    c.status,

    c.diagnosis

FROM patients p

JOIN appointments a
ON p.patient_id = a.patient_id

JOIN doctors d
ON a.doctor_id = d.doctor_id

JOIN hospitals h
ON d.hospital_id = h.hospital_id

LEFT JOIN claims c
ON a.appointment_id = c.appointment_id

WHERE p.patient_id = p_patient_id

ORDER BY a.appointment_date DESC;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE GetHospitalRevenue(IN p_hospital_id INT)
BEGIN

    SELECT
        h.hospital_id,
        h.hospital_name,
        COUNT(DISTINCT c.claim_id) AS total_claims,
        SUM(c.claim_amount) AS total_claim_amount,
        SUM(c.approved_amount) AS total_approved_amount

    FROM hospitals h

    JOIN doctors d
        ON h.hospital_id = d.hospital_id

    JOIN claims c
        ON d.doctor_id = c.doctor_id

    WHERE h.hospital_id = p_hospital_id

    GROUP BY
        h.hospital_id,
        h.hospital_name;

END $$

DELIMITER ;




DELIMITER $$

CREATE PROCEDURE GetDoctorPerformance(IN p_doctor_id INT)

BEGIN

SELECT

    d.doctor_id,

    CONCAT(d.first_name,' ',d.last_name) AS doctor_name,

    COUNT(DISTINCT a.patient_id) AS patients_treated,

    COUNT(c.claim_id) AS total_claims,

    SUM(c.approved_amount) AS revenue

FROM doctors d

LEFT JOIN appointments a
ON d.doctor_id=a.doctor_id

LEFT JOIN claims c
ON d.doctor_id=c.doctor_id

WHERE d.doctor_id=p_doctor_id

GROUP BY d.doctor_id,doctor_name;

END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetInsurancePerformance(IN p_company VARCHAR(100))

BEGIN

SELECT

    company_name,

    plan_name,

    COUNT(c.claim_id) AS total_claims,

    SUM(c.claim_amount) AS total_claim_amount,

    SUM(c.approved_amount) AS total_approved_amount

FROM insurance i

LEFT JOIN claims c
ON i.insurance_id=c.insurance_id

WHERE company_name=p_company

GROUP BY company_name,plan_name;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE GetMonthlyClaims(

IN p_year INT,

IN p_month INT

)

BEGIN

SELECT

COUNT(*) AS total_claims,

SUM(claim_amount) AS total_claim_amount,

SUM(approved_amount) AS total_approved_amount

FROM claims

WHERE YEAR(claim_date)=p_year

AND MONTH(claim_date)=p_month;

END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE TopDoctorsByRevenue()

BEGIN

SELECT

d.doctor_id,

CONCAT(d.first_name,' ',d.last_name) AS doctor_name,

SUM(c.approved_amount) AS revenue

FROM doctors d

JOIN claims c
ON d.doctor_id=c.doctor_id

GROUP BY d.doctor_id,doctor_name

ORDER BY revenue DESC

LIMIT 5;

END $$

DELIMITER ;