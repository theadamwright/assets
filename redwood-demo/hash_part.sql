-- Redwood Demo 
-- <theadamwright>

CREATE TABLE sales
(
dept_no number,
part_no varchar2,
country varchar2(20),
date date,
amount number
)
PARTITION BY HASH (part_no)
(
  PARTITION p1,
  PARTITION p2,
  PARTITION p3
);
