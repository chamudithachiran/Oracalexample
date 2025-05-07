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
        DBMS_OUTPUT.PUT_LINE('Record inserted.');
        DBMS_OUTPUT.PUT_LINE('name:  '||NEW.product_name);
        DBMS_OUTPUT.PUT_LINE('Price:  '||NEW.price);
        DBMS_OUTPUT.PUT_LINE('Stock:  '||NEW.stock);
    ELSIF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Record Updated');
        DBMS_OUTPUT.PUT_LINE('Name updated from' ||OLD.product_name||'to' ||NEW.product_name);
        DBMS_OUTPUT.PUT_LINE('Price updated from' ||OLD.price||'to' ||NEW.price);
        DBMS_OUTPUT.PUT_LINE('Stock updated from' ||OLD.stock||'to' ||NEW.stock);
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('Record Deleted');
        DBMS_OUTPUT.PUT_LINE('Deleted product name: ' ||OLD.product_name);
    END IF;
END;