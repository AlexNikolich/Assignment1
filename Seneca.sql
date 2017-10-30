SET SERVEROUTPUT ON

--ASSIGNMENT 1 - question 1
DECLARE
TYPE customer_rec is RECORD
  (
  Name      VARCHAR2(15) := 'Customer',
  Phone     VARCHAR2(15),
  areaCode  VARCHAR2(3),
  prefix    VARCHAR(3),
  num       VARCHAR(4));
cust_rec customer_rec;

BEGIN
  cust_rec.Phone := 'Home Phone';
  cust_rec.areaCode := '905';
  cust_rec.prefix := '804';
  cust_rec.num := '9090';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num);
  
  cust_rec.Phone := 'Office Phone';
  cust_rec.areaCode := '416';
  cust_rec.prefix := '788';
  cust_rec.num := '9191';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
  cust_rec.Phone := 'Mobile Phone';
  cust_rec.areaCode := '965';
  cust_rec.prefix := '856';
  cust_rec.num := '9292';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
  cust_rec.Phone := 'Cottage Phone';
  cust_rec.areaCode := '905';
  cust_rec.prefix := '259';
  cust_rec.num := '9393';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
  cust_rec.Phone := 'Pager Phone';
  cust_rec.areaCode := '417';
  cust_rec.prefix := '794';
  cust_rec.num := '9797';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
    cust_rec.Phone := 'Fax Phone';
  cust_rec.areaCode := '450';
  cust_rec.prefix := '169';
  cust_rec.num := '9898';
  DBMS_OUTPUT.PUT_LINE(cust_rec.Name || ' ' || cust_rec.Phone || ': ' || cust_rec.areaCode || '-' || cust_rec.prefix || '-' || cust_rec.num); 
  
END;



SELECT AVG(MAX(salary))
  FROM employees
  GROUP BY department_id;
  
  
  
DECLARE
  v_departmentName    DEPARTMENTS.DEPARTMENT_NAME%TYPE :='Finance';
  v_numberOfEmployees NUMBER :=0;
  v_averageSalary     NUMBER :=0;
  v_totalSalary       NUMBER :=0;
  v_departmentId      NUMBER(5);
  
  CURSOR c_dep_cursor IS
  Select salary from EMPLOYEES WHERE department_id = 30;
BEGIN
--  SELECT department_id INTO v_departmentId FROM DEPARTMENTS WHERE department_name = v_departmentName;
--  for i IN DEPARTMENTS.DEPARTMENT_ID.FIRTS..departments.department_id.last
--  LOOP
--       DBMS_OUTPUT.PUT_LINE('sale');
--  END LOOP;
   DBMS_OUTPUT.PUT_LINE(v_departmentId);
END;


--ASSIGNMENT 1 - question 2
DECLARE
  v_departmentName    DEPARTMENTS.DEPARTMENT_NAME%TYPE :='IT'; -- try NOC (no employees) or Sales (3 employees)
  v_numberOfEmployees NUMBER :=0;
  v_averageSalary     NUMBER(7,2);
  v_totalSalary       NUMBER :=0;
  v_departmentId      NUMBER(5);
BEGIN 
  SELECT department_id INTO v_departmentId FROM DEPARTMENTS WHERE department_name = v_departmentName;
  FOR emp_rec IN(Select salary from EMPLOYEES WHERE department_id = v_departmentId)
  LOOP
    v_numberOfEmployees := v_numberOfEmployees + 1;
    v_totalSalary := v_totalSalary + emp_rec.salary;
  END LOOP;

  IF v_numberOfEmployees < 1 THEN
    DBMS_OUTPUT.PUT_LINE(v_departmentName || ' has no employees');
  ELSE
    v_averageSalary := v_totalSalary/v_numberOfEmployees;
    DBMS_OUTPUT.PUT_LINE(v_departmentName);
    DBMS_OUTPUT.PUT_LINE('  Number of Employees: ' || v_numberOfEmployees);
    DBMS_OUTPUT.PUT_LINE('  Average Salary: ' || v_averageSalary);
    DBMS_OUTPUT.PUT_LINE('  Total Salary: ' || v_totalSalary);
  END IF;
END;




BEGIN 

  FOR emp_rec IN(Select * from EMPLOYEES)
  LOOP
    DBMS_OUTPUT.PUT_LINE(emp_rec.employee_id);
  END LOOP;
END;


DECLARE 
TYPE emp_table IS TABLE OF
  employees%ROWTYPE INDEX BY PLS_INTEGER;
my_emp emp_table;

BEGIN 
  FOR j IN employees.FIRST..employees.LAST
  LOOP
      DBMS_OUTPUT.PUT_LINE('sale ' || j);
    END LOOP;
  END;


  
SELECT COUNT(*) FROM employees;
  
DECLARE
v_countRows NUMBER(5);

BEGIN
  SELECT COUNT(*) INTO v_countRows FROM employees;
  DBMS_OUTPUT.PUT_LINE(v_countRows);
  for i IN 10..15
  LOOP
       DBMS_OUTPUT.PUT_LINE('sale');
  END LOOP;
END;
  


  





drop table LOCATIONS_TEMP;

CREATE TABLE LOCATIONS_TEMP(
	LOCATION_ID NUMBER(4,0),
	STREET_ADDRESS VARCHAR2(40),
	POSTAL_CODE VARCHAR2(12),
	CITY VARCHAR2(30),
	STATE_PROVINCE VARCHAR2(25),
	COUNTRY_ID VARCHAR2(2),
	OPERATION VARCHAR2(1)
);



INSERT INTO LOCATIONS_TEMP
VALUES (1100, '93091 Calle della Testa', 10934, 'Venice', null, 'IT', 'D');
INSERT INTO LOCATIONS_TEMP
VALUES (2000, '93091 Calle della Testa', 10934, 'Venice', null, 'IT', 'I'); 
INSERT INTO LOCATIONS_TEMP
VALUES (4000, '93091 Calle della Testa', 10934, 'Venice', null, 'IT', 'D'); 

DELETE FROM LOCATIONS_TEMP
WHERE LOCATION_ID = 1200;
  
  
--DECLARE 
--TYPE loc_temp_table IS TABLE OF
--  LOCATIONS_TEMP%ROWTYPE INDEX BY PLS_INTEGER;
--loc_temp loc_temp_table;
--v_countRows NUMBER(5) :=0;
--
--BEGIN
--  SELECT COUNT(*) INTO v_countRows FROM locations_temp;
--  DBMS_OUTPUT.PUT_LINE(v_countRows);
--  v_countRows := v_countRows*100 + 1000;
--  DBMS_OUTPUT.PUT_LINE(v_countRows);
--  FOR i IN 1000..v_countRows
--  LOOP
--       SELECT * INTO loc_temp(i) FROM locations_temp WHERE rownum = 1000;
--        
--  END LOOP;
--END;
--
--  SELECT * FROM LOCATIONS WHERE rownum = 2;
  
  
--  
--DECLARE
--v_countRows NUMBER(5);
--
--BEGIN
--  SELECT COUNT(*) INTO v_countRows FROM employees;
--  DBMS_OUTPUT.PUT_LINE(v_countRows);
--  for i IN 10..15
--  LOOP
--       DBMS_OUTPUT.PUT_LINE('sale');
--  END LOOP;
--END;  



--ASSIGNMENT 1 - question 2
DECLARE
  CURSOR c_loc_temp IS
  SELECT * FROM locations_temp ;
  v_flag NUMBER (4,0);
BEGIN 
  FOR loc_temp_record IN c_loc_temp
    LOOP
    
      IF loc_temp_record.operation = 'D' THEN
        v_flag :=0;
            BEGIN    
            Select location_id INTO v_flag FROM LOCATIONS WHERE location_id = loc_temp_record.location_id;
             exception
             when no_data_found then
             v_flag := 0;
             END;
          IF v_flag >0 THEN
            DELETE FROM LOCATIONS_TEMP
            WHERE LOCATION_ID = v_flag;
            DBMS_OUTPUT.PUT_LINE('Delete row in ocation table with ID: ' || v_flag);
          ELSE
            DBMS_OUTPUT.PUT_LINE('There is NO location with this ID: ' || loc_temp_record.location_id);
          END IF;
          
     ELSIF loc_temp_record.operation = 'I' THEN --PAZI vrati ga posle na ELSIF
        v_flag :=0;
           BEGIN    
            Select location_id INTO v_flag FROM LOCATIONS WHERE location_id = loc_temp_record.location_id;
             exception
             when no_data_found then
             v_flag := 0;
             END;
          IF v_flag <1 THEN
             SELECT location_id INTO v_flag FROM  locations WHERE location_id = (SELECT MAX(location_id)  FROM locations);
             v_flag := v_flag + 100;
            
            INSERT INTO LOCATIONS
            VALUES(v_flag,loc_temp_record.street_address, loc_temp_record.postal_code, loc_temp_record.city, loc_temp_record.state_province, loc_temp_record.country_id);
            DBMS_OUTPUT.PUT_LINE('Insert Row in location with ID: ' || v_flag);
          ELSE
            DBMS_OUTPUT.PUT_LINE('There is ALREADY location with this ID: ' || v_flag);
          END IF;
          
--      ELSIF loc_temp_record.operation = 'I' THEN
--        v_flag :=0;
--        Select location_id INTO v_flag FROM LOCATIONS WHERE location_id = loc_temp_record.location_id;
--          IF v_flag <0 THEN
--            DBMS_OUTPUT.PUT_LINE(loc_temp_record.street_address);
--            INSERT INTO LOCATIONS
--            VALUES(loc_temp_record.street_address, loc_temp_record.postal_code, loc_temp_record.city, loc_temp_record.state_province, loc_temp_record.country_id);
--            DBMS_OUTPUT.PUT_LINE('Insert Row in location with ID: ' || v_flag);
--          ELSE
--            DBMS_OUTPUT.PUT_LINE('There is ALREADY location with this ID: ' || v_flag);
--          END IF;
          
          
      
      
      ELSE
        DBMS_OUTPUT.PUT_LINE('There is NO OPERATION: ' || loc_temp_record.operation);
      
      END IF;
    END LOOP;
END;





commit;

rollback;


SELECT COUNT(*)  FROM locations;
SELECT * FROM  locations WHERE location_id = (SELECT MAX(location_id)  FROM locations);










  
  
  
  