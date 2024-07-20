module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate the sum-of-products form for the numbers specified: 2, 7, and 15
    // 2  => 0 1 0 0
    // 7  => 0 1 1 1
    // 15 => 1 1 1 1
    assign out_sop = (~a & b & ~c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Generate the product-of-sums form for the numbers specified: 0, 1, 4, 5, 6, 9, 10, 13, and 14
    // 0  => 0 0 0 0
    // 1  => 0 0 0 1
    // 4  => 0 1 0 0
    // 5  => 0 1 0 1
    // 6  => 0 1 1 0
    // 9  => 1 0 0 1
    // 10 => 1 0 1 0
    // 13 => 1 1 0 1
    // 14 => 1 1 1 0
    assign out_pos = (a | b | c | ~d) & (a | b | ~c | ~d) & (a | ~b | c | d) & (~a | b | ~c | ~d) &
                     (a | ~b | ~c | d) & (~a | b | c | d) & (~a | b | c | ~d);

endmodule
