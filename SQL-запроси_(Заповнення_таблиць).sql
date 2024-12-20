-- TABLE: excharges
INSERT INTO excharges (name, description) VALUES
	('Виписаний', 'Пацієнт успішно закінчив лікування.'),
	('Потребує додаткового лікування', 'Необхідність додаткового спостереження та терапії.'),
	('Невиписаний', 'Пацієнт продовжує лікування.');

-- TABLE: prescriptions
INSERT INTO prescriptions (name, description) VALUES
	('Ліки', 'Приймати по 1 таблетці двічі на день.'),
	('Процедури', 'Масаж спини тричі на тиждень.'),
	('Устаткування', 'Використання ортопедичного матраца.'),
	('Ліки', 'Антибіотики протягом 7 днів.'),
	('Процедури', 'Фізіотерапія на курс 10 сеансів.'),
	('Інгаляції', 'Застосування інгаляторів з бронхолітиками.'),
	('Дієта', 'Збалансоване харчування для зниження ваги.'),
	('Біодобавки', 'Вітаміни та мікроелементи для зміцнення імунітету.');

-- TABLE: diagnoses
INSERT INTO diagnoses (name, description) VALUES
	('Грип', 'Вірусна інфекція верхніх дихальних шляхів.'),
	('Гіпертонія', 'Підвищений артеріальний тиск.'),
	('Діабет', 'Хронічне порушення обміну глюкози.'),
	('Мігрень', 'Сильний головний біль.'),
	('Артрит', 'Запалення суглобів.'),
	('Алергія', 'Реакція організму на алергени, наприклад, пилок або пил.'),
	('Бронхіт', 'Запалення бронхів, що супроводжується кашлем.'),
	('Інсульт', 'Гостре порушення кровообігу мозку.'),
	('Остеохондроз', 'Дегенеративне захворювання хребта.'),
	('Анемія', 'Недостатність гемоглобіну в крові.');

-- TABLE: patients
INSERT INTO patients (first_name, last_name, birth_date, phone) VALUES
	('Олександр', 'Ковальчук', '1990-03-15', '380501234567'),
	('Марія', 'Петренко', '1985-07-22', '380671234568'),
	('Іван', 'Шевченко', '1978-01-05', '380931234569'),
	('Ольга', 'Лисенко', '1995-11-30', '380631234570'),
	('Віктор', 'Гончаренко', '1980-09-10', '380991234571'),
	('Наталія', 'Гриценко', '1988-02-14', '380501234572'),
	('Петро', 'Коваленко', '1975-06-25', '380631234573');

-- TABLE: doctors
INSERT INTO doctors (first_name, last_name, speciality, phone, email) VALUES
	('Олег', 'Мельник', 'Терапевт', '380501111222', 'omelnyk@example.com'),
	('Наталія', 'Захаренко', 'Кардіолог', '380671111223', 'nzakharenko@example.com'),
	('Ігор', 'Сидоренко', 'Ендокринолог', '380931111224', 'isidorenko@example.com'),
	('Анна', 'Романова', 'Невролог', '380631111225', 'aromanova@example.com'),
	('Володимир', 'Черненко', 'Ревматолог', '380991111226', 'vchernenco@example.com');

-- TABLE: services
INSERT INTO services (name, description, cost) VALUES
	('Консультація терапевта', 'Повна консультація щодо загального стану здоров’я.', 300.00),
	('УЗД', 'Ультразвукове дослідження органів.', 500.00),
	('Аналіз крові', 'Загальний та біохімічний аналіз крові.', 200.00),
	('ЕКГ', 'Електрокардіограма серця.', 250.00),
	('МРТ', 'Магнітно-резонансна томографія.', 1500.00),
	('Рентген', 'Рентгенографія органів грудної клітини.', 350.00),
	('Консультація кардіолога', 'Повна консультація щодо роботи серця.', 400.00),
	('Аналіз сечі', 'Загальний аналіз сечі.', 150.00),
	('КТ', 'Комп’ютерна томографія органів.', 2000.00);

-- TABLE: procedures
INSERT INTO procedures (name, description, cost) VALUES
	('Масаж спини', 'Розслаблення м’язів спини.', 400.00),
	('Фізіотерапія', 'Курс на 10 процедур.', 1000.00),
	('Лазеротерапія', 'Процедури з використанням лазерного променя.', 800.00),
	('Ін’єкції', 'Внутрішньом’язові ін’єкції.', 150.00),
	('Ортопедичний масаж', 'Для лікування проблем з опорно-руховою системою.', 500.00),
	('Лікувальна фізкультура', 'Комплекс вправ для відновлення функцій тіла.', 700.00),
	('Гідротерапія', 'Використання водних процедур для лікування.', 600.00),
	('Електротерапія', 'Лікування за допомогою електричних імпульсів.', 500.00);
	

-- Таблицы связей
--
INSERT INTO medical_card_diagnoses (medical_card_id, diagnosis_id) VALUES
(1, 2), -- гіпертонія
(1, 7), -- бронхіт
(2, 1), -- грип
(2, 6), -- алергія
(3, 3), -- діабет
(3, 8), -- інсульт
(4, 9), -- остеохондроз
(5, 10), -- анемія
(6, 5); -- артрит

--
INSERT INTO medical_card_excharge (medical_card_id, excharge_id) VALUES
(1, 1), -- Виписаний
(2, 3), -- Невиписаний
(3, 2), -- Потребує додаткового лікування
(4, 3), -- Невиписаний
(5, 1), -- Виписаний
(6, 2); -- Потребує додаткового лікування

--
INSERT INTO medical_card_prescriptions (medical_card_id, prescription_id) VALUES
(1, 1), -- Ліки
(1, 2), -- Процедури
(1, 8), -- Біодобавки
(2, 3), -- Устаткування
(2, 6), -- Інгаляції
(3, 4), -- Антибіотики
(3, 7), -- Дієта
(4, 5), -- Фізіотерапія
(5, 1), -- Ліки
(5, 2); -- Процедури

--
INSERT INTO patient_procedures (patient_id, procedure_id) VALUES
(1, 1), -- Масаж спини
(1, 7), -- Гідротерапія
(2, 4), -- Ін’єкції
(3, 3), -- Лазеротерапія
(3, 8), -- Електротерапія
(4, 2), -- Фізіотерапія
(5, 5), -- Ортопедичний масаж
(6, 6); -- Лікувальна фізкультура

--
INSERT INTO patient_services (patient_id, service_id) VALUES
(1, 1), -- Консультація терапевта
(1, 3), -- Аналіз крові
(2, 2), -- УЗД
(2, 4), -- ЕКГ
(3, 5), -- МРТ
(4, 7), -- Консультація кардіолога
(5, 6), -- Рентген
(6, 8), -- Аналіз сечі
(7, 9); -- КТ

