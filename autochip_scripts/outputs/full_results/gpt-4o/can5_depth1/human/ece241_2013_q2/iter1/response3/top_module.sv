module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) for generating output out_sop
    // Minimization based on Karnaugh Map for SOP
    assign out_sop = (~a & ~b & c & ~d) | 
                     (~a & b & c & d) | 
                     (a & b & c & d) |
                     (a & b & ~c & d);

    // Product-of-Sums (POS) for generating output out_pos
    // Minimization based on Karnaugh Map for POS
    assign out_pos = (a | b | ~c | d) & 
                     (~a | b | ~c | d) & 
                     (~a | b | c | ~d) &
                     (a | ~b | ~c | d);

endmodule
