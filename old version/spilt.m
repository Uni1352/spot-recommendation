function [trainset, testset] = spilt(dataPath, spiltPercentage, random)
    % read dataset
    ratings = readmatrix(dataPath, "OutputType", "string");

    % spilt dataset to training set & testing set
    userIds = str2double(ratings(:, 1)) % 所有使用者
    userIdSet = unique(userIds)
    testsetIndex = []

    for id = [1:length(userIdSet)]
        firstIndex = find(userIds == id, 1, "first") % 起始索引值
        lastIndex = find(userIds == id, 1, "last") % 結束索引值
        indexList = [firstIndex:lastIndex]
        pos = round((lastIndex - firstIndex + 1) * spiltPercentage) % 資料分割點

        if random ~= 0
            indexList = indexList(randperm(length(indexList)))
        end

        testsetIndex = [testsetIndex, sort(indexList(pos:lastIndex))]
    end

    testset = ratings(testsetIndex, :)
    ratings(testsetIndex, :) = []
    trainset = ratings

    writematrix(trainset, 'train.csv')
    writematrix(testset, 'test.csv')
end
