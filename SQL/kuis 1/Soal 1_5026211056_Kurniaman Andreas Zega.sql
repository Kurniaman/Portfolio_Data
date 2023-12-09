select person.PersonType, person.Title, person.FirstName+' ' + person.LastName as FULL_NAME
from Person.Person person
where person.Title is not null