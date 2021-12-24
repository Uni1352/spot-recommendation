%  1. 資料切割
ratings = readMatrix('./ratings.csv', 'OutputType', 'string')

userIds = str2double(ratings(:, 1)) % 所有使用者
userIdSet = unique(userIds)
testsetIndex = []
spiltPercentage = 0.8
random = 1

for id = userIdSet
    firstIndex = find(userIds == id, 1, 'first') % 起始索引值
    lastIndex = find(userIds == id, 1, 'last') % 結束索引值
    indexList = [firstIndex:lastIndex]
    pos = round((lastIndex - firstIndex + 1) * spiltPercentage) % 資料分割點

    if random > 0
        indexList = index(randperm(length(indexList)))
    end

    testsetIndex = [testsetIndex, sort(index(pos:lastIndex))]
end

testset = ratings(testsetIndex, :)
ratings(testsetIndex, :) = []
trainset = ratings

writematrix(trainset, 'train.csv')
writematrix(testset, 'test.csv')

% 2. 參數定義
globalMeanRate = mean(trainset(:, 3)) % global mean rate
users = unique(str2double(trainset(:, 1))) % all users
spots = unique((trainset(:, 2))) % all spot
iter = 20
buReg = 25
biReg = 15

% 3. 模型訓練
bu = zeros(1, length(users))
bi = zeros(1, length(spots))

for i = [1:iter] % 迭代
    % calculate bu
    for uid = users
        total = 0
        ratedSpots = trainset(trainset(:, 1) == uid, [2, 3])

        for sid = ratedSpots(:, 1)
            index = find(spots == sid) % spotId 對應的索引值
            rating = ratedSpots(ratedSpots(:, 1) == sid, 2) % 景點的評分
            total = total + rating - mean - bi(index)
        end

        bu(uid) = total / (buReg + length(spots))
    end

    % calculate bi
    for sid = spots
        total = 0
        ratedUsers = dataset(dataset(:, 2) == sid, [1, 3])

        for uid = ratedUsers(:, 1)
            index = find(users == uid)
            rating = ratedUsers(ratedUsers(:, 1) == uid, 2)
            total = total + rating - mean - bu(index)
        end

        bi(sid) = total / (biReg + length(users))

    end

end

% TODO: 4. 測試
for i = [1:length(testset(:, 1))]
    uid = testset(i, 1)
    sid = testset(s, 1)

    if ismember(sid, spots) == 0
        disp('spot not found')
        predRate = 0
    else
        predRate = globalMeanRate + bu(uid) + bi(sid)
    end

    testset(i, 4) = predRate
end

% TODO: 5. 模型評估
% rmse = sqrt(sum((pred - true)^2),2)
rmse = sqrt(sum((testset(:, 4) - testset(:, 3)).^2), 2)
