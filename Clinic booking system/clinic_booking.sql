-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS ClinicDB;

-- Step 2: Tell MySQL to use it
USE ClinicDB;
-- ========================================
-- CLINIC BOOKING SYSTEM DATABASE SETUP
-- ========================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS ClinicDB;

-- Step 2: Use the database
USE ClinicDB;

-- Step 3: Drop old tables if re-running
DROP TABLE IF EXISTS Appointment_Treatments;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Treatments;
DROP TABLE IF EXISTS Patients;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Users;

-- USERS TABLE
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'doctor', 'receptionist') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PATIENTS TABLE
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('male', 'female', 'other') NOT NULL,
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    address TEXT
);

-- DOCTORS TABLE
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE,
    room_number VARCHAR(10)
);

-- TREATMENTS TABLE
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    treatment_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    cost DECIMAL(10,2) NOT NULL
);

-- APPOINTMENTS TABLE
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    reason VARCHAR(255),
    status ENUM('scheduled', 'completed', 'cancelled') DEFAULT 'scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- APPOINTMENT_TREATMENTS TABLE (for many-to-many)
CREATE TABLE Appointment_Treatments (
    appointment_id INT NOT NULL,
    treatment_id INT NOT NULL,
    PRIMARY KEY (appointment_id, treatment_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES Treatments(treatment_id) ON DELETE CASCADE
);
