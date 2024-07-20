module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Compute the Sum-of-Products (SOP)
    assign out_sop = (c & d) | ((~a) & (~b) & c);

    // Compute intermediate values for Product-of-Sums (POS)
    wire pos0, pos1;
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~a) | d);

    // Compute the final out_pos output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
    
endmodule
