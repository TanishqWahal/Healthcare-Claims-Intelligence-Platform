USE healthcare_claims;
CREATE TABLE hospitals (

    hospital_id INT AUTO_INCREMENT PRIMARY KEY,

    hospital_name VARCHAR(100) NOT NULL,

    city VARCHAR(50) NOT NULL,

    state VARCHAR(50) NOT NULL,

    phone VARCHAR(15) UNIQUE,

    email VARCHAR(100) UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);



CREATE TABLE departments (

    department_id INT AUTO_INCREMENT PRIMARY KEY,

    department_name VARCHAR(100) NOT NULL UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);






CREATE TABLE IF NOT EXISTS doctors (

    doctor_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    gender ENUM('M','F','O') NOT NULL,

    experience_years INT NOT NULL CHECK (experience_years >= 0),

    phone VARCHAR(15) UNIQUE,

    email VARCHAR(100) UNIQUE,

    hospital_id INT NOT NULL,

    department_id INT NOT NULL,

    joining_date DATE NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_doctor_hospital
        FOREIGN KEY (hospital_id)
        REFERENCES hospitals(hospital_id),

    CONSTRAINT fk_doctor_department
        FOREIGN KEY (department_id)
        REFERENCES departments(department_id)

);



CREATE TABLE IF NOT EXISTS patients (

    patient_id INT AUTO_INCREMENT PRIMARY KEY,

    first_name VARCHAR(50) NOT NULL,

    last_name VARCHAR(50) NOT NULL,

    gender ENUM('M','F','O') NOT NULL,

    date_of_birth DATE NOT NULL,

    blood_group ENUM(
        'A+','A-',
        'B+','B-',
        'AB+','AB-',
        'O+','O-'
    ),

    phone VARCHAR(15) UNIQUE,

    email VARCHAR(100) UNIQUE,

    city VARCHAR(50),

    state VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);



CREATE TABLE IF NOT EXISTS insurance (

    insurance_id INT AUTO_INCREMENT PRIMARY KEY,

    company_name VARCHAR(100) NOT NULL,

    plan_name VARCHAR(100) NOT NULL,

    coverage_percentage DECIMAL(5,2)
        CHECK (coverage_percentage BETWEEN 0 AND 100),

    customer_support VARCHAR(15),

    email VARCHAR(100) UNIQUE,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE TABLE IF NOT EXISTS appointments (

    appointment_id INT AUTO_INCREMENT PRIMARY KEY,

    patient_id INT NOT NULL,

    doctor_id INT NOT NULL,

    appointment_date DATETIME NOT NULL,

    appointment_type ENUM(
        'Consultation',
        'Follow-up',
        'Emergency',
        'Routine Checkup'
    ) NOT NULL,

    diagnosis VARCHAR(255),

    consultation_fee DECIMAL(10,2)
        CHECK (consultation_fee >= 0),

    status ENUM(
        'Scheduled',
        'Completed',
        'Cancelled'
    ) DEFAULT 'Scheduled',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id)

);


CREATE TABLE IF NOT EXISTS claims (

    claim_id INT AUTO_INCREMENT PRIMARY KEY,

    patient_id INT NOT NULL,

    doctor_id INT NOT NULL,

    insurance_id INT NOT NULL,

    appointment_id INT,

    claim_date DATE NOT NULL,

    claim_amount DECIMAL(10,2)
        CHECK (claim_amount > 0),

    approved_amount DECIMAL(10,2)
        DEFAULT 0,

    status ENUM(
        'Pending',
        'Approved',
        'Rejected'
    ) DEFAULT 'Pending',

    diagnosis VARCHAR(255),

    payment_date DATE,

    remarks VARCHAR(255),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_claim_patient
        FOREIGN KEY (patient_id)
        REFERENCES patients(patient_id),

    CONSTRAINT fk_claim_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctors(doctor_id),

    CONSTRAINT fk_claim_insurance
        FOREIGN KEY (insurance_id)
        REFERENCES insurance(insurance_id),

    CONSTRAINT fk_claim_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointments(appointment_id)

);



CREATE TABLE IF NOT EXISTS claim_audit (

    audit_id INT AUTO_INCREMENT PRIMARY KEY,

    claim_id INT NOT NULL,

    old_status ENUM(
        'Pending',
        'Approved',
        'Rejected'
    ),

    new_status ENUM(
        'Pending',
        'Approved',
        'Rejected'
    ) NOT NULL,

    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    changed_by VARCHAR(100),

    CONSTRAINT fk_audit_claim
        FOREIGN KEY (claim_id)
        REFERENCES claims(claim_id)

);