from os import error
import pandas as pd
import numpy as np

pred_result_1 = pd.read_csv(r'./1/predict_result.csv', header=None)
pred_result_5 = pd.read_csv(r'./5/predict_result.csv', header=None)
pred_result_10 = pd.read_csv(r'./10/predict_result.csv', header=None)
pred_result_20 = pd.read_csv(r'./20/predict_result.csv', header=None)
testset = pd.read_csv(r'./test.csv', header=None)

diff_1 = (testset[2].values - pred_result_1[0].values)
diff_5 = (testset[2].values - pred_result_5[0].values)
diff_10 = (testset[2].values - pred_result_10[0].values)
diff_20 = (testset[2].values - pred_result_20[0].values)

square_mean = [sum(diff_1**2)/len(diff_1), sum(diff_5**2)/len(diff_5),
               sum(diff_10**2)/len(diff_10), sum(diff_20**2)/len(diff_20)]

rmse = [round(val**(0.5), 7) for val in square_mean]

print(rmse)
