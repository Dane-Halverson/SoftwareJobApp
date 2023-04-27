import firebase_admin
from firebase_admin import firestore
import pandas as pd
from pathlib import Path
import re

credentials = firebase_admin.credentials.Certificate(str(Path(__file__).parent.joinpath('credentials.json')))
app = firebase_admin.initialize_app(credentials)
db = firestore.client()

def main():
    data_file = str(Path(__file__).parent.joinpath('data.csv'))
    df = pd.read_csv(data_file, index_col='City')
    df = df.loc[:, ~df.columns.str.contains('^Unnamed')]
    columns = [column for column in df.columns if 'City' not in column]
    for city in df.index:
        city_data = {re.sub(r'\((.*?)\)', '', column).strip(): df[column][city] for column in columns}
        doc_ref = db.collection(u'cities').document(city)
        doc_ref.set(city_data)
if __name__ == '__main__':
    main()