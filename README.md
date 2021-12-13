# Taiwan Travel Recommendation

一個簡單的旅遊推薦

## Dataset

- 政府開放資料 Open Data: 觀光資訊資料庫
- MovieLens: 使用者評分 ratings.csv

## Recommendation Method

Model-based Collaborative Filtering: Baseline

## Files

- spilt.m: 資料切割
  - 每個使用者的資料都分成訓練部分與測試部分：8:2
- baselineCF.m: 模型
- sgd.m: SGD 演算法
- als.m: ALS 演算法
- predict.m: 評分預測
- recommend.m: 景點推薦
- accuracy.m: 準確性評估
