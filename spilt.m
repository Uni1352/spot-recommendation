%  1. 資料切割
ratings = readmatrix('./ratings.csv', 'OutputType', 'string');

userIds = str2double(ratings(:, 1)); % 所有使用者
userIdSet = unique(userIds);
% spotIds = unique(ratings(:, 2)); % 所有景點
trainsetIndex = [];
testsetIndex = [];
spiltPercent = 0.8;

% 選出每個 user 的測試部分資料
for id = [1:length(userIdSet)]
    % indexes = find(userIds == id);
    firstIndex = find(userIds == id, 1, 'first'); % 起始索引值
    lastIndex = find(userIds == id, 1, 'last'); % 結束索引值

    indexes = [firstIndex:lastIndex];
    pos = round(length(indexes) * spiltPercent); % 資料分割點

    if random > 0
        indexes = indexes(randperm(length(indexes)));
        rows = sort(indexes(pos:end));
    else
        rows = indexes(pos:end);
    end

    testsetIndex = [testsetIndex, rows];
end

trainsetIndex = setdiff([1:length(ratings)], testsetIndex);

testset = ratings(testsetIndex, :);
% ratings(testsetIndex, :) = [];
trainset = ratings(trainsetIndex, :);

writematrix(trainset, 'train.csv');
writematrix(testset, 'test.csv');
