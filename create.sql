-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2016-12-03 19:50:36.238

-- tables
-- Table: Bank_Account
DROP TABLE IF EXISTS Bank_Account;
DROP TABLE IF EXISTS Business;
DROP TABLE IF EXISTS Comment;
DROP TABLE IF EXISTS Facebook;
DROP TABLE IF EXISTS Friend;
DROP TABLE IF EXISTS Individual;
DROP TABLE IF EXISTS Transaction;
DROP TABLE IF EXISTS Venmo_User;
DROP TABLE IF EXISTS Venmo_Transaction;
DROP TABLE IF EXISTS App_Transaction;
CREATE TABLE Bank_Account (
    bank_account_num int  NOT NULL,
    bank_name varchar  NOT NULL,
    bank_account_type varchar  NOT NULL,
    date_of_linking timestamp  NOT NULL,
    CONSTRAINT Bank_Account_pk PRIMARY KEY (bank_account_num)
);

-- Table: Business
CREATE TABLE Business (
    username varchar  NOT NULL,
    business_name varchar  NOT NULL,
    CONSTRAINT Business_pk PRIMARY KEY (username)
);

-- Table: Comment
CREATE TABLE Comment (
    comment_id int  NOT NULL,
    trans_id int  NOT NULL,
    comment_text varchar  NOT NULL,
    commentor_username varchar  NOT NULL,
    CONSTRAINT Comment_pk PRIMARY KEY (comment_id)
);

-- Table: Facebook
CREATE TABLE Facebook (
    facebook_username varchar  NOT NULL,
    num_of_facebook_friends int  NOT NULL,
    CONSTRAINT Facebook_pk PRIMARY KEY (facebook_username)
);

-- Table: Friend
CREATE TABLE Friend (
    friendship_id int NOT NULL,
    username varchar  NOT NULL,
    friend_username varchar  NOT NULL,
    date_friendship timestamp  NOT NULL,
    friend_request_username varchar  NOT NULL,
    CONSTRAINT Friend_pk PRIMARY KEY (friendship_id)
);

-- Table: Individual
CREATE TABLE Individual (
    username varchar  NOT NULL,
    f_name varchar  NOT NULL,
    l_name varchar  NOT NULL,
    CONSTRAINT Individual_pk PRIMARY KEY (username)
);

-- Table: Transaction
CREATE TABLE Transaction (
    trans_id int  NOT NULL,
    sender_username varchar  NOT NULL,
    amount decimal  NOT NULL,
    num_of_likes int  NOT NULL,
    description varchar  NOT NULL,
    CONSTRAINT Transaction_pk PRIMARY KEY (trans_id)
);

-- Table: User
CREATE TABLE Venmo_User (
    username varchar  NOT NULL,
    balance decimal  NOT NULL,
    bank_account_num int  NOT NULL,
    num_of_venmo_friends int  NOT NULL,
    facebook_username varchar  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (username)
);

-- Table: Venmo_Transaction
CREATE TABLE Venmo_Transaction (
    trans_id int  NOT NULL,
    receiver_username varchar  NOT NULL,
    is_payment boolean  NOT NULL,
    CONSTRAINT Venmo_Transaction_pk PRIMARY KEY (trans_id)
);

-- Table: app_Transaction
CREATE TABLE App_Transaction (
    trans_id int  NOT NULL,
    app_name varchar  NOT NULL,
    CONSTRAINT app_Transaction_pk PRIMARY KEY (trans_id)
);

-- End of file.

