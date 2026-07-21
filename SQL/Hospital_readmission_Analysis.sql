
create database Hospital ;

use Hospital 

select * from hospital_readmissions 

-- 1.Total Patients 
select count(*) as [Total Patients] 
from hospital_readmissions ;

-- 2.Readmission Rate 
select cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as [Readmission Rate] 
		from hospital_readmissions ;
		 
-- 3.Readmission by Age Group 
select age, cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as [Readmission Rate]
		from hospital_readmissions
 group by age
 order by [Readmission Rate] desc;

--- 4.Readmission by Medical Specialty 
select medical_specialty, cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as Readmission_Rate 
		from hospital_readmissions
 group by medical_specialty 
 order by Readmission_Rate desc;

--- 5.Average Hospital Stay 
select avg(time_in_hospital) as Average_Hospital_Stay_time
from hospital_readmissions;

--- 6.Average Medications 
select avg(n_medications) as Average_Medications 
from hospital_readmissions;

--- 7.Top Diagnoses 
select Top 1 diag_1 as Top_Diagnoses 
,count(diag_1) as Total_Diagnoses 
from hospital_readmissions
group by diag_1
order by Total_Diagnoses desc

--- 8.Readmission by Glucose Test 
select glucose_test, cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as Readmission_Rate 
		from hospital_readmissions
 group by glucose_test
 order by Readmission_Rate desc; 

 --- 9.Readmission by A1C Test
select A1Ctest, cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as Readmission_Rate 
		from hospital_readmissions
 group by A1Ctest
 order by Readmission_Rate desc;

--- 10.Medication Change vs Readmission 
select change, cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as Readmission_Rate 
		from hospital_readmissions
 group by change;

 --- 11.Diabetes Medication vs Readmission 
 select diabetes_med, cast(
		round(
		count(case when readmitted = 1 then 1 end  )*100.0 /count(*),2) as decimal(10,2)) 
		as Readmission_Rate 
		from hospital_readmissions
 group by diabetes_med;

 --- 12.Emergency Visits by Age 
SELECT
    age,
    SUM(n_emergency) AS Total_Emergency_Visits,
    ROUND(
        SUM(n_emergency) * 100.0 /
        SUM(SUM(n_emergency)) OVER (),
        2
    ) AS Visit_Rate
FROM hospital_readmissions
GROUP BY age
ORDER BY age;

--- 13.Inpatient Visits by Age
SELECT
    age,
    SUM(n_inpatient) AS Total_Inpatient_Visits,
    ROUND(
        SUM(n_inpatient) * 100.0 /
        SUM(SUM(n_inpatient)) OVER (),
        2
    ) AS Visit_Rate
FROM hospital_readmissions
GROUP BY age
ORDER BY age;

--- 14.Outpatient Visits by Age
SELECT
    age,
    SUM(n_outpatient) AS Total_Inpatient_Visits,
    ROUND(
        SUM(n_outpatient) * 100.0 /
        SUM(SUM(n_outpatient)) OVER (),
        2
    ) AS Visit_Rate
FROM hospital_readmissions
GROUP BY age
ORDER BY age;

--- 15.Average Lab Procedures
select avg(n_lab_procedures) as [Average Lab Procedures ]
from hospital_readmissions ;

--- 16.Length of Stay Categories
SELECT
    CASE
        WHEN time_in_hospital <= 3 THEN 'Short Stay'
        WHEN time_in_hospital <= 7 THEN 'Medium Stay'
        WHEN time_in_hospital <= 14 THEN 'Long Stay'
        ELSE 'Very Long Stay'
    END AS Length_of_Stay_Category,
    COUNT(*) AS Patient_Count
FROM hospital_readmissions
GROUP BY
    CASE
        WHEN time_in_hospital <= 3 THEN 'Short Stay'
        WHEN time_in_hospital <= 7 THEN 'Medium Stay'
        WHEN time_in_hospital <= 14 THEN 'Long Stay'
        ELSE 'Very Long Stay'
    END
ORDER BY Patient_Count DESC;

--- 17.High Medication Patients
SELECT *
FROM hospital_readmissions
WHERE n_medications > 20;

--- 18.Most Common Diagnoses 
select Top 1  diag_1, count(*) as Total_Numbers
from hospital_readmissions 
group by diag_1 
order by count(*) desc;

--- 19.Top 20 High-Risk Patients 
SELECT TOP 20
    age,
    time_in_hospital,
    n_medications,
    n_inpatient,
    n_emergency,
    n_outpatient,
    readmitted,

    (
        CASE WHEN time_in_hospital >= 7 THEN 1 ELSE 0 END +
        CASE WHEN n_medications >= 20 THEN 1 ELSE 0 END +
        CASE WHEN n_inpatient >= 2 THEN 1 ELSE 0 END +
        CASE WHEN n_emergency >= 2 THEN 1 ELSE 0 END +
        CASE WHEN readmitted <> 0 THEN 1 ELSE 0 END
    ) AS Risk_Score

FROM hospital_readmissions

ORDER BY Risk_Score DESC,
         n_inpatient DESC,
         n_emergency DESC,
         n_medications DESC;

--- 20.Readmission by Diagnosis 
 select diag_1,count(diag_1) as Total_number
		from hospital_readmissions
		where readmitted = 1
 group by diag_1 
 order by Total_number desc;

