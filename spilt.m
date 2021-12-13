function [trainset, testset] = spilt(dataPath, spiltPercentage)
    sprint("Dataset Spilting...");

    % read dataset
    fileId = fopen(dataPath, "r");
    % ratings = textscan(fileId, "%d%s%f", "Delimeter", ",", "HeaderLines", 1);
    [userId, spots, rate] = textscan(fileId, "%d%s%f", "Delimeter", ",", "HeaderLines", 1);
    fclose(fileId);

    % spilt dataset to training set & testing set
    trainset = MapNested();
    testset = MapNested();
    userIds = unique(userId);
    start = 1; % 起始索引值

    for id = userIds
        last = find(userId == id, 1, "last");
        pos = round((last - start + 1) * spiltPercentage); % 資料分割點
        currentIndex = start; % 目前索引值

        for spot = spots(start:last)

            if currentIndex <= pos
                trainset(user, spot) = rate(currentIndex);
            else
                testset(user, spot) = rate(currentIndex);
            end

            start = last + 1;

        end

    end

    sprint("Dataset Spilted!")

end
