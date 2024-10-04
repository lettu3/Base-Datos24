use classicmodels;


-- Ejercicio 1
-- Devuelva la oficina con mayor número de empleados.
select offices.officeCode as Office,
	   offices.city as City,
	   count(employees.employeeNumber) as NumberOfEmployees
from offices
inner join employees on employees.officeCode = offices.officeCode
group by Office, City
order by NumberOfEmployees desc
limit 1;

-- Ejercicio 2
-- ¿Cuál es el promedio de órdenes hechas por oficina?, ¿Qué oficina vendió la mayor cantidad de productos?


-- Ejercicio 3
-- Devolver el valor promedio, máximo y mínimo de pagos que se hacen por mes.
select monthname(payments.paymentDate) as Month,
	   avg(payments.amount) as averagePay,
	   max(payments.amount) as maxPay,
	   min(payments.amount) as minPay
from payments
group by monthname(payments.paymentDate); 


-- Ejercicio 4
-- Crear un procedimiento "Update Credit" en donde se modifique el límite de crédito de un cliente
-- con un valor pasado por parámetro.

drop procedure if exists update_credit;

create procedure update_credit (in new_limit decimal(10,2), in customer_id int)
begin
	update customers
	set creditLimit = new_limit
	where customer_id = customerNumber;
end;


-- Ejercicio 5
-- Cree una vista "Premium Customers" que devuelva el top 10 de clientes que más dinero han gastado en la plataforma.
-- La vista deberá devolver el nombre del cliente, la ciudad y el total gastado por ese cliente en la plataforma.

drop view if exists premium_customers;

create view premium_customers as
select customers.customerName as Name,
	   customers.city as City,
	   sum(payments.amount) as Total
from customers
inner join payments on payments.customerNumber = customers.customerNumber
group by Name, City
order by Total desc
limit 10;

-- Ejercicio 6
-- Cree una función "employee of the month" que tome un mes y un año y devuelve el empleado (nombre y apellido)
-- cuyos clientes hayan efectuado la mayor cantidad de órdenes en ese mes.

DROP FUNCTION IF EXISTS employee_of_the_month;
 

CREATE FUNCTION employee_of_the_month(in_month INT, in_year INT) 
RETURNS VARCHAR(100)
BEGIN
    DECLARE employee_name VARCHAR(100); 

    SELECT 
        CONCAT(employees.firstName, ' ', employees.lastName) INTO employee_name
    FROM 
        employees
    INNER JOIN 
        customers ON employees.employeeNumber = customers.salesRepEmployeeNumber
    INNER JOIN 
        orders ON customers.customerNumber = orders.customerNumber
    WHERE 
        MONTH(orders.orderDate) = in_month 
        AND YEAR(orders.orderDate) = in_year
    GROUP BY 
        employees.employeeNumber, employees.firstName, employees.lastName
    ORDER BY 
        COUNT(orders.orderNumber) DESC
    LIMIT 1;    

    RETURN employee_name;  
end;

-- Ejercicio 7
-- Crear una nueva tabla "Product Refillment".
-- Deberá tener una relación varios a uno con "products" y los campos:
-- `refillmentID`, `productCode`, `orderDate`, `quantity`.

create table product_refillment(
	refillmentID int primary key,
	productCode varchar(15),
	orderDate date not null,
	quantity int not null,
	constraint fk_products foreign key (productCode) references products(productCode)
);

--

-- Ejercicio 9
-- Crear un rol "Empleado" en la BD que establezca accesos de lectura a todas las tablas y accesos de creación de vistas.

create role empleado;

grant select
on classicmodels.*
to empleado;

grant create view
on classicmodels.*
to empleado;
