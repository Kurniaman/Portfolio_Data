-- Create Table with the name of mlb_salary 
CREATE TABLE mlb_salary (
  player VARCHAR(50),
  team VARCHAR(50),
  position VARCHAR(50),
  salary decimal
)

-- IMPORT CSV data to the table: MLB Salary 
COPY mlb_salary(player, team, position, salary)
FROM 'D:\ITS\Semester 5\Dibimbing\SQL\mlb.csv'
DELIMITER ','
CSV HEADER;

-- Add new column ‘earning category’ to the table
ALTER TABLE mlb_salary
ADD COLUMN earning_category Varchar(50);

-- Update table values for earning category 
UPDATE mlb_salary
SET earning_category = 'High Earner'
WHERE salary > 10000;

UPDATE mlb_salary
SET earning_category = 'Mid Earner'
WHERE salary between 2000 AND 10000;

UPDATE mlb_salary
SET earning_category = 'Low Earner'
WHERE salary < 2000;

-- Do Select Command to get all player name that categorized as ‘High Earner’
select player, team, position, salary, earning_category
from mlb_salary
where earning_category = 'High Earner'
order by salary desc



