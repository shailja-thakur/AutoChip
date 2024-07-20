module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// out_sop: Minimum Sum-of-Products form
assign out_sop = (~a & ~b & ~c & d)  // 2
                | (a & b & ~c & d)  // 7
                | (a & b & c & d);   // 15

// out_pos: Minimum Product-of-Sums form
assign out_pos = ((~a) | (~b) | (~c) | d)    // 2
                 & (a | b | (~c) | (~d))    // 7
                 & (a | b | c | d);         // 15

endmodule
