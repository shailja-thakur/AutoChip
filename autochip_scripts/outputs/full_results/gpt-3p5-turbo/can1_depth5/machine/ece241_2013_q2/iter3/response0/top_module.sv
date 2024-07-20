module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire pos0, pos1;
    wire pos1_eq_pos0;
    reg out_pos_reg;
    
    // SOP expressions
    assign out_sop = (~a & ~b & c) | (c & d);
    
    // POS expressions
    assign pos0 = c & (~b | d);
    assign pos1 = c & (~a | b);
    
    // Ternary expression to assign out_pos
    assign out_pos_reg = (pos0 === pos1) ? pos0 : 1'bx;
    assign out_pos = out_pos_reg;
    
endmodule
