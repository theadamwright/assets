-- Redwood Demo 
-- <theadamwright>

CREATE TABLE sales
(
dept_no number,
part_no varchar2,
country varchar2(20),
date date,
amount  number
)
PARTITION BY LIST(country)
(
PARTITION europe VALUES('FRANCE', 'ITALY'), PARTITION asia VALUES('INDIA', 'PAKISTAN'), PARTITION americas VALUES('US', 'CANADA')
);
