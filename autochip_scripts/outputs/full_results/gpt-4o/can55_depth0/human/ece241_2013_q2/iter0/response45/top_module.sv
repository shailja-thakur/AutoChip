module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products (SOP): out_sop = 1 when 2, 7, or 15
    // 2:  a'b'cd
    // 7:  abcd
    // 15: abcd

    assign out_sop = (~a & ~b & c & d) | (a & b & c & d);

    // Product of Sums (POS): turns the valid zero conditions into product-of-sums
    // 0:  a'b'c'd'
    // 1:  a'b'c'd
    // 4:  a'bcd'
    // 5:  a'bcd
    // 6:  abc'd
    // 9:  ab'cd'
    // 10: ab'cd
    // 13: a'b'cd'
    // 14: ab'cd

    assign out_pos = (a | b | c | ~d) & (a | b | ~c | d) & (a | b | ~c | ~d) & (a | ~b | c | d) & 
                     (a | ~b | ~c | d) & (a | ~b | ~c | ~d) & (~a | ~b | c | d) & (a | b | c | d);

endmodule
