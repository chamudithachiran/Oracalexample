SET SERVEROUTPUT ON;
DECLARE

ACCEPT _number_one NUMBER PROMPT 'Enter first number:';
ACCEPT _number_two NUMBER PROMPT 'Enter second number:';

DECLARE 
   v_num1 NUMBER;
   v_num2 NUMBER;
   v_total NUMBER;
   v_diff NUMBER;

BEGIN

   v_num1:= '&_number_one';
   v_num2:= '&_number_two';
   v_total:= v_num1+v_num2;
   v_diff:= v_num1-v_num2;
   DBMS_OUTPUT.PUT_LINE('Total:'||v_total);
   DBMS_OUTPUT.PUT_LINE('Difference:'||v_diff);

END;

SET SERVEROUTPUT ON;
ACCEPT _salary NUMBER PROMPT 'Enter Employee Salary: ';
DECLARE
       v_salary NUMBER;
       v_tax NUMBER;
       v_netsalary NUMBER;
BEGIN
     v_salary := '&_salary';
     IF v_salary>500000.00 THEN
      v_tax := v_salary*0.15;
      ELSIF v_salary>300000.00 THEN
      v_tax := v_salary*0.10;
      ELSIF v_salary>100000.00 THEN
      v_tax := v_salary*0.08;
      ELSE
         v_tax:=0.00;
      END IF;
      v_netsalary:=v_salary-v_tax;
      DBMS_OUTPUT.PUT_LINE('Tax Amount:'||v_tax);
      DBMS_OUTPUT.PUT_LINE('Net Salary:'||v_netsalary);

END;

DECLARE
       counter NUMBER;
BEGIN
     counter:=0;
     LOOP
         DBMS_OUTPUT.PUT_LINE(counter);
         EXIT WHEN counter>30;
         counter := counter+1;
         END LOOP;
END;

SET SERVEROUTPUT ON;
DECLARE
      counter NUMBER;
BEGIN
    counter:=10;
    WHILE counter<=50 LOOP
        IF MOD(counter,3)=0 THEN
           DBMS_OUTPUT.PUT_LINE(counter);
           END IF;
           counter:=counter+1;
           END LOOP;
END;

SET SERVEROUTPUT ON;
DECLARE
       FOR counter IN 10..20 LOOP
           DBMS_OUTPUT.PUT_LINE(counter);
       END LOOP;
END;

BEGIN
    FOR counter IN REVERSE 50..100 LOOP
        DBMS_OUTPUT.PUT_LINE(counter);
        END LOOP;
END;



CREATE TABLE employees1 (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    e_index VARCHAR(100) CHECK (e_index LIKE 'EID-%'),
    e_name VARCHAR(100) NOT NULL,
    basic_salary DECIMAL(20,2) DEFAULT 25000.00 CHECK (basic_salary >= 0.00),
    allowances DECIMAL(20,2) DEFAULT 0.00 CHECK (allowances >= 0.00),
    deductions DECIMAL(20,2) DEFAULT 0.00 CHECK (deductions >= 0.00)
);


INSERT INTO employees1(e_index, e_name, basic_salary, allowances, deductions)
    VALUES('EID-001', 'John Cena', 45000.00, 12000.00, 5000.00);
INSERT INTO employees1(e_index, e_name, basic_salary, allowances, deductions)
    VALUES('EID-002', 'Randy Deodrant', 75000.00, 10000.00, 1500.00);
INSERT INTO employees1(e_index, e_name, basic_salary, allowances, deductions)
    VALUES('EID-003', 'Kusal Mendis', 55000.00, 3000.00, 2000.00);
 

SET SERVEROUTPUT ON;

DECLARE
    v_name employees1.e_name%TYPE;
    v_basic employees1.basic_salary%TYPE;
    v_allowances employees1.allowances%TYPE;
    v_deduct employees1.deductions%TYPE;
    v_final NUMBER;
BEGIN
    -- Use a query that only returns one row
    SELECT e_name, basic_salary, allowances, deductions 
    INTO v_name, v_basic, v_allowances, v_deduct 
    FROM employees1
    WHERE e_index = 'EID-003'
    FETCH FIRST 1 ROW ONLY;  -- Ensures only one row is returned

    -- Calculate the final salary
    v_final := v_basic + v_allowances - v_deduct;

    -- Display the results
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Net Salary: ' || v_final);
END;


SET SERVEROUTPUT ON;

DECLARE
    v_name employees1.e_name%TYPE;
    v_basic employees1.basic_salary%TYPE;
    v_allowances employees1.allowances%TYPE;
    v_deduct employees1.deductions%TYPE;
    v_final NUMBER;
BEGIN
    v_name := 'das';  -- Use substitution variable to capture user input

    BEGIN
        -- Attempt to select the employee's salary details
        SELECT basic_salary, allowances, deductions
        INTO v_basic, v_allowances, v_deduct 
        FROM employees1
        WHERE e_name = v_name
        FETCH FIRST 1 ROW ONLY;  -- Ensures only one row is fetched
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Handle the case where no employee with that name is found
            DBMS_OUTPUT.PUT_LINE('No employee found with the name: ' || v_name);
            RETURN;  -- Exit the block if no data is found
    END;

    -- Calculate the final salary if the employee was found
    v_final := v_basic + v_allowances - v_deduct;

    -- Display the results
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Final Salary: ' || v_final);
END;

--Create a PLSQL block that displays the number of number of employees who got
--Update the basic salary of all employees whose basic salary
DBMS OUTPUT.PUT_LINEUPDATE EMPLOYEES SET BASIC_SALARY=BASIC_SALARY+(BASIC_SALARY*0.05)
  WHERE BASIC_SALARY>=50000.00;
DECLARE
    row_count NUMBER;
BEGIN
     UPDATE EMPLOYEES SET basic_salary=basic_salary+(basic_salary*0.05)
        WHERE basic_salary>=50000.00;
    IF SQL%FOUND THEN
       row_count:=SQL%ROWCOUNT;
       DBMS_OUTPUT.PUT_LINE('Number of Employees who Got Increment: ' ||row_count);
    ELSE
       DBMS_OUTPUT.PUT_LINE('None the Employees got the increment');
    END IF;
END;

--Create a PLSQL block to accept employee id from the user and
--display the final salary of the employee using
--Final salary basic salary allowances -deductions
--Display a proper message if the employee ti not be found to the given la

ACCEPT e_id CHAR PROMPT 'Enter employee ID: ';
DECLARE 
      v_id EMPLOYEES.e_index%TYPE;
      v_basic employees.basic_salary%TYPE;
      v_allow employees.allowance%TYPE;
      v_deduct employees.deducations%TYPE;
      v_final NUMBER;
BEGIN
     v_id:='&e_id';
     SELECT basic_salary.allowances,deductions
      INTO v_basic,v_allow,v_deduct WHERE e_index=v_id;
IF SQL%FOUND THEN
     v_final:=v_basic+v_allow-v_deduct;
     DBMS_OUTPUT.PUT_LINE('Final Salary:'||v_final);
ELSE
   DBMS_OUTPUT.PUT_LINE('Can not find the employee with the specified index');
END IF;
END;

*/
--Explicit Cursors
--Use a Cursor to calculater and display employee name and final salary of all the emplooyes
*/

DECLARE
      CURSOR emp_cursor IS SELECT e_name,basic_salary,allowances,deductions FROM EMPLOYEES1;
      
      v_name employees1.e_name%TYPE;
      v_basic employees1.basic_salary%TYPE;
      v_allowances employees1.allowances%TYPE;
      v_deduct employees1.deductions%TYPE;
      v_final NUMBER;
      
BEGIN
    OPEN emp_cursor;
    LOOP
       FETCH emp_cursor INTO v_name,v_basic,v_allowances,v_deduct;
       EXIT WHEN emp_cursor%NOTFOUND;
       v_final:=v_basic+v_allowances-v_deduct;
       DBMS_OUTPUT.PUT_LINE('Name: '||v_name);
       DBMS_OUTPUT.PUT_LINE('Final Salary'||v_final);
    END LOOP;
CLOSE emp_cursor;
END;

*/
--Add a new Column to the employees table to store tax amount for the employees
--Use a cursor to calculate the tax amount for all the employees and update
--their records in the table by inserting their tax amounts
--Criteria to calculate tax amount
--if gross salary>=500000.00, tax rate-0.15
--else if gross salary>-300000.00, tax rate-0.10
--else if gross salary>-100000.00, tax rate-0.06
--else tax rate-0.02
--gross salary-basic salary allowances-deductions
--tax amount-gross salary tax rate
--Display employee name and tax amount after updating employee details
*/

SET SERVEROUTPUT ON;

DECLARE
          
    CURSOR empl_cursor IS SELECT id, e_name, basic_salary, allowances, deductions FROM employees1;

   
    v_id employees1.id%TYPE;
    v_name employees1.e_name%TYPE;
    v_basic employees1.basic_salary%TYPE;
    v_allowances employees1.allowances%TYPE;
    v_deduct employees1.deductions%TYPE;
    v_gross NUMBER;
    v_tax_rate NUMBER;
    v_tax_amount NUMBER;

BEGIN
    
    OPEN empl_cursor;
    
    LOOP
        
        FETCH empl_cursor INTO v_id, v_name, v_basic, v_allowances, v_deduct;
        
      
        EXIT WHEN empl_cursor%NOTFOUND;

       
        v_gross := v_basic + v_allowances - v_deduct;
        
        
        IF v_gross >= 50000.00 THEN
            v_tax_rate := 0.15;
        ELSIF v_gross >= 30000.00 THEN
            v_tax_rate := 0.10;
        ELSIF v_gross >= 10000.00 THEN
            v_tax_rate := 0.06;
        ELSE
            v_tax_rate := 0.02;
        END IF;
        
        
        v_tax_amount := v_gross * v_tax_rate;

        
        UPDATE employees1 
        SET tax_amount = v_tax_amount
        WHERE id = v_id;

        
        DBMS_OUTPUT.PUT_LINE('Employee Nme: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Tax amount: ' || v_tax_amount);
    END LOOP;

    
    CLOSE empl_cursor;
    
    
    COMMIT;
END;


--Add a new Column to the employees table to store tax amount for the employees

--Use a cursor to calculate the tax amount for all the employees and update
--their records in the table by inserting their tax amounts
--Criteria to calculate tax amount
--if gross salary>=500000.00, tax rate-0.15
--else if gross salary>-300000.00, tax rate-0.10
--else if gross salary>-100000.00, tax rate-0.06
--else tax rate-0.02
--gross salary-basic salary allowances-deductions
--tax amount-gross salary tax rate
--Display employee name and tax amount after updating employee details

ALTER TABLE employees1 ADD tax_amount DECIMAL(20,2) DEFAULT 0.02;

SET SERVEROUTPUT ON;

DECLARE
    CURSOR emp_cursor IS
        SELECT id,e_name,basic_salary,allowances,deductions FROM employees1;

v_id employees1.id%TYPE;
v_name employees1.e_name%TYPE;
v_basic employees1.basic_salary%TYPE;
v_allow employees1.allowances%TYPE;
v_ded employees1.deductions%TYPE;
v_gross NUMBER;
v_tax_rate NUMBER;
v_tax_amount NUMBER;

BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_id,v_name,v_basic,v_allow,v_ded;
    EXIT WHEN emp_cursor%NOTFOUND;
    


IF v_gross>=50000.00 THEN
    v_tax_rate:=0.15;
ELSIF v_gross>=30000.00 THEN
    v_tax_rate:=0.10;
ELSIF v_gross>10000.00 THEN
    v_tax_rate:=0.06;
ELSE
    v_tax_rate:=0.02;
END IF;

v_tax_amount := v_gross * v_tax_rate;

UPDATE employees1 SET tax_amount=v_tax_amount WHERE id=v_id;

DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_name);
DBMS_OUTPUT.PUT_LINE('Tax amount: '||v_tax_amount);

END LOOP;
CLOSE emp_cursor;
END;

--Create a procedure to display a greeting message to the user
CREATE OR REPLACE PROCEDURE greetUser
AS
  msg VARCHAR(100);
BEGIN
  msg:='Hello from Stored Procedures';
  DBMS_OUTPUT.PUT_LINE(msg);
END;

/Invoking procedure as a standalone program/
EXECUTE greetUser;

/Invoke the procedure inside a PLSQL block/
BEGIN
    GREETUSER;
END;

--Create a PROCEDURE to accept bank balance and interest rate as
--parameters and display the interest amount
--Interest amount bank balance interest rate

CREATE OR REPLACE PROCEDURE calInterest(balance UNDER, rate ramDER)

 AS
   interest NUKBER;

 BEGIN
    interest:=balance*rate;
    DBMS_OUTPUT.PUT_LINE('Interest Amount:'|| interest);
 END;

--As a Standalone program
EXECUTE CALINTEREST(2500.00,0.10)

--Inside a PLSQL block 
ACCEPT balance NUMBER PROMPT 'Enter Current Balance: ';
ACCEPT rate NUMBER PROMPT 'Enter Interest Rate ';
DECLARE
       v_balance NUMBER;v_rate NUMBER;v_amount NUMBER;
BEGIN
     v_balance:='&balance';
     v_rate:='&rate';
     CALINTEREST(v_balance,v_rare);
END;

--Create a procedure to accept two number as parameters and returns use proper parameter types

CREATE OR REPLACE PROCEDURE findMax(num1 IN NUMBER,num2 IN NUMBER,max_num OUT NUMBER);
AS
BEGIN
    IF num1>num2 THEN
        max_num:=num1;
    ELSE
        max_num:=num2;
    END IF;
END;

--Invoking the procedure
DECLARE
    max_no NUMBER;
BEGIN
    findMax(34,56,max_no)
    DBMS_OUTPUT.PUT_LINE('Maximum: '||max_no);
END;

// Create the following tables for a manufacturing DB product
--( Product_id integer autoinccrement primary key,
    --product_name varchar(100) unique,
    --price decimal/number 100.00,
    --stock int can not be less than 0

--Production
--id integer autoincrement primary key,
--product_id int foreign key,
--manufacture_data varchar/date,
--manufactured_quantity int can not be less than 0

CREATE TABLE products(
  product_id int GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1 PRIMARY
  KEY,
  product_name VARCHAR (100) UNIQUE,
  price NUMBER DEFAULT 100.00,
  stock NUMBER CHECK (stock>=0.00)
);
CREATE TABLE productions(
  id int GENERATED ALWAYS AS IDENTITY START WITH 1 INCREMENT BY 1 PRIMARY
  KEY,
  product_id int REFERENCES products(product_id),
  manufacture_date varchar(40),
  quantity NUMBER CHECK(quantity>0.00)
);

--CREATE A PROCEDURE TO REGISTER A PRODUCT BY ACCEPTING name, price and opening
--stock of a product as PARAMETERS.

--CREATE A PROCEDURE TO UPDATE A PRODUCT BY ACCEPTING id,name,price and 
--available stock of a product as PARAMETERS

--CREATE A PROCEDURE TO DELETE A product by ACCEPTING ID AS a PARAMETER

--CREATE A PROCEDURE TO DEMONSTRATE SALES OPERATION BY ACCEPTING product name,
--quantity sold as parameters and RETURNS sales amount
--sales amount=unit price*quantity sold
--UPDATE THE STOCK OF THE PRODUCT ACCORDINGLY

CREATE TABLE production(
CREATE OR REPLACE PROCEDURE registerProduct(
    v_name VARCHAR,
    v_price NUMBER,
    v_stock NUMBER
  )
AS
BEGIN
    INSERT INTO products(PRODUCT_NAME,PRICE,STOCK) VALUES(v_name,v_price,v_stock);
    COMIT;
END;
CREATE OR REPLACE PROCEDURE updateProduct(
 old_name VARCHAR,new_name VARCHAR, v_price NUMBER, v_stock NUMBER)
 AS
 BEGIN
     UPDATE products SET PRODUCT_NAME=new_name,PRICE=v_price,STOCK=v_stock
     WHERE PRODUCT_NAME=old_name;
 COMIT;
END;
CREATE OR REPLACE PROCEDURE deleteProduct(v_id INT)
AS
BEGIN
    DELETE FROM product_id=v_id;
    DELETE FROM products WHERE product_id=v_id;
    COMIT;
END;


    







