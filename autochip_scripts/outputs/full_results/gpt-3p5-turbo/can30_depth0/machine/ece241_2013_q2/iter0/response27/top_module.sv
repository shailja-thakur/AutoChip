module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    wire pos0, pos1;
    
    // out_sop output generation
    assign out_sop = (c & d) | ((~a & ~b & c));
    
    // pos0 output generation
    assign pos0 = c & (~b | d) & (~a | b);
    
    // pos1 output generation
    assign pos1 = c & (~a | d);
    
    // out_pos output generation
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
endmodule
