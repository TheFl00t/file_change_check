-- Загальна вартість процедур для конкретного пацієнта
SELECT SUM(p.cost) AS total_procedure_cost
FROM patient_procedures pp
JOIN procedures p ON pp.procedure_id = p.id
WHERE pp.patient_id = 1;

-- Загальна вартість усіх послуг для конкретного пацієнта
SELECT SUM(s.cost) AS total_service_cost
FROM patient_services ps
JOIN services s ON ps.service_id = s.id
WHERE ps.patient_id = 1;

-- Загальна вартість усіх послуг та процедур
SELECT
	(
	SELECT SUM(s.cost) AS total_service_cost
	FROM patient_services ps
	JOIN services s ON ps.service_id = s.id
	WHERE ps.patient_id = 1
	) + (
	SELECT SUM(p.cost) AS total_procedure_cost
	FROM patient_procedures pp
	JOIN procedures p ON pp.procedure_id = p.id
	WHERE pp.patient_id = 1
	) AS total_cost;


-- -- Основнi таблицi -- --

-- ТАБЛИЦЯ `patients` --
-- Додавання запису
-- > при додаваннi пацієнта до бази даних створюється його нова мед-карта
INSERT INTO patients (first_name, last_name, birth_date, phone)
	VALUES ('Степан', 'Гузлiвський', '1995-10-2', '380658893121');

-- Видалення запису по ID
-- > при видаленні пацієнта з бази даних його медкарта теж видаляється
DELETE FROM patients
WHERE id = 1;



-- ТАБЛИЦЯ `doctors` --
-- Додавання запису
INSERT INTO doctors (first_name, last_name, speciality, phone, email)
	VALUES ('Степан', 'Кравчук', 'Психiатр', '380652343114', 'step_kravchuk1981@example.com');

-- Видалення запису по ID
DELETE FROM doctors
WHERE id = 1;



-- ТАБЛИЦЯ `appointments` --
-- Додавання запису
INSERT INTO appointments (doctor_id, patient_id, date, status)
	VALUES (2, 3, '2024-12-5 15:30:00', 'Заплановано');

-- Оновлення запису за ID лікаря і пацієнта
-- змінює статус
UPDATE appointments
SET status = 'Скасовано'
WHERE doctor_id = 2 AND patient_id = 3;
-- або дату проводення зустрiчi
UPDATE appointments
SET date = '2025-02-01 08:30:00'
WHERE doctor_id = 2 AND patient_id = 3;

-- Видалення запису по ID
DELETE FROM appointments
WHERE id = 1;



-- ТАБЛИЦЯ `services` --
-- Додавання запису
INSERT INTO services (name, description, cost)
	VALUES ('Корекція зору', 'Метод вирішення проблем рефракції зору за допомогою новітніх лазерних технологій.', 12000.00);

-- Оновлення запису за iм'ям або ID послуги вiдповiдно
-- змінює опис
UPDATE services
SET description = 'Magic...'
WHERE name = 'Корекція зору';
-- або вартість
UPDATE services
SET cost = 13000.00
WHERE id = 6;

-- Видалення запису по ID
DELETE FROM services
WHERE id = 1;



-- ТАБЛИЦЯ `procedures` --
-- Додавання запису
INSERT INTO procedures (name, description, cost)
	VALUES ('КТ головного мозку', 'високотехнологічний, інформативний метод обстеження, що дозволяє отримати детальні та чіткі зображення структур головного мозку.', 2800.00);

-- Оновлення запису за iм'ям або ID процедури вiдповiдно
-- змінює опис
UPDATE procedures
SET description = 'no_Magic?'
WHERE name = 'КТ_головного_мозку';
-- або вартість
UPDATE procedures
SET cost = 1.50
WHERE id = 6;

-- Видалення запису по ID
DELETE FROM procedures
WHERE id = 1;



-- ТАБЛИЦЯ `diagnoses` --
-- Додавання запису
INSERT INTO diagnoses (name, description)
	VALUES ('Токсичне ураження печінки', 'Ціла низка захворювань, обумовлених.');

-- Оновлення запису за iм'ям
UPDATE diagnoses
SET description = '___'
WHERE name = 'Токсичне ураження печінки';

-- Видалення запису по ID
DELETE FROM diagnoses
WHERE id = 6;



-- ТАБЛИЦЯ `prescriptions` --
-- Додавання запису
INSERT INTO prescriptions (name, description)
	VALUES ('Дієта', 'Дієта з низьким вмістом солі.');

-- Оновлення запису за iм'ям
UPDATE prescriptions
SET description = '___'
WHERE name = 'Дієта';

-- Видалення запису по ID
DELETE FROM prescriptions
WHERE id = 6;





-- -- Зв'язковi таблицi -- --

-- ТАБЛИЦЯ `patient_services` --
-- Додавання послуги пацієнту
INSERT INTO patient_services (patient_id, service_id)
	VALUES (1, 3);

-- Оновлення запису за ID пацієнта та сервiсу
UPDATE patient_services
SET service_id = 1
WHERE patient_id = 1 AND service_id = 3;
-- також можливо зробити оновлення ТIЛЬКИ за ID пацієнта, але в такому випадку
-- якщо у нас у пацієнта X є N рiзних послуг, то воно змiнить УСI послуги.
UPDATE patient_services
SET service_id = 1
WHERE patient_id = 1;

-- Видалення послуги для пацієнта
DELETE FROM patient_services
WHERE patient_id = 1 AND service_id = 1;



-- ТАБЛИЦЯ `patient_procedures` --
-- Додавання послуги пацієнту
INSERT INTO patient_procedures (patient_id, procedure_id)
	VALUES (1, 3);

-- Оновлення запису за ID пацієнта та процедури
UPDATE patient_procedures
SET procedure_id = 1
WHERE patient_id = 1 AND procedure_id = 3;
-- також можливо зробити оновлення ТIЛЬКИ за ID пацієнта, але в такому випадку
-- якщо у нас у пацієнта X є N рiзних процедур, то воно змiнить УСI процедури.
UPDATE patient_procedures
SET procedure_id = 1
WHERE patient_id = 1;

-- Видалення послуги для пацієнта
DELETE FROM patient_procedures
WHERE patient_id = 1 AND procedure_id = 1;



-- ТАБЛИЦЯ `medical_card_excharge` --
-- Додавання виписки у мед-карту пацієнта
INSERT INTO medical_card_excharge (medical_card_id, excharge_id)
	VALUES (4, 1);

-- Оновлення виписки у мед-картi пацієнта за ID мед-карти та виписки
UPDATE medical_card_excharge
SET excharge_id = 2;
WHERE medical_card_id = 4 AND excharge_id = 1;

-- Видалення виписки з мед-карти пацієнта за ID мед-карти та виписки
DELETE FROM medical_card_excharge
WHERE medical_card_id = 4 AND excharge_id = 1;



-- ТАБЛИЦЯ `medical_card_prescriptions` --
-- Додавання рецепту у мед-карту пацієнта
INSERT INTO medical_card_prescriptions (medical_card_id, prescription_id)
	VALUES (4, 1);

-- Оновлення рецепту у мед-картi пацієнта за ID мед-карти та рецепту
UPDATE medical_card_prescriptions
SET prescription_id = 2
WHERE medical_card_id = 4 AND prescription_id = 1;

-- Видалення рецепту з мед-карти пацієнта за ID мед-карти та рецепту
DELETE FROM medical_card_prescriptions
WHERE medical_card_id = 4 AND prescription_id = 1;



-- ТАБЛИЦЯ `medical_card_diagnoses` --
-- Додавання рецепту у мед-карту пацієнта
INSERT INTO medical_card_diagnoses (medical_card_id, diagnosis_id)
	VALUES (4, 1);

-- Оновлення рецепту у мед-картi пацієнта за ID мед-карти та рецепту
UPDATE medical_card_diagnoses
SET diagnosis_id = 2
WHERE medical_card_id = 4 AND diagnosis_id = 1;

-- Видалення рецепту з мед-карти пацієнта за ID мед-карти та рецепту
DELETE FROM medical_card_diagnoses
WHERE medical_card_id = 4 AND diagnosis_id = 1;


