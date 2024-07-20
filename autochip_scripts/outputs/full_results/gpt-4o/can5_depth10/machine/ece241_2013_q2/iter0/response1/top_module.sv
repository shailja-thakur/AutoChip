module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    // Intermediate signals for SOP and POS
    wire sop_and_1, sop_or;
    wire pos0, pos1;
    
    // SOP expression
    assign sop_and_1 = c & d;
    assign sop_or = (~a & ~b & c) | sop_and_1;
    assign out_sop = sop_or;
    
    // POS expression
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
