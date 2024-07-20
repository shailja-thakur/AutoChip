module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) expression
    assign out_sop = (a & ~b & ~c & ~d) // 0
                  | (~a & b & ~c & ~d) // 1
                  | (~a & ~b & c & ~d) // 4
                  | (~a & ~b & ~c & d) // 5
                  | (~a & ~b & c & d)  // 6
                  | (~a & b & c & d)   // 7
                  | (a & b & c & d);   // 15

    // Product-of-Sums (POS) expression
    assign out_pos = (~a | ~b | ~c | ~d) // 0, 1, 4, 5, 6, 9, 10, 13, 14
                   & (a | ~b | ~c | ~d) // 0, 2, 4, 8, 12, 13, 14, 15
                   & (~a | b | ~c | ~d) // 0, 1, 3, 5, 7, 9, 11, 13
                   & (~a | ~b | c | ~d); // 0, 1, 4, 6, 8, 9, 12, 13

endmodule
