module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Sum-of-Products form (Minimum form): out_sop
    assign out_sop = (a & b & ~c & d) | (~a & b & c & d) | (a & b & c & d);

    // Product-of-Sums form (Minimum form): out_pos
    assign out_pos = (~a | ~b | ~d) & (~a | ~c | ~d) & (~b | ~c | ~d) & (a | b | c);

endmodule
