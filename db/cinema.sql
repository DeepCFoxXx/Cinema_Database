DROP TABLE customers;
DROP TABLE films;

CREATE TABLE films (
  id SERIAL8 PRIMARY KEY,
  title VARCHAR(255),
  price NUMERIC
);

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  funds NUMERIC
);
