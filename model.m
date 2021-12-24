% 3. 模型訓練
for i = [1:iter]
    % calculate bu
    for j = [1:length(unique(users))]
        totalU = 0;
        ratedSpots = trainset(users == j, [2, 3]);

        for k = [1:length(ratedSpots(:, 1))]
            indexU = find(spots == ratedSpots(k, 1)); % spotId 對應的索引值
            ratingU = str2double(ratedSpots(k, 2)); % 景點的評分
            totalU = totalU + ratingU - globalMeanRate - bi(indexU);
        end

        bu(j) = totalU / (buReg + length(ratedSpots));
    end

    % calculate bi
    for j = [1:length(spots)] % spotId 對應的索引值
        totalS = 0;
        ratedUsers = str2double(trainset(trainset(:, 2) == spots(j), [1, 3]));

        for k = [1:length(ratedUsers(:, 1))]
            indexS = k;
            ratingS = ratedUsers(k, 2);
            totalS = totalS + ratingS - globalMeanRate - bu(indexS);
        end

        bi(j) = totalS / (biReg + length(ratedUsers));
    end

end

writematrix(bu,'bu.csv');
writematrix(bi,'bi.csv');
