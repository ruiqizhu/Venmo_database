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
3. Comment on a transaction 

Choose (3, 0 to quit): '''

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
        elif choice in range(3,3+1):
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
# 3. Comment on a transaction
#------------------------------------------------------------
def comment_trans_menu():
    heading("Commenting on a transaction")
    trans_id = input("Enter the ID of the transaction you want to comment on ")
    username = input("Enter your username ")
    comment = input("Leave your comment ")
    comment_id = comment_count() + 1
    query = '''
        INSERT INTO comment(comment_id, trans_id, comment_text, 
                    commentor_username) VALUES(%s, %s, %s, %s)'''
    info = [comment_id, trans_id, comment, username]
    cur.execute(query, info)

def comment_count():
    query = '''SELECT * FROM Comment'''
    count = 0;
    cur.execute(query)
    rows = cur.fetchall()
    for row in rows:
        count += 1
    return count


# We leverage the fact that in Python functions are first class
# objects and build a dictionary of functions numerically indexed 

actions = { 
            3:comment_trans_menu,
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
