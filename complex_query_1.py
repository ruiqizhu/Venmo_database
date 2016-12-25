#-----------------------------------------------------------------
# Working with psycopg2
#-----------------------------------------------------------------

import psycopg2
import sys

def heading(str):
    print('-'*60)
    print("** %s:" % (str,))
    print('-'*60, '\n')    

SHOW_CMD = True
def print_cmd(cmd):
    if SHOW_CMD:
        print(cmd.decode('utf-8'))

def print_rows(rows):
    for row in rows:
        print(row)

#------------------------------------------------------------
# show_menu
#------------------------------------------------------------

def show_menu():
    menu = '''

--------------------------------------------------
1. Pay friend money 

Choose (1, 0 to quit): '''

    try:
        choice = int(input( menu ))
    except ValueError:
        print("\n\n* Invalid choice. Choose again.")
        show_menu()
    else:
        if choice == 0:
            print('Done.')
            cur.close()
            conn.close()
        elif choice in range(1,1+1):
            print()
            actions[choice]()
            show_menu()
        else:
            print("\n\n* Invalid choice (%s). Choose again." % choice)
            show_menu()
    finally:
        if cur != None:
            cur.close() 
        if conn != None:
            conn.close() 
#------------------------------------------------------------
# 1. Pay to a friend
#------------------------------------------------------------
def pay_friend_menu():

    heading("paying friend money")
    sender = input("Username of the sender: ")
    receiver = input ("Username of the receiver: ")
    amount = input ("Enter amount to give: ")
    amount = float(amount)
    description = input("Enter your description: ")
    trans_id = trans_count() + 1
    info = [trans_id, sender, amount, 0, description]
    query = ''' 
        INSERT INTO Transaction(trans_id, sender_username, amount, 
        num_of_likes, description) VALUES(%s, %s, %s, %s, %s);'''
    cur.execute(query, info)
    query2 = '''
        INSERT INTO venmo_transaction(trans_id, receiver_username,
                    is_payment) VALUES(%s, %s, %s)'''
    info2 = [trans_id, receiver, "TRUE"]
    cur.execute(query2, info2)

    queryBal = '''SELECT balance FROM venmo_user WHERE username = %s'''
    infoBal = [sender]
    cur.execute(queryBal,infoBal)
    rows = cur.fetchall()
    balance = rows[0][0]
    above_zero = (float(balance) - amount) > 0

    query3 = '''
        UPDATE venmo_user SET balance = balance + %s WHERE username = %s'''
    info3 = [amount, receiver]
    cur.execute(query3, info3)
    query4 = ""
    if above_zero:
        query4 = '''
        UPDATE venmo_user SET balance = balance - %s WHERE username = %s'''
        cur.execute(query4, [amount, sender])
    else:
        query4 = '''
        UPDATE venmo_user SET balance = 0 WHERE username = %s'''
        cur.execute(query4, [sender])


def trans_count():
    query = '''SELECT * FROM Transaction'''
    count = 0;
    cur.execute(query)
    rows = cur.fetchall()
    for row in rows:
        count += 1
    return count



# We leverage the fact that in Python functions are first class
# objects and build a dictionary of functions numerically indexed 

actions = { 
            1:pay_friend_menu,
            }



if __name__ == '__main__':
    try:
        # default database and user
        db, user = 'venmo', 'isdb16'
        # you may have to adjust the user 
        # python a4-socnet-sraja.py a4_socnet postgres
        if len(sys.argv) >= 2:
            db = sys.argv[1]
        if len(sys.argv) >= 3:
            user = sys.argv[2]
        # by assigning to conn and cur here they become
        # global variables.  Hence they are not passed
        # into the various SQL interface functions
        conn = psycopg2.connect(database=db, user=user)
        conn.autocommit = True
        cur = conn.cursor()
        show_menu()
    except psycopg2.Exception as e:
        print("Unable to open connection: %s" % (e,))
