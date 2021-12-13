function [trainset, testset] = spilt(dataPath, spiltPercentage, random)
    % read dataset
    ratings = readmatrix(dataPath, "OutputType", "string");

    % spilt dataset to training set & testing set
    userIds = str2double(ratings(:, 1)) % 所有使用者
    trainsetIndex = []
    start = 1; % 起始索引值

    for id = [1:length(unique(userIds))]
        last = find(userIds == id, 1, "last")
        index = [start:last]
        pos = round((last - start + 1) * spiltPercentage) % 資料分割點

        if random ~= 0
            index = index(randperm(length(index)))
        end

        trainsetIndex = [trainsetIndex, sort(index(1:pos))]
        start = last + 1
    end

    trainset = ratings(trainsetIndex, :)
    ratings(trainsetIndex, :) = []
    testset = ratings

    writematrix(trainsetIndex, 'trainset.csv')
    writematrix(trainset, 'train.csv')
    writematrix(testset, 'test.csv')
end
