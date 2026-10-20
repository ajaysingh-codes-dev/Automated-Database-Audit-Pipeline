# work in progress

import pandas as pd
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os
import json

load_dotenv()

class System:
    def __init__(self):
        self.my_sql_password = os.getenv("MySQL_PASSWORD")
        self.engine = create_engine(f"mysql+mysqlconnector://root:{self.my_sql_password}@localhost/ecommerce_audit")

    def _get_last_run(self):
        with self.engine.connect() as conn:
            last_run = conn.execute(text("SELECT COALESCE(MAX(last_audit_id), 0) FROM last_report")).scalar_one_or_none()
            return last_run
            
    def _get_report(self):
        last_run = self._get_last_run()
        query = text("SELECT * FROM trigger_report WHERE id > :last_run")

        with self.engine.connect() as conn:
            df = pd.read_sql(query, conn, params={"last_run": last_run})
            old_data = pd.DataFrame(df["old_data"].fillna("{}").apply(json.loads).tolist())
            new_data = pd.DataFrame(df["new_data"].fillna("{}").apply(json.loads).tolist())

            return df, old_data, new_data, last_run

    def create_reprot(self):

        df, old_data, new_data, last_run = self._get_report()

        if df.empty:
            print(f"NO new audit from {last_run}")

        print(f"----- Audit summary report -----\n")

        total_record = df['id'].count()
        group_record = df.groupby("action_type")["id"].count()

        for action, taken in group_record.items():
            print(f"Total {action} operations: {taken}\n")

        print(f"Total audit events: ({total_record})\n")

        print(f"--- A sort summary of report ---")
        print(df[["id", "record_id", "customer_name", "change_time", "action_type"]].to_string(index=False))
        
a = System()

a.create_reprot()