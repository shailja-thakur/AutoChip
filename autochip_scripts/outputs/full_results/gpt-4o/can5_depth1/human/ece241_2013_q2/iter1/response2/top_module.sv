module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Corrected Sum-of-Products (SOP)
    assign out_sop = (~a & b & ~c & d) | 
                     (a & b & c & d) | 
                     (~a & b & c & c);

    // Corrected Product-of-Sums (POS)
    assign out_pos = (~a | ~b | ~c | ~d) &
                     (~a | b | ~c | d) & 
                     (a | ~b | ~c | d) & 
                     (a | b | ~c | d);

endmodule
