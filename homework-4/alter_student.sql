CREATE TABLE student
(
    student_id serial,
    first_name varchar,
    last_name varchar,
    birthday date,
    phone varchar
);

ALTER TABLE student
ADD COLUMN middle_name varchar;

ALTER TABLE student
DROP COLUMN middle_name;

ALTER TABLE student
RENAME COLUMN birthday TO birth_date;

ALTER TABLE student
ALTER COLUMN phone SET DATA TYPE varchar(32);

INSERT INTO student (first_name, last_name, birth_date, phone)
VALUES
    ('Иван', 'Иванов', '2000-01-15', '+79991112233'),
    ('Мария', 'Петрова', '2001-05-20', '+79994445566'),
    ('Алексей', 'Сидоров', '1999-11-03', '+79997778899');

TRUNCATE TABLE student RESTART IDENTITY;
