[trainset, testset] = spilt("./ratings.csv", 0.8, 0)
baselineCF(trainset)
