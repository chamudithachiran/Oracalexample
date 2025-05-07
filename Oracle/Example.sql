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


CREATE OR REPLACE PROCEDURE registerProduct(
    v_name VARCHAR,
    v_price NUMBER,
    v_stock NUMBER
  )
AS
BEGIN
    INSERT INTO products(PRODUCT_NAME,PRICE,STOCK) VALUES(v_name,v_price,v_stock);
    COMMIT;
END;
CREATE OR REPLACE PROCEDURE updateProduct(
 old_name VARCHAR,new_name VARCHAR, v_price NUMBER, v_stock NUMBER)
 AS
 BEGIN
     UPDATE products SET PRODUCT_NAME=new_name,PRICE=v_price,STOCK=v_stock
     WHERE PRODUCT_NAME=old_name;
 COMMIT;
END;
CREATE OR REPLACE PROCEDURE deleteProduct(v_id INT)
AS
BEGIN
    DELETE FROM product_id=v_id;
    DELETE FROM products WHERE product_id=v_id;
    COMMIT;
END;

CREATE ON REPLACE PROCEDURE sales(
  v_name IN VARCHAR,quantity IN NUMBER,amount OUT NUMBER
)
AS
  v_price products.price%TYPE;
BEGIN
    SELECT price INTO v_price FROM PRODUCTS WHERE product_name=v_name;
    amount:=quentity*v_price;
    UPDATE product SET stock=stock-quantity WHERE product_name=v_name;
    COMMIT;
END;

--Create a procedure to record daily productions by accepting product name, manufacture date and manufactured quantity
    -- as parameters. update the stock of the product accordingly.
    
CREATE OR REPLACE PROCEDURE daily_production(
   v_name VARCHAR,v_date VARCHAR, v_quantity NUMBER
)
AS
  v_id productions.product_id%TYPE;
BEGIN
    SELECT product_id INTO v_id FROM products WHERE product_name=v_name;
    INSERT INTO productions(product_id,manufacture_date,quantity)
         VALUES(v_id,v_date,v_quantity);
    UPDATE products SET STOCK=stock+v_quantity WHERE product_id=v_id;
    COMMIT;
END;

--Insert at least 3 records to production table using the procedure created
BEGIN
     REGISTERPRODUCT('ABC 10G',200.00,10);
     REGISTERPRODUCT('ABC 50G',350.00,5);
     REGISTERPRODUCT('CDE 200G',1200.00,0);
END;

BEGIN
    register_product('ABC 10G',200.00,10);
    register_product('ABC 50G',350.00,5);
    register_product('CDE 20G',1200.00,0);
    END;


BEGIN
    daily_record('ABC 10G','2025-02-10',100);
    daily_record('ABC 50G','2025-02-20',50);
    daily_record('CDE 20G','2025-02-27',120);
    END;

SELECT * from Product;
SELECT * from Productions;

//Create a PLSQL block to accept item name and quantity sold from the user and display sales amount using the procedures created/
ACCEPT _name CHAR PROMPT 'Enter Item Name: ';
ACCEPT _quantity NUMBER PROMPT 'Enter Quantity Sold: ';
DECLARE
     v_name products.product_name%TYPE;
     v_qty NUMBER;
     v_amount NUMBER;
BEGIN
     v_name:='&_name';
     v_qty:='&_quantity';
     PROC_SALES(v_name,v_qty,v_amount);
     DBMS_OUTPUT.PUT_LINE('Sales Amount: '||v_amount);
END;
EXCEPTION

 WHEN NO_DATA_FOUND THEN
       DBMS_OUTPUT.PUT_LINE('No item can be found with the item name provided');
 WHEN TOO_MANY_ROWS THEN
       DBMS_OUTPUT.PUT_LINE('Multiple items are available with the item name');
 WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('Something went wrong');
END;



--Create a before trigger to validate the manufacturing quantity  used
--inserting a new recode to productions table
--if manufacturing quntity is null set the value to 75

--create a after trigger to display the changes performed when
--executing INSERT, UPDATE on products table 

/*
  CREATE OR REOLACE TRIGER <trigger_name>
  AFTER <operations> ON <table>
  FOR EACH ROW
  BEGIN
      //PLSQL Statements
  END;
*/

CREATE OR REPLACE TRIGGER productLog
AFTER INSERT OR UPDATE OR DELETE ON products
FOR EACH ROW 
BEGIN
    IF INSERTING THEN 
        DBMS_OUTPUT.PUT_LINE('Record Inserted.');
        DBMS_OUTPUT.PUT_LINE('Name: ' || :NEW.product_name);
        DBMS_OUTPUT.PUT_LINE('Price: ' || :NEW.price);
        DBMS_OUTPUT.PUT_LINE('Stock: ' || :NEW.stock);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Record Updated.');
        DBMS_OUTPUT.PUT_LINE('Name updated from ' || :OLD.product_name || ' to ' || :NEW.product_name);
        DBMS_OUTPUT.PUT_LINE('Price updated from ' || :OLD.price || ' to ' || :NEW.price);
        DBMS_OUTPUT.PUT_LINE('Stock updated from ' || :OLD.stock || ' to ' || :NEW.stock);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Record Deleted.');
        DBMS_OUTPUT.PUT_LINE('Deleted product name: ' || :OLD.product_name);
    END IF;
END;
/


--Insead of triggers
/*
CREATE OR REPLACE TRIGGER <trigger_name>
INSTEAD OF <operation> ON <table_name>
FOR EACH ROW
BEGIN
    //PLSQL Statements
END;
*/

--create an instead of trigger to display the message 'can not delete products' instead of deleting a record when user executes a
--delete quary

CREATE OR REPLACE TRIGGER deleteProduct
INSTEAD OF DELETE ON products
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR('Cannot delete a product');
END;
/


