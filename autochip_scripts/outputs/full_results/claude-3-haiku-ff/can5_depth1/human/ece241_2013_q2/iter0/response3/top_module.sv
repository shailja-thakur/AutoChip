module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum sum-of-products form
    assign out_sop = (a & ~b & ~c & ~d) // 0
                  | (~a & b & ~c & ~d) // 1
                  | (~a & ~b & c & ~d) // 4
                  | (~a & ~b & ~c & d) // 5
                  | (~a & ~b & d & c)  // 6
                  | (~a & b & c & d)   // 9
                  | (a & ~b & c & d)   // 10
                  | (a & b & ~c & d)   // 13
                  | (a & b & c & ~d);  // 14

    // Minimum product-of-sums form
    assign out_pos = (~a | ~b | ~c) & (~a | ~b | d) & (~a | c | ~d) & (a | ~b | ~c | ~d);

endmodule
