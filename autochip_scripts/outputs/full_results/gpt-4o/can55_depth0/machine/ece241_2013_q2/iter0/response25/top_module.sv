module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // SOP expression: (c & d) | ((~a & ~b) & c)
    assign out_sop = (c & d) | ((~a & ~b) & c);
    
    // POS expression wires
    wire pos0, pos1;
    
    // pos0 calculation: c & ((~b | d) & (~a | b))
    assign pos0 = c & ((~b | d) & (~a | b));
    
    // pos1 calculation: c & ((~a | d) & (~a | b))
    assign pos1 = c & ((~a | d) & (~a | b));
    
    // out_pos assignment
    assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
