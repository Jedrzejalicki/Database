ALTER TABLE employee
   ADD  name varchar(255)

ALTER TABLE employee
   ADD surname varchar(255)

ALTER TABLE employee
   ADD pesel varchar(11)

ALTER TABLE employee
    ADD contact varchar(255)

ALTER TABLE employee
   ADD CONSTRAINT check_empId
        CHECK(employee_id LIKE 'E-[0-9][0-9]') 


ALTER TABLE employee
    ADD CONSTRAINT check_pesel_em
        CHECK (pesel NOT LIKE '%[^0-9]%')