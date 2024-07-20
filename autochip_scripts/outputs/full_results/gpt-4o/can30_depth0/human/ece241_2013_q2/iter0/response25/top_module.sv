module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP (Sum Of Products) form
    assign out_sop = (~a & ~b & c & d) | (~a & b & c & d) | (a & b & c & d); // 2, 7, 15

    // POS (Product Of Sums) form
    assign out_pos = (a | ~b | ~c) & (a | ~c | ~d) & (~a | ~b | ~d) & (~a | ~c | d); // 0, 1, 4, 5, 6, 9, 10, 13, 14

endmodule
