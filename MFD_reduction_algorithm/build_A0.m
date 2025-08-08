function A0 = build_A0(l)
    
    A0 = [];
    for curr_grade = l
        Ji = diag(ones(curr_grade-1,1),+1);
        A0 = blkdiag(A0,Ji);
    end
end

