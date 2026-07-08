import os
import random
import pandas as pd
from faker import Faker


NUM_HOSPITALS = 10
NUM_DEPARTMENTS = 8
NUM_DOCTORS = 500
NUM_PATIENTS = 20000
NUM_INSURANCE = 10
NUM_APPOINTMENTS = 50000
NUM_CLAIMS = 100000

fake = Faker("en_IN")

os.makedirs("data/raw", exist_ok=True)


def generate_hospitals():
    hospitals = [
        ["Apollo Hospital", "Delhi", "Delhi"],
        ["Fortis Hospital", "Noida", "Uttar Pradesh"],
        ["AIIMS", "Delhi", "Delhi"],
        ["Max Super Speciality", "Delhi", "Delhi"],
        ["Medanta", "Gurugram", "Haryana"],
        ["Manipal Hospital", "Bengaluru", "Karnataka"],
        ["Narayana Health", "Bengaluru", "Karnataka"],
        ["Ruby Hall Clinic", "Pune", "Maharashtra"],
        ["Kokilaben Hospital", "Mumbai", "Maharashtra"],
        ["Care Hospital", "Hyderabad", "Telangana"],
    ]

    data = []
    for hospital in hospitals:
        data.append({
            "hospital_name": hospital[0],
            "city": hospital[1],
            "state": hospital[2],
            "phone": fake.msisdn()[:10],
            "email": hospital[0].replace(" ", "").lower() + "@hospital.com"
        })

    pd.DataFrame(data).to_csv("data/raw/hospitals.csv", index=False)
    print(" hospitals.csv generated")


def generate_departments():
    departments = [
        "Cardiology",
        "Neurology",
        "Orthopedics",
        "Dermatology",
        "Pediatrics",
        "Oncology",
        "General Medicine",
        "ENT"
    ]

    pd.DataFrame({"department_name": departments}).to_csv(
        "data/raw/departments.csv",
        index=False
    )

    print(" departments.csv generated")


def generate_doctors():
    doctors = []

    for _ in range(NUM_DOCTORS):

        gender = random.choice(["M", "F"])

        doctors.append({
            "first_name": fake.first_name_male() if gender == "M" else fake.first_name_female(),
            "last_name": fake.last_name(),
            "gender": gender,
            "experience_years": random.randint(1, 35),
            "phone": fake.unique.msisdn()[:10],
            "email": fake.unique.email(),
            "hospital_id": random.randint(1, NUM_HOSPITALS),
            "department_id": random.randint(1, NUM_DEPARTMENTS),
            "joining_date": fake.date_between(start_date="-15y", end_date="today")
        })

    pd.DataFrame(doctors).to_csv("data/raw/doctors.csv", index=False)
    print(" doctors.csv generated")


def generate_patients():
    patients = []
    blood_groups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']

    for _ in range(NUM_PATIENTS):
        gender = random.choice(["M", "F"])

        patients.append({
            "first_name": fake.first_name_male() if gender == "M" else fake.first_name_female(),
            "last_name": fake.last_name(),
            "gender": gender,
            "date_of_birth": fake.date_of_birth(minimum_age=1, maximum_age=90),
            "blood_group": random.choice(blood_groups),
            "phone": fake.unique.msisdn()[:10],
            "email": fake.unique.email(),
            "city": fake.city(),
            "state": fake.state()
        })

    pd.DataFrame(patients).to_csv("data/raw/patients.csv", index=False)
    print(" patients.csv generated")


def generate_insurance():
    companies = [
        ("Star Health", "Gold"),
        ("Star Health", "Silver"),
        ("Care Health", "Premium"),
        ("Care Health", "Basic"),
        ("Niva Bupa", "Health Secure"),
        ("ICICI Lombard", "Complete Care"),
        ("HDFC ERGO", "Optima"),
        ("Bajaj Allianz", "Health Guard"),
        ("ManipalCigna", "ProHealth"),
        ("Aditya Birla Health", "Active One")
    ]

    data = []

    for company, plan in companies:
        data.append({
            "company_name": company,
            "plan_name": plan,
            "coverage_percentage": random.choice([70, 80, 85, 90, 95]),
            "customer_support": fake.msisdn()[:10],
            "email": (company.replace(" ", "").lower()+ "_"+ plan.replace(" ", "").lower()+ "@insurance.com")
        })
    pd.DataFrame(data).to_csv("data/raw/insurance.csv", index=False)
    print(" insurance.csv generated")


def generate_appointments():
    diagnoses = [
        "Diabetes", "Hypertension", "Migraine", "Asthma", "Arthritis",
        "COVID-19", "Heart Disease", "Fever", "Back Pain", "Skin Allergy"
    ]

    appointment_types = [
        "Consultation",
        "Follow-up",
        "Emergency",
        "Routine Checkup"
    ]

    statuses = [
        "Scheduled",
        "Completed",
        "Cancelled"
    ]

    appointments = []

    for _ in range(NUM_APPOINTMENTS):
        appointments.append({
            "patient_id": random.randint(1, NUM_PATIENTS),
            "doctor_id": random.randint(1, NUM_DOCTORS),
            "appointment_date": fake.date_time_between(start_date="-2y", end_date="now"),
            "appointment_type": random.choice(appointment_types),
            "diagnosis": random.choice(diagnoses),
            "consultation_fee": random.randint(500, 2500),
            "status": random.choice(statuses)
        })

    pd.DataFrame(appointments).to_csv("data/raw/appointments.csv", index=False)
    print(" appointments.csv generated")


def generate_claims():
    statuses = ["Pending", "Approved", "Rejected"]

    diagnoses = [
        "Diabetes", "Hypertension", "Migraine", "Asthma", "Arthritis",
        "COVID-19", "Heart Disease", "Fever", "Back Pain", "Skin Allergy"
    ]

    claims = []

    for _ in range(NUM_CLAIMS):
        claim_amount = random.randint(5000, 100000)
        approved_amount = random.randint(0, claim_amount)

        claims.append({
            "patient_id": random.randint(1, NUM_PATIENTS),
            "doctor_id": random.randint(1, NUM_DOCTORS),
            "insurance_id": random.randint(1, NUM_INSURANCE),
            "appointment_id": random.randint(1, NUM_APPOINTMENTS),
            "claim_date": fake.date_between(start_date="-2y", end_date="today"),
            "claim_amount": claim_amount,
            "approved_amount": approved_amount,
            "status": random.choice(statuses),
            "diagnosis": random.choice(diagnoses),
            "payment_date": fake.date_between(start_date="-2y", end_date="today"),
            "remarks": fake.sentence(nb_words=6)
        })

    pd.DataFrame(claims).to_csv("data/raw/claims.csv", index=False)
    print(" claims.csv generated")


def main():
    generate_hospitals()
    generate_departments()
    generate_doctors()
    generate_patients()
    generate_insurance()
    generate_appointments()
    generate_claims()

    print("\n All datasets generated successfully!")


if __name__ == "__main__":
    main()
