function model(dataset)
    globalMeanRate = sum(dataset(:, 3)) / length(dataset(:, 3)) % global mean rate
    userIds = unique(str2double(dataset(:, 1))) % all users
    spotIds = unique((dataset(:, 2))) % all spot

    % invoke ALS method
    [bu, bi] = als(dataset, globalMeanRate, userIds, spotIds, 10, 25, 15)
end
