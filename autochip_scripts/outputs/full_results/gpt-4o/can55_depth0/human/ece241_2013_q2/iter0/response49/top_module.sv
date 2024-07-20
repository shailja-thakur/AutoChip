module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimum Sum-Of-Products Form (SOP)
    // out_sop = (a'b'cd) + (ab'cd) + (abcd)
    assign out_sop = (~a & ~b & c & d) | (a & ~b & c & d) | (a & b & c & d);

    // Minimum Product-Of-Sums Form (POS)
    // out_pos = (a + b + ~c) & (a + ~c + ~d) & (~a + b + ~c) & (~a + b + ~d)
    assign out_pos = (a | b | ~c) & (a | ~c | ~d) & (~a | b | ~c) & (~a | b | ~d);

endmodule
