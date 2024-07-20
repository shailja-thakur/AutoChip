module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-Of-Products form
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Minimum Product-Of-Sums form
    assign out_pos = (a | b | ~c) & (a | ~b | ~d) & (~a | ~b | ~c | ~d);

endmodule
