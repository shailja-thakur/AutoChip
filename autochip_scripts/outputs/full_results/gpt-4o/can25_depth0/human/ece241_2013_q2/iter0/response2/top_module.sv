module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-Of-Products (SOP) for generating logic-1 for 2, 7, and 15
    assign out_sop = (~a & ~b & c & ~d) | (a & b & c & ~d) | (a & b & c & d);

    // Minimum Product-Of-Sums (POS) for generating logic-1 for 2, 7, and 15
    assign out_pos = (~a | ~b | ~c | d) & (~a | b | ~c | ~d) & (a | b | c | ~d);

endmodule
