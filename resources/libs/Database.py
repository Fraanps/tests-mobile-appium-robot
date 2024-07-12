import psycopg2

db_conn = f"""
    host='localhost'
    dbname='postgres'
    user='postgres'
    password='admin321$'
"""


def execute_query(query):
    conn = psycopg2.connect(db_conn)
    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    conn.close()


def insert_membership(data):

    account = data["account"]
    plan=data["plan"]
    credit_card = data["credit_card"]["number"][-4:] # pegando os 4 ultimos numeros do cartão

    query = f"""
        BEGIN; -- Inicia uma transação
    
        -- Remove o registro pelo email
        DELETE FROM public.accounts
        WHERE email = '{account["email"]}';
        
        -- Insere uma nova conta e obtém o ID da conta recém-inserida
        WITH new_account AS (
            INSERT INTO public.accounts (name, email, cpf)
            VALUES ('{account["name"]}', '{account["email"]}', '{account["cpf"]}')
            RETURNING id
        )
        
        -- Insere um registro na tabela memberships com o ID da conta
        INSERT INTO public.memberships (account_id, plan_id, credit_card, price, status)
        SELECT id, '{plan["id"]}', '{credit_card}', '{plan["price"]}', true
        FROM new_account;
        
        COMMIT; -- Confirma a transação
    """
    execute_query(query)


# usado para inserir uma conta
def insert_account(account):
    query = f"""
        insert into accounts(email, name, cpf)
        values('{account["email"]}', '{account["name"]}','{account["cpf"]}');
        """
    execute_query(query)


# usar para deletar uma conta
def delete_account_by_email(email):
    query = f"DELETE FROM accounts WHERE email = '{email}';"
    execute_query(query)