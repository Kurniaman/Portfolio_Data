select he.JobTitle, 
person.person.FirstName+' ' + Person.person.LastName as FullName, 
HumanResources.Department.GroupName
from HumanResources.Employee he, Person.Person, HumanResources.Department
where person.person.BusinessEntityID = he.BusinessEntityID
and he.Gender = 'F'