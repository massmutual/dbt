
CREATE SCHEMA test;

CREATE TABLE IF NOT EXISTS test.testtable1 (
    a int,
    b varchar,
    c date,
    val int
);

COPY test.testtable1 (
    a,
    b,
    c,
    val
)
FROM LOCAL 'test_table1.csv'
SKIP 1
DELIMITER ','
DIRECT;
