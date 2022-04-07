1. List all the patients who were admitted in accident and emergency department in last 1 year and had policy from The New India Assurance Co LTD company.


        Select p.patient_id,p.fname from admitted as a natural join patient_general_details as p natural join ((Select distinct patient_id from intermediate_bill natural join treatments_available natural join department where dep_name = ‘Accidents and Emergency’ ) as r
Intersect
(Select patient_id from patient_insurance_details natural join policy_details where company_name = ‘The New India Assurance CO LTD’) as q) as pd where age(current_date,a.admit_date)<= interval ’1 year’
        






2. List the percentage of patients who had high cholesterol in their medical history and died due to heart failure.


        ((Select count(patient_id)as total from (SELECT patient_id,fname from patient_medical_conditions as p natural join discharge_summary as d where p.medical_history = ‘High cholesterol’ and d.diagnosis_details = ‘Heart failure’ and d.status=’D’)  as r )*100/
(Select count(patient_id)as total from (SELECT patient_id,fname from patient_medical_conditions as p natural join discharge_summary as d where p.medical_history = ‘High cholesterol’ and d.diagnosis_details = ‘Heart failure’) as p  ) as r ) over()








3. List the patients who died after delivering a  child.


Select fname, lname from patient natural join discharge_summary where diagnosis_details=’Pregnant’ and status=’D’;
