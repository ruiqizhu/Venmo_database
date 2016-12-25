------------------------------------------------------------
--1. Display total venmo requests
------------------------------------------------------------
\echo "Showing venmo money requests"
SELECT * FROM venmo_transaction WHERE is_payment = FALSE;
    
------------------------------------------------------------
--2. List all users
------------------------------------------------------------
\echo "Showing info of all users"
SELECT * FROM venmo_user as u;

 
-----------------------------------------------------------------
--3. See the total number of transactions
-----------------------------------------------------------------
\echo "See total numer of transactions"

SELECT COUNT(trans_id) 
    FROM Transaction;
-----------------------------------------------------------------
--4. Look at average transaction amount
-----------------------------------------------------------------
\echo "Look at average transaction amount"
SELECT AVG(amount) as average_amount
    FROM Transaction;


-----------------------------------------------------------------
--5. Display the most popular transactions in order
-----------------------------------------------------------------
\echo "Display the most popular transactions in order"

SELECT sender_username, amount, num_of_likes, description 
    FROM Transaction 
    ORDER BY num_of_likes DESC;


-----------------------------------------------------------------
--6. What apps have the largest amount of transaction
-----------------------------------------------------------------
\echo "Display app with the largest amount of transaction"

SELECT DISTINCT app_name, COUNT(app_name) as app_count 
    FROM App_Transaction 
    GROUP BY app_name 
    ORDER BY COUNT(app_name) DESC;
    

-----------------------------------------------------------------
--7. View total amount of money exchanged on Venmo
-----------------------------------------------------------------
\echo "View total amount of money exchanged on Venmo"

SELECT sum(t.amount)
  FROM Transaction as t;


-----------------------------------------------------------------
--8. See which user has the most friends
-----------------------------------------------------------------
\echo "See which user has the most friends"
SELECT u.username
  FROM Venmo_User as u
  ORDER BY num_of_venmo_friends DESC
  LIMIT 1;
    

-----------------------------------------------------------------
-- 9. View your linked banked accounts
-----------------------------------------------------------------

\echo "View your linked banked accounts"

SELECT b.bank_account_num, b.bank_name, b.bank_account_type
  FROM Bank_Account as b
  JOIN Venmo_User as u
  ON u.bank_account_num = b.bank_account_num 
  WHERE u.username = 'bill_brown';
       
    
-----------------------------------------------------------------
-- 10. View your linked banked accounts
-----------------------------------------------------------------

\echo "Look up a friend's public info by their username" 
    
SELECT u.num_of_venmo_friends, u.facebook_username
  FROM Venmo_User as u
  WHERE u.username = 'frank_fox';
    

-----------------------------------------------------------------
--11. See number of likes of a transaction, given trans id
-----------------------------------------------------------------

\echo "See number of likes of a transaction, given trans id"  
    
SELECT t.num_of_likes
  FROM Transaction as t
  WHERE t.trans_id = 3;
    