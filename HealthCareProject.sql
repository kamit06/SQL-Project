/*
Healthcare Management System (SQL Project)
Skill Used Where, Order By, Group By, Having, Aggregate Function(Count(), Avg(), Max(), Min(), Case Statement,
Top, Conditional Aggregation

Basics HealthCare Data Analyst
*/

Create Database HealthCare

use healthcare
--
Select * from [dbo].[Indian_healthcare$]

-- Total Number of Patients 

Select Count(Patient_Id) as Total_Number_Of_Patient from [dbo].[Indian_healthcare$]

-- Total Number of Patients By Region

Select Region,Count(Patient_id) as Number_of_Patients  from [dbo].[Indian_healthcare$]
Group by Region
Order by Number_of_Patients desc

-- Highest Patients Visit Month

Select 
    DATENAME(Month, Visit_Date) as MonthName,
    Count(Patient_Id) as Total_Patient
From [dbo].[Indian_healthcare$]
Group by 
    Month(Visit_Date), DateName(Month, Visit_Date)
Order by Total_Patient Desc

-- Highest visit Patient Date

Select Top 1
Visit_Date, Count(Patient_Id) as Number_Of_Patients from [dbo].[Indian_healthcare$]
Group by
    Visit_Date
Order by 
    Number_Of_Patients Desc

-- Male Vs Female Patients

Select Gender, Count(Patient_Id) as Number_of_Patients from [dbo].[Indian_healthcare$]
Group By Gender

-- Most Common Dignosis
Select Primary_Diagnosis, Count(*) as Number_Of_Diagnosis from [dbo].[Indian_healthcare$]
Group by Primary_Diagnosis
Order By Number_Of_Diagnosis desc 

-- Average Blood Glucose by Diagnosis

Select Primary_Diagnosis, Avg(blood_Glucose_Mg_dl) as Avegrage_Blood_Glucose from [dbo].[Indian_healthcare$]
Group by Primary_Diagnosis
Order by Avegrage_Blood_Glucose desc

-- Average HbA1c_% by Diagnosis

Select Primary_Diagnosis, Avg([HbA1c_%]) as Avg_Blood_HbA1c from [dbo].[Indian_healthcare$]
Group by Primary_Diagnosis

Select * From [dbo].[Indian_healthcare$]

-- Average BMI by Gender

Select Gender, Avg(BMI) as Avg_BMI from [dbo].[Indian_healthcare$]
Group by Gender

-- Treatment outcome Summary
Select 
Treatment_outcome, Count(*) As patients from [dbo].[Indian_healthcare$]
Group by Treatment_Outcome
Order by patients

-- Insurance_ Covered
Select 
Insurance_Covered, Count(*) As Patients from [dbo].[Indian_healthcare$]
Group by Insurance_Covered

-- Hospital wise patient count
Select 
Hospital_Type, Count(*) As Patients from [dbo].[Indian_healthcare$]
Group by Hospital_Type

-- Top 10 highest blood Glucose Patients
Select top 10
Primary_Diagnosis, Avg(blood_Glucose_Mg_dl) as Avegrage_Blood_Glucose from [dbo].[Indian_healthcare$]
Group by Primary_Diagnosis
Order by Avegrage_Blood_Glucose desc

-- Patient with BMI grather then 30
Select Patient_ID, BMI from [dbo].[Indian_healthcare$]
where BMI > 30

--Average Cholesterol by Region
Select 
Region, Avg(Total_Cholesterol_mg_dL) as Avg_Total_Cholesterol from [dbo].[Indian_healthcare$]
group by Region

-- Occupation wise patient count
Select 
Occupation, count(*) as Total_Patients from [dbo].[Indian_healthcare$]
Group by Occupation
Order by Total_Patients

-- Most used Treatment Type
Select 
Treatment_Type, COUNT(*) as Total_Used_Treatment from [dbo].[Indian_healthcare$]
Group by Treatment_Type
Order by Total_Used_Treatment desc

-- Patients by Age Group
Select
    Case
     When Age < 18 Then 'Young'
     When Age between 19 and 45 then 'Adult'
     When Age between 46 and 60 then 'Senior'
     Else 'Above 60' 
    End as Age_group, 
    Count (*) as Total_Patients
from [dbo].[Indian_healthcare$]
Group by
    Case
        When Age < 18 Then 'Young'
        When Age between 19 and 45 then 'Adult'
        When Age between 46 and 60 then 'Senior'
        Else 'Above 60' 
    End;
        
-- Successful Treatment Percentage
SELECT
    CAST(
        SUM(CASE WHEN Treatment_Outcome = 'Recovered' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*) AS DECIMAL(5,2)
    ) AS Success_Rate
from [dbo].[Indian_healthcare$]

--Patients with High Blood Sugar (>200)
Select 
Patient_Id, Blood_Glucose_mg_dL from [dbo].[Indian_healthcare$]
Where Blood_Glucose_mg_dL > 200;

--Diagnosis-wise Average BMI
Select 
Primary_Diagnosis, Avg(BMI) as Avg_BMI from [dbo].[Indian_healthcare$]
Group by Primary_Diagnosis
Order by Avg_BMI;

