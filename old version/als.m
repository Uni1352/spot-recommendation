function [bu, bi] = als(dataset, mean, uids, sids, iter, buReg, biReg)
    % initialize bu, bi
    bu = zeros(1, length(uids))
    bi = zeros(1, length(sids))

    for i = [1:iter] % 迭代
        % calculate bu
        for uid = uids
            total = 0
            ratedSpots = dataset(dataset(:, 1) == uid, [2, 3])

            for sid = ratedSpots(:, 1)
                index = find(sids == sid) % spotId 對應的索引值
                rating = ratedSpots(ratedSpots(:, 1) == sid, 2) % 景點的評分
                total = total + rating - mean - bi(index)
            end

            bu(uid) = total / (buReg + length(sids))

        end

        % calculate bi
        for sid = [1:length(sids)]
            total = 0
            ratedUsers = dataset(dataset(:, 2) == sid, [1, 3])

            for uid = ratedUsers(:, 1)
                index = find(uids == uid)
                rating = ratedUsers(ratedUsers(:, 1) == uid, 2)
                total = total + rating - mean - bu(index)
            end

            bi(sid) = total / (biReg + length(uids))

        end

    end

end
