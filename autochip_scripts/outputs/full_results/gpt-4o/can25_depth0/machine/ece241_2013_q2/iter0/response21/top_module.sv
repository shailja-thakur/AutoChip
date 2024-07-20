module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Implementing the Sum-of-Products (SOP) expression
    assign out_sop = (c & d) | ((~a & ~b) & c);

    // Wires for intermediate Product-of-Sums (POS) calculations
    wire pos0, pos1;

    // Logic for POS expressions
    assign pos0 = c & ((~b) | d) & (~a | b);
    assign pos1 = c & ((~b) | d) & (~a | d);

    // Final POS output with a ternary condition
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
    
endmodule
