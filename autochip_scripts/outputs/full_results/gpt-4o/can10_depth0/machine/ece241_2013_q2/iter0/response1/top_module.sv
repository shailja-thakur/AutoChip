module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Intermediate signals for out_sop calculation
    wire and_cd = c & d;
    wire and_notab_c = (~a & ~b) & c;
    
    // Sum of Products (SOP) output
    assign out_sop = and_cd | and_notab_c;
    
    // Intermediate signals for out_pos calculation
    wire pos0 = c & ((~b | d) & (~a | b));
    wire pos1 = c & ((~b | d) & (~a | d));

    // Product of Sums (POS) output with ternary expression
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
