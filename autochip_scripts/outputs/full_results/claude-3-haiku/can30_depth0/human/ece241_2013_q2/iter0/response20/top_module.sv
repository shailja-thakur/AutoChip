module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // out_sop in minimum sum-of-products form
    assign out_sop = (~a & ~b & ~c & ~d) // 0
                  | (a & b & ~c & ~d) // 2
                  | (a & b & c & d); // 15

    // out_pos in minimum product-of-sums form
    assign out_pos = (~a | ~b | c | d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                   & (a | ~b | ~c | ~d) // 2, 7, 15
                   | (a & b & c & d); // 15

endmodule
