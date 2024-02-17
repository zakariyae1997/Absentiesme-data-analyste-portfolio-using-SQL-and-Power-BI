-- creat join table
select * from Absenteeism as a 
left join compensation as c
on a.ID=c.ID
left join reasons as r
on a.Reason_for_absence=r.Number;

-- find the healthiest employees for the bonus
select * from Absenteeism
where social_drinker=0 and social_smoker=0
and Body_mass_index<25
and Absenteeism_time_in_hours < (select avg(Absenteeism_time_in_hours) from Absenteeism);

-- compensation race increase for non_smokers/ budget 983,221 so (983,221/(8*5*52*686))=0.69 dolar increase per hour/(8*5*52*0,69)=1414.4 dolar per year
select count(*) as non_smokers from Absenteeism
where social_smoker=0

-- optimize the query

select a.ID, r.reason,

Body_mass_index,
case 
when Body_mass_index <18.5 then 'underweight'
when Body_mass_index between 18.5 and 24.9 then 'healthy'
when Body_mass_index between 25 and 30 then 'overweight'
when Body_mass_index> 30 then 'obese'
else 'unknown' end as BMI_Category,

Month_of_absence,
case 
    when Month_of_absence in (12,1,2) then 'winter'
    when Month_of_absence in (3,4,5)then 'spring'
	when Month_of_absence in (6,7,8) then 'summer'
	when Month_of_absence in (9,10,11) then 'fall'
	else 'unknown' 
	end as seasons_name,

seasons,day_of_the_week, transportation_expense,education,son,social_drinker,social_smoker,pet,disciplinary_failure, age,
work_load_average_day,absenteeism_time_in_hours

from Absenteeism as a 
left join compensation as c
on a.ID=c.ID
left join reasons as r
on a.Reason_for_absence=r.Number
