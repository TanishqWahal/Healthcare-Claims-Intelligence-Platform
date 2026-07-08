-- ==========================================================
-- Healthcare Claims Intelligence Platform
-- Indexes
-- ==========================================================

-- ==========================================================
-- CLAIMS TABLE
-- ==========================================================

CREATE INDEX idx_claim_patient
ON claims(patient_id);

CREATE INDEX idx_claim_doctor
ON claims(doctor_id);

CREATE INDEX idx_claim_insurance
ON claims(insurance_id);

CREATE INDEX idx_claim_status
ON claims(status);

CREATE INDEX idx_claim_date
ON claims(claim_date);


-- ==========================================================
-- APPOINTMENTS TABLE
-- ==========================================================

CREATE INDEX idx_appointment_patient
ON appointments(patient_id);

CREATE INDEX idx_appointment_doctor
ON appointments(doctor_id);

CREATE INDEX idx_appointment_date
ON appointments(appointment_date);


-- ==========================================================
-- DOCTORS TABLE
-- ==========================================================

CREATE INDEX idx_doctor_hospital
ON doctors(hospital_id);

CREATE INDEX idx_doctor_department
ON doctors(department_id);


-- ==========================================================
-- PATIENTS TABLE
-- ==========================================================

CREATE INDEX idx_patient_city
ON patients(city);

CREATE INDEX idx_patient_state
ON patients(state);


-- ==========================================================
-- INSURANCE TABLE
-- ==========================================================

CREATE INDEX idx_insurance_company
ON insurance(company_name);