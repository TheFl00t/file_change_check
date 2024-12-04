-- Загальна вартість процедур для конкретного пацієнта (пошук пацієнта за ID)
SELECT SUM(p.cost) AS 'Загальна вартість процедур'
FROM patient_procedures pp
JOIN procedures p ON pp.procedure_id = p.id
WHERE pp.patient_id = 1;



-- Загальна вартість усіх послуг для конкретного пацієнта (пошук пацієнта за ID)
SELECT SUM(s.cost) AS 'Загальна вартість послуг'
FROM patient_services ps
JOIN services s ON ps.service_id = s.id
WHERE ps.patient_id = 1;



-- Загальна вартість усіх послуг та процедур для конкретного пацієнта.

-- 1 варiант
-- Пошук відбувається за PS.PATIENT_ID, треба два рази 
-- вказати id одного й того самого пацієнта.
SELECT
	(
	SELECT SUM(s.cost) AS total_service_cost
	FROM patient_services ps
	JOIN services s ON ps.service_id = s.id
	WHERE ps.patient_id = 1 -- <== PS.PATIENT_ID
	) + (
	SELECT SUM(p.cost) AS total_procedure_cost
	FROM patient_procedures pp
	JOIN procedures p ON pp.procedure_id = p.id
	WHERE pp.patient_id = 1 -- <== PP.PATIENT_ID
	) AS 'Загальна вартість';
	
-- 2 варiант
-- Пошук відбувається за PS.PATIENT_ID, просто требо
-- змiнити @patient.
SET @patient = 1;
SELECT
	(
	SELECT SUM(s.cost) AS total_service_cost
	FROM patient_services ps
	JOIN services s ON ps.service_id = s.id
	WHERE ps.patient_id = @patient
	) + (
	SELECT SUM(p.cost) AS total_procedure_cost
	FROM patient_procedures pp
	JOIN procedures p ON pp.procedure_id = p.id
	WHERE pp.patient_id = @patient
	) AS 'Загальна вартість';
	
	

-- Пошук запису до лікаря, для пацієнта(A.PATIENT_ID), за часовим проміжком.
-- BETWEEN 'початок' AND 'кінець'.
SELECT 
	a.id AS 'Номер запису', 
	a.date AS 'Дата проведення', 
	a.status AS 'Статус', 
	CONCAT(d.first_name, ' ',d.last_name) AS 'Лiкар'
FROM appointments a
JOIN doctors d ON d.id = a.doctor_id
WHERE a.patient_id = 1 -- <== PATIENT_ID
AND a.date
BETWEEN '2024-12-01 08:30:00' 
AND '2024-12-31 18:30:00';



-- Виводить таблицю з усіма послугами для PS.PATIENT_ID
SELECT 
	s.name AS 'Послуга', 
	s.description AS 'Опис', 
	s.cost AS 'Вартість'
FROM services s
JOIN patient_services ps ON ps.service_id = s.id
WHERE ps.patient_id = 1; -- <== PATIENT_ID



-- Виводить таблицю з усіма процедурами для PP.PATIENT_ID
SELECT 
	p.name AS 'Процедура', 
	p.description AS 'Опис', 
	p.cost AS 'Вартість'
FROM procedures p
JOIN patient_procedures pp ON pp.procedure_id = p.id
WHERE pp.patient_id = 1; -- <== PATIENT_ID



-- Виводить одразу і послуги та процедури для пацієнта (@patient).
SET @patient = 1;
SELECT 
	'Послуга' AS 'Тип',
	s.name AS 'Назва',
	s.description AS 'Опис', 
	s.cost AS 'Вартість'	
FROM services s
JOIN patient_services ps ON ps.service_id = s.id
WHERE ps.patient_id = @patient
UNION ALL
SELECT 
	'Процедура' AS 'Тип',
	p.name, 
	p.description, 
	p.cost
FROM procedures p
JOIN patient_procedures pp ON pp.procedure_id = p.id
WHERE pp.patient_id = @patient;



-- Простий запит на виведення всього вмісту таблиці.
-- Найкраще виводити ці таблиці:
-- patients, doctors, services, procedures, bills, diagnoses, prescriptions.
SELECT *
FROM patients; -- <== змiнювати тут


-- Виводить інформацію про пацієнта з його медичної книжки.
SELECT 
    CONCAT(pa.first_name, ' ', pa.last_name) AS "Ім'я пацієнта",
    GROUP_CONCAT(DISTINCT d.name) AS "Діагноз",
    GROUP_CONCAT(DISTINCT p.name) AS "Рецепти",
    e.name AS "Витяг"
FROM medical_cards mc
JOIN patients pa ON pa.id = mc.patient_id
JOIN medical_card_diagnoses mcd ON mcd.medical_card_id = mc.id
JOIN medical_card_prescriptions mcp ON mcp.medical_card_id = mc.id
JOIN medical_card_excharge mce ON mce.medical_card_id = mc.id
JOIN diagnoses d ON d.id = mcd.diagnosis_id
JOIN prescriptions p ON p.id = mcp.prescription_id
JOIN excharges e ON e.id = mce.excharge_id
WHERE pa.id = 1
GROUP BY pa.id;