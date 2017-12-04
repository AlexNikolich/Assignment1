
SET SERVEROUTPUT ON

-- Assignment 2, Question 1
CREATE OR REPLACE FUNCTION product_review(category IN product_information.category_id%TYPE)
RETURN NUMBER
IS
number_status PLS_INTEGER;
BEGIN
  number_status := 0;
    FOR prod_inf IN(Select * from PRODUCT_INFORMATION WHERE category_id = category)
    LOOP
       IF prod_inf.product_status = 'orderable' THEN 
         number_status := number_status +1;
       END IF;
    END LOOP;
  RETURN number_status;
END product_review;

-- TEST
BEGIN
   DBMS_OUTPUT.PUT_LINE('Insert category and you can see how many products are in ordable status: ' || PRODUCT_REVIEW(13));
END;




-- Assignment 2, Question 2
CREATE OR REPLACE PROCEDURE display_orders (
  customer customers.customer_id%TYPE) IS
  type t_order is RECORD
    (order_rec orders%ROWTYPE);
  v_order t_order;
  
  type t_order_item is RECORD
    (order_items_rec order_items%ROWTYPE);
  v_order_item t_order_item;
  
  flag NUMBER(8) :=0;
  flag1 NUMBER(8) :=0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('These are all ORDERS and all ORDER ITEMS for input Customer:
    ');
    FOR  order_cur IN(Select * from orders where customer_id = 102)
    LOOP
      v_order.order_rec :=order_cur;
        flag := flag +1;
        flag1 := 0;
        DBMS_OUTPUT.PUT_LINE('ORDER NUMBER:' || flag || ' (Date order: ' || v_order.order_rec.order_date || ', Order Mode: ' || v_order.order_rec.order_mode || ', Order Total: $' || v_order.order_rec.order_total || ')');
         FOR  order_item_cur IN(Select * from order_items where order_id = v_order.order_rec.order_id)
         LOOP
          flag1 := flag1 +1;
          v_order_item.order_items_rec := order_item_cur;
          DBMS_OUTPUT.PUT_LINE('  ORDER ITEM: ' || flag1 || ' (Price: $' || v_order_item.order_items_rec.unit_price || ', Discount Price: ' || v_order_item.order_items_rec.discount_price || ', Quantity: ' || v_order_item.order_items_rec.quantity || ')');
         END LOOP;
    END LOOP;
END display_orders;

-- TEST
EXECUTE display_orders (101);



-- Assignment 2, Question 3

CREATE OR REPLACE PROCEDURE update_order_total (
  v_customer orders.customer_id%TYPE,
  v_order_id orders.order_id%TYPE) IS
  totalNumber NUMBER(8) := 0;
BEGIN
   FOR  order_cur IN(Select * from orders where customer_id = v_customer AND order_id = v_order_id)
    LOOP
         FOR  order_item_cur IN(Select * from order_items where order_id = v_order_id)
         LOOP
          totalNumber := totalNumber + order_item_cur.quantity * order_item_cur.unit_price;
        END LOOP;
    END LOOP;
      UPDATE orders
      SET order_total = totalNumber
      WHERE customer_id = v_customer AND order_id = v_order_id;
    DBMS_OUTPUT.PUT_LINE('For customer Id:' || v_customer || ' and order ID:'|| v_order_id || ' total order is: ' || totalNumber);
END update_order_total;

--TEST
EXECUTE update_order_total (101,2458);


-- Assignment 2, Question 4
-- FIRST
CREATE OR REPLACE PROCEDURE order_discount  IS
  v_total NUMBER(10);
BEGIN 
  FOR cust IN(SELECT customer_id, COUNT(*)FROM orders GROUP BY customer_id HAVING COUNT(*) > 4 )
  LOOP
    FOR orders IN(SELECT * FROM orders)   
     LOOP
      v_total := 0;
      v_total := orders.order_total;
      IF orders.customer_id = cust.customer_id THEN
        UPDATE orders
        SET order_total = v_total * 0.95 
        WHERE customer_id = cust.customer_id;
      END IF;
    END LOOP;
  END LOOP;
END order_discount;

--TEST
EXECUTE order_discount();

rollback;


--SECOND
CREATE OR REPLACE FUNCTION total_cost_per_customer(
  cust_id IN orders.customer_id%TYPE,
  date_start orders.order_date%TYPE,
  date_end orders.order_date%TYPE)
RETURN NUMBER
IS
number_total PLS_INTEGER;
BEGIN
  number_total := 0;
  FOR orders_cur IN(SELECT * FROM orders)
  LOOP
      IF orders_cur.customer_id = 101 AND date_start<orders_cur.order_date AND date_end>orders_cur.order_date THEN
        number_total := number_total + orders_cur.order_total;
      END IF;
  END LOOP;
  RETURN number_total;
END total_cost_per_customer;

-- TEST
BEGIN
   DBMS_OUTPUT.PUT_LINE('Total cost for customer between date: ' ||total_cost_per_customer(101, '10-AUG-01', '20-AUG-10'));
END;


--THIRD
CREATE OR REPLACE PROCEDURE order_discount(
  v_customer_id customers.customer_id%TYPE)IS
BEGIN 
  FOR cust IN(SELECT * FROM customers WHERE customer_id = v_customer_id)
  LOOP
    DBMS_OUTPUT.PUT_LINE('CUSTOMER NAME: ' || cust.cust_first_name || ' ' || cust.cust_last_name || ', ADDRESS: ' || cust.address || ', CITY: ' || cust.city);
  END LOOP;
END order_discount;

--TEST
EXECUTE order_discount(106);



--FOURTH
CREATE OR REPLACE FUNCTION new_order_id
RETURN NUMBER
IS
next_available PLS_INTEGER;
BEGIN
  SELECT COUNT(*) INTO next_available FROM orders;
  next_available := next_available + 1;
  RETURN next_available;
END new_order_id;


-- TEST
BEGIN
   DBMS_OUTPUT.PUT_LINE('Next available order id from ORDERS_SEQ is:  ' || new_order_id());
END;