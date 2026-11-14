USE project_medical_data_history;

SHOW tables;

-- Q1: Show first_name, last_name, and gender of patients whose gender is 'M'.
SELECT 
	first_name, last_name, gender
FROM
	patients
WHERE
	gender='M'
;

-- Q2: Show first_name and last_name of patients who do not have allergies.
SELECT
	first_name,last_name 
FROM
	patients
WHERE
	allergies IS NULL
;
	
-- Q3: Show first_name of patients whose first_name starts with 'C'.
SELECT 
	first_name
FROM
	patients
WHERE 
	first_name like 'C%'
;

-- Q4: Show first_name and last_name of patients whose weight is between 100 and 120, inclusive.
SELECT 
	first_name,last_name
FROM 
	patients
WHERE
	weight >= 100 AND weight <=120;


-- Q6: Concatenate first_name and last_name into one full_name column.
SELECT 
	concat(first_name,' ',last_name)as full_name
FROM
	patients;

-- Q7: Show first_name, last_name, and the full province name of each patient.
SELECT 
	p.first_name, p.last_name, pn.province_name
FROM
	patients AS p 
LEFT JOIN
	province_names AS pn
ON 
	p.province_id=pn.province_id;

-- Q8: Count patients whose birth_date is in the year 2010.
SELECT
	count(*) as total_patients
FROM
	patients
WHERE
	year(birth_date)=2010;

-- Q9: Show first_name, last_name, and height of the patient with the greatest height.
SELECT
    first_name,
    last_name,
    height
FROM patients
ORDER BY height DESC
LIMIT 1;

-- Q10: Show all columns for patients with patient_id in this list: 1, 45, 534, 879, 1000.
SELECT
	*
FROM 
	patients
WHERE
	patient_id IN (1,45,534,879,1000)
    ;

-- Q11: Show the total number of admissions.
SELECT 
	count(*)as total_admission
FROM admissions;


-- Q12: Show all columns from admissions where the patient
-- was admitted and discharged on the same day.
select 
	*
FROM 
	admissions
WHERE
	admission_date = discharge_date;

-- Q13: Show the total number of admissions for patient_id 579.
SELECT
	COUNT(*)AS total_admissions
FROM
	admissions
WHERE
	patient_id=579;


-- Q14: Show unique cities where patients live and province_id is 'NS'.
SELECT 
	DISTINCT city
FROM
	patients
WHERE	
	province_id='NS'
;

-- Q15: Show first_name, last_name, and birth_date of patients
-- whose height is greater than 160 and weight is greater than 70.
SELECT 
	first_name,last_name,birth_date 
FROM
	patients
WHERE	
	height > 160 and weight >70;
    
-- Q16: Show unique birth years from patients,
-- ordered by birth year ascending.
SELECT 
	DISTINCT(YEAR(birth_date)) AS unique_years
FROM
	patients
ORDER BY unique_years ASC;

-- Q17: Show first names that occur exactly once in patients.
-- Exclude names shared by two or more patients.
-- Hint: Use GROUP BY and HAVING.

SELECT 	
	first_name
FROM 
	patients
GROUP BY
	first_name
HAVING
	COUNT(*)=1
;

-- Q18: Show patient_id and first_name for patients whose first_name
-- starts and ends with 's' and is at least 6 characters long.
SELECT
	patient_id,first_name
FROM
	patients
WHERE
	first_name LIKE 's____%s'
;

-- Q19: Show patient_id, first_name, and last_name of patients
-- whose diagnosis is 'Dementia'.
-- The diagnosis is stored in admissions.
SELECT DISTINCT 
	p.patient_id,p.first_name,p.last_name
FROM 
	patients AS p LEFT JOIN admissions AS a
    on p.patient_id=a.patient_id
WHERE
	a.diagnosis='Dementia'
;


-- Q20: Show every patient's first_name.
-- Order by name length first, then alphabetically.
SELECT
	first_name
FROM	
	patients
ORDER BY CHAR_lENGTH(first_name) ASC, first_name ASC
;
 
-- Q21: Show the total number of male patients and female patients.
-- Display both totals in the same row.
SELECT
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS female_count
FROM patients;
	
-- Q22: Show the total number of male patients and female patients.
-- Display both totals in the same row.
-- Note: This duplicates Q21 in the assignment.
SELECT
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS total_male,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS total_female
FROM patients;

-- Q23: Show patient_id and diagnosis for patients admitted
-- multiple times for the same diagnosis.
SELECT 
	patient_id,diagnosis
FROM
	admissions
GROUP BY
	patient_id,diagnosis
HAVING
	COUNT(*)>1;

-- Q24: Show each city and its total number of patients.
-- Order by patient count descending, then city name ascending.
SELECT
	city,count(patient_id)as no_of_patients
FROM 
	patients
GROUP BY
	city
ORDER BY no_of_patients DESC,city ASC
;

-- Q25: Show first_name, last_name, and role for every patient and doctor.
-- Use 'Patient' and 'Doctor' as the role values.
SELECT
    first_name,
    last_name,
    'Patient' AS role
FROM patients

UNION ALL

SELECT
    first_name,
    last_name,
    'Doctor' AS role
FROM doctors;

-- Q26: Show all allergies ordered by popularity.
-- Exclude NULL values.
SELECT
    allergies,
    COUNT(*) AS total_patients
FROM patients
WHERE allergies IS NOT NULL
GROUP BY allergies
ORDER BY total_patients DESC;

-- Q27: Show first_name, last_name, and birth_date of patients
-- born in the 1970s (1970 through 1979).
-- Order by birth_date from earliest to latest.
SELECT 
	first_name,last_name,birth_date
FROM 
	patients
WHERE 
	year(birth_date)>=1970 and year(birth_date)<=1979
ORDER BY
	birth_date ASC
;

-- Q28: Display each patient's full name in one column:
-- uppercase last_name, a comma, then lowercase first_name.
-- Example: SMITH,jane
-- Order by first_name descending.
SELECT 
	CONCAT (upper(last_name),',',lower(first_name)) AS full_name
FROM
	patients
ORDER BY
	first_name DESC
;

-- Q29: Show province_id and total patient height for provinces
-- whose summed patient height is at least 7000.
SELECT 
	province_id,sum(height) as total_height
FROM
	patients
GROUP BY
	province_id
HAVING
	sum(height)>=7000
;

-- Q30: Difference between largest and smallest weight
-- among patients whose last_name is 'Maroni'.
SELECT
    MAX(weight) - MIN(weight) AS weight_difference
FROM patients
WHERE last_name = 'Maroni';

-- Q31: Show days of the month (1-31) and the number of admissions
-- whose admission_date falls on each day.
-- Order by admission count descending.
SELECT
    DAY(admission_date) AS day_of_month,
    COUNT(*) AS admission_count
FROM admissions
GROUP BY DAY(admission_date)
ORDER BY
    admission_count DESC,
    day_of_month ASC;

    
-- Q32: Group patients into weight bands of 10 kg.
-- Examples: 100-109 = group 100; 110-119 = group 110.
-- Show each weight group and its patient count.
-- Order by weight group descending.
SELECT
    FLOOR(weight / 10) * 10 AS weight_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- Q33: Show patient_id, weight, height, and isObese as 0 or 1.
-- Weight is in kilograms; height is in centimeters.
-- Clarification: The PDF's obesity formula is incomplete.
-- Confirm the intended BMI formula and threshold with your trainer.
SELECT
    patient_id,
    weight,
    height,
    CASE
        WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM patients;

-- Q34: Show patient_id, first_name, last_name, and doctor's specialty
-- for patients diagnosed with 'Epilepsy'
-- whose attending doctor's first_name is 'Lisa'.
-- Use patients, admissions, and doctors.
SELECT DISTINCT
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients AS p
JOIN admissions AS a
    ON p.patient_id = a.patient_id
JOIN doctors AS d
    ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
    AND d.first_name = 'Lisa';

-- Q35: Show patient_id and temp_password for patients
-- who have at least one admission.
-- Construct temp_password by concatenating, in this order:
-- 1. patient_id
-- 2. The number of characters in the patient's last_name
-- 3. The year of the patient's birth_date
SELECT
    p.patient_id,
    CONCAT(
        p.patient_id,
        CHAR_LENGTH(p.last_name),
        YEAR(p.birth_date)
    ) AS temp_password
FROM patients AS p
WHERE EXISTS (
    SELECT 1
    FROM admissions AS a
    WHERE a.patient_id = p.patient_id
);


-- Q5: Update patients.allergies: replace NULL values with 'NKA'.
-- Perform this on a local copy or according to your trainer's instructions.
-- Complete Q2 and other NULL-allergy queries before this update.

SET SQL_SAFE_UPDATES = 0;

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) AS remaining_null_allergies
FROM patients
WHERE allergies IS NULL;