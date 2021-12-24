% 4. 測試
for i = [1:length(testset)]
    uid = str2double(testset(i, 1));
    sid = find(spots == testset(i, 2));

    if isempty(sid)
        disp('spot not found');
        predResult(i, :) = 0;
    else
        predResult(i, :) = globalMeanRate + bu(uid) + bi(sid);
    end

end

writematrix(predResult, 'predict_result.csv');

% 5. 模型評估
rmse = sqrt(mean((str2double(testset(:, 3)) - predResult).^2));
