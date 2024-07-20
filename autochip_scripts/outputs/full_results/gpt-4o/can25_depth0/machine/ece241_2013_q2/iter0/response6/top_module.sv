module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Sum-of-Products (SOP) expression
    assign out_sop = (c & d) | (~a & ~b & c);
    
    // Wires for intermediate POS calculations
    wire pos0, pos1;
    
    // Product-of-Sums (POS) expression
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);
    
    // Assign out_pos based on pos0 and pos1
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
