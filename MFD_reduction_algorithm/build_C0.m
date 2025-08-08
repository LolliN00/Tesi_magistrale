function C0 = build_C0(l)
    C0 = [];
    for curr_grade = l
        c_i = zeros(1,curr_grade);
        c_i(1) = 1;
        C0 = blkdiag(C0,c_i);
    end
end

