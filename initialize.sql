-- Setup the database for a very simple 'social network'.
-- Friends - Users - Messages 

\c postgres
DROP DATABASE IF EXISTS venmo;

CREATE database venmo;
\c venmo

\i create.SQL

-- Users.csv
-- Friends.csv
-- Messages.csv

-- In this lab, as preparation for the project, you need to create the
-- three csv files Users.csv, Friends.csv and Messages.csv.  Create at
-- least 6 entries in each of these files.  
--
-- Look at last weeks lab lab05_load.sql and CSV files to guide your effort.

-- Modeling the structure of the 'Users' table,
-- read data from a csv file Users.csv
--
-- insert at least 6 users
 SET datestyle = dmy;

\copy Bank_Account(bank_account_num, bank_name, bank_account_type, date_of_linking) FROM 'bank_account.csv' csv header

\copy Business(username, business_name) FROM 'business.csv' csv header

\copy Comment(comment_id, trans_id, comment_text, commentor_username) FROM 'comment.csv' csv header

\copy Facebook(facebook_username, num_of_facebook_friends) FROM 'facebook.csv' csv header

\copy Friend(friendship_id, username, friend_username, date_friendship, friend_request_username) FROM 'friend.csv' csv header

\copy Individual(username, f_name, l_name) FROM 'individual.csv' csv header

\copy Transaction(trans_id, sender_username, amount, num_of_likes, description) FROM 'transaction.csv' csv header

\copy Venmo_User(username, balance, bank_account_num, num_of_venmo_friends, facebook_username) FROM 'user.csv' csv header

\copy Venmo_Transaction(trans_id, receiver_username, is_payment) FROM 'venmo_transaction.csv' csv header

\copy App_Transaction(trans_id, app_name) FROM 'app_transaction.csv' csv header



-- ============================================================


  
