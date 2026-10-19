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
            
    def get_report(self):
        last_run = self._get_last_run()
        query = text("SELECT * FROM trigger_report WHERE id > :last_run")

        with self.engine.connect() as conn:
            df = pd.read_sql(query, conn, params={"last_run": last_run})
            return df

a = System()

print(a.get_report())
