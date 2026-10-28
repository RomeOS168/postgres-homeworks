import json
import psycopg2
from config import config

def create_database(params, db_name):
    conn = psycopg2.connect(**params)
    conn.autocommit = True
    cur = conn.cursor()
    cur.execute(f"DROP DATABASE IF EXISTS {db_name};")
    cur.execute(f"CREATE DATABASE {db_name};")
    cur.close()
    conn.close()

def execute_sql_file(params, db_name, file_path):
    conn = psycopg2.connect(**params, database=db_name)
    cur = conn.cursor()
    with open(file_path, "r", encoding="windows-1251") as f:
        sql_script = f.read()
    cur.execute(sql_script)
    conn.commit()
    cur.close()
    conn.close()

def create_suppliers_table(params, db_name):
    conn = psycopg2.connect(**params, database=db_name)
    cur = conn.cursor()
    cur.execute("""CREATE TABLE suppliers (supplier_id SERIAL PRIMARY KEY, company_name VARCHAR(100) NOT NULL, contact_name VARCHAR(100), phone VARCHAR(50), homepage TEXT, products TEXT[]);""")
    conn.commit()
    cur.close()
    conn.close()

def fill_suppliers_table(params, db_name, json_path):
    conn = psycopg2.connect(**params, database=db_name)
    cur = conn.cursor()
    with open(json_path, "r", encoding="utf-8") as f:
        suppliers_data = json.load(f)
    for supplier in suppliers_data:
        cur.execute("""INSERT INTO suppliers (company_name, contact_name, phone, homepage, products) VALUES (%s, %s, %s, %s, %s);""", (supplier.get("company_name"), supplier.get("contact_name"), supplier.get("phone"), supplier.get("homepage"), supplier.get("products")))
    conn.commit()
    cur.close()
    conn.close()

def add_foreign_keys(params, db_name):
    conn = psycopg2.connect(**params, database=db_name)
    cur = conn.cursor()
    cur.execute("""ALTER TABLE products ADD COLUMN IF NOT EXISTS supplier_id INT;""")
    cur.execute("""ALTER TABLE products ADD CONSTRAINT fk_products_suppliers FOREIGN KEY (supplier_id) REFERENCES suppliers (supplier_id);""")
    conn.commit()
    cur.close()
    conn.close()

if __name__ == "__main__":
    db_params = config()
    target_db = "skypro_best_practices"
    create_database(db_params, target_db)
    execute_sql_file(db_params, target_db, "fill_db.sql")
    create_suppliers_table(db_params, target_db)
    fill_suppliers_table(db_params, target_db, "suppliers.json")
    add_foreign_keys(db_params, target_db)

