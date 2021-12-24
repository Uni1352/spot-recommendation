function predRate = predict(uid, sid, mean, sids, bu, bi)

    if ismember(sid, sids) == 0
        disp('spot not found.')
    else
        predRate = mean + bu(uid) + bi(sid)
    end

end
