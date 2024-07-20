module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Minimized sum-of-products form
    assign out_sop = (~a & ~b & c & ~d) | // 2
                     (~a & b & c & d)   | // 7
                     (a & b & c & d);   // 15
    
    // Minimized product-of-sums form
    assign out_pos = (~a | ~b | ~c) & (d | ~c | a) & (~b | c | ~d) & (b | ~c | d);
    
endmodule
