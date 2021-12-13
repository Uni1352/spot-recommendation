function [] = baselineCF(dataset)
    % global mean rate
    globalMeanRate = 0

    for i = keys(dataset)

        for j = keys(dataset(i))
            globalMeanRate = globalMeanRate + dataset(i, j)
        end

    end

    % all users' rates
    usersRatings = []

    for i = keys(dataset)
        usersRatings[i] = dataset(i)
    end

    % all rate the spot get
    spotsRatings = []

    % 調用 als 方法
