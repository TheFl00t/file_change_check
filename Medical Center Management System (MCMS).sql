SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS medical_card_excharge;
DROP TABLE IF EXISTS excharges;
DROP TABLE IF EXISTS bills;
DROP TABLE IF EXISTS patient_procedures;
DROP TABLE IF EXISTS patient_services;
DROP TABLE IF EXISTS medical_card_prescriptions;
DROP TABLE IF EXISTS prescriptions;
DROP TABLE IF EXISTS medical_card_diagnoses;
DROP TABLE IF EXISTS diagnoses;
DROP TABLE IF EXISTS medical_cards;
DROP TABLE IF EXISTS appointments;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS procedures;
DROP TABLE IF EXISTS services;

SET FOREIGN_KEY_CHECKS = 1;

-- Таблиця послуг
CREATE TABLE `services` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `description` TEXT NOT NULL,
    `cost` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY(`id`)
);

-- Таблиця процедур
CREATE TABLE `procedures` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(255) NOT NULL UNIQUE,
    `description` TEXT NOT NULL,
    `cost` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY(`id`)
);

-- Таблиця пацієнтів
CREATE TABLE `patients` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `birth_date` DATE NOT NULL,
    `phone` VARCHAR(15) NOT NULL UNIQUE,
    PRIMARY KEY(`id`)
);

-- Таблиця лікарів
CREATE TABLE `doctors` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `speciality` VARCHAR(50) NOT NULL,
    `phone` VARCHAR(15) NOT NULL UNIQUE,
    `email` VARCHAR(100),
    PRIMARY KEY(`id`)
);

-- Таблиця записів
CREATE TABLE `appointments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `doctor_id` INTEGER NOT NULL,
    `patient_id` INTEGER NOT NULL,
    `date` DATETIME NOT NULL,
    `status` ENUM('Заплановано', 'Проведено', 'Скасовано') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY (`doctor_id`) REFERENCES `doctors`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE
);

-- Медичні картки
CREATE TABLE `medical_cards` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `patient_id` INTEGER NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE
);

-- Діагнози
CREATE TABLE `diagnoses` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`id`)
);

-- Діагнози в картках
CREATE TABLE `medical_card_diagnoses` (
    `medical_card_id` INTEGER NOT NULL,
    `diagnosis_id` INTEGER NOT NULL,
    PRIMARY KEY(`medical_card_id`, `diagnosis_id`),
    FOREIGN KEY (`medical_card_id`) REFERENCES `medical_cards`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnoses`(`id`) ON DELETE CASCADE
);

-- Призначення
CREATE TABLE `prescriptions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`id`)
);

-- Призначення в картках
CREATE TABLE `medical_card_prescriptions` (
    `medical_card_id` INTEGER NOT NULL,
    `prescription_id` INTEGER NOT NULL,
    PRIMARY KEY(`medical_card_id`, `prescription_id`),
    FOREIGN KEY (`medical_card_id`) REFERENCES `medical_cards`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions`(`id`) ON DELETE CASCADE
);

-- Послуги пацієнтів
CREATE TABLE `patient_services` (
    `patient_id` INTEGER NOT NULL,
    `service_id` INTEGER NOT NULL,
    PRIMARY KEY(`patient_id`, `service_id`),
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`service_id`) REFERENCES `services`(`id`) ON DELETE CASCADE
);

-- Процедури пацієнтів
CREATE TABLE `patient_procedures` (
    `patient_id` INTEGER NOT NULL,
    `procedure_id` INTEGER NOT NULL,
    PRIMARY KEY(`patient_id`, `procedure_id`),
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`procedure_id`) REFERENCES `procedures`(`id`) ON DELETE CASCADE
);

-- Рахунки
CREATE TABLE `bills` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `patient_id` INTEGER NOT NULL UNIQUE,
    `amount` DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    `status` ENUM('Не оплачено', 'Оплачено') NOT NULL,
    PRIMARY KEY(`id`),
    FOREIGN KEY (`patient_id`) REFERENCES `patients`(`id`) ON DELETE CASCADE
);

-- Виписки
CREATE TABLE `excharges` (
    `id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
    `name` ENUM('Виписаний', 'Потребує додаткового лікування', 'Невиписаний') NOT NULL,
    `description` TEXT NOT NULL,
    PRIMARY KEY(`id`)
);

-- Виписки в картках
CREATE TABLE `medical_card_excharge` (
    `medical_card_id` INTEGER NOT NULL,
    `excharge_id` INTEGER NOT NULL,
    PRIMARY KEY(`medical_card_id`, `excharge_id`),
    FOREIGN KEY (`medical_card_id`) REFERENCES `medical_cards`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`excharge_id`) REFERENCES `excharges`(`id`) ON DELETE CASCADE,
	CONSTRAINT `unique_med_card_excharge` UNIQUE (`medical_card_id`)
);

-- Трiггери
DROP TRIGGER IF EXISTS add_med_cart_for_patient;
DROP TRIGGER IF EXISTS add_bills_for_patient;

DELIMITER $$

CREATE TRIGGER add_med_cart_for_patient
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
    INSERT INTO medical_cards (patient_id)
    VALUES (NEW.id);
END $$

CREATE TRIGGER add_bills_for_patient
AFTER INSERT ON patients
FOR EACH ROW
BEGIN
	INSERT INTO bills (patient_id, amount, status)
	VALUES (
		NEW.id,
		0.00,
		'Оплачено'
	);
END $$

DELIMITER ;
