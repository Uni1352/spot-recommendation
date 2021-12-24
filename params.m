% 2. 模型參數
rates = str2double(trainset(:, 3)); % all rates
users = str2double(trainset(:, 1)); % all users
spots = unique(trainset(:, 2)); % all spots

bu = zeros(1, length(unique(users)));
bi = zeros(1, length(spots));
globalMeanRate = mean(rates); % global mean rate
