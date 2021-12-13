import pandas as pd
import numpy as np
import json
import random

column_arr = ['Zone', 'Travellinginfo', 'Opentime', 'Picture1',
              'Picdescribe1', 'Picture2', 'Picdescribe2', 'Picture3', 'Picdescribe3',
              'Map', 'Gov', 'Orgclass', 'Class1', 'Class2', 'Class3',
              'Level', 'Website', 'Parkinginfo', 'Parkinginfo_Px', 'Parkinginfo_Py',
              'Ticketinfo', 'Remarks',  'Changetime']

# read data
# spots
with open('./dataset/spots.json', encoding='utf-8') as f:
    data = json.load(f)

spots = pd.json_normalize(data['XML_Head']['Infos']['Info'])
spots.drop(column_arr, axis=1, inplace=True)
spots[['Id', 'Name', 'Region', 'Add', 'Town', 'Px', 'Py']].to_csv(
    './spot.csv', index=False)
# users
ratings = pd.read_csv(r'./dataset/ml-latest-small/ratings.csv')
ratings.drop('timestamp', axis=1, inplace=True)

# generate user rating
user_rating = {
    'userId': [],
    'spotId': [],
    'rating': []
}
user_id = np.unique(ratings['userId'])
spot_id = list(spots['Id'])

for id in user_id:
    rating_count = len(ratings.loc[ratings['userId'] == id])
    random_spot_id = random.sample(range(len(spot_id)), rating_count)

    for i in range(len(random_spot_id)):
        user_rating['userId'].append(id)
        user_rating['spotId'].append(spot_id[random_spot_id[i]])
        user_rating['rating'].append(ratings.loc[i]['rating'])

df = pd.DataFrame(user_rating)
df.to_csv('./ratings.csv', index=False)
