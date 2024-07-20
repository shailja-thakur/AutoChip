module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire pos0, pos1;
    
    wire sop1, sop2;
    wire pos1_eq_pos0;
    
    // SOP expressions
    assign sop1 = ~a & ~b & c;
    assign sop2 = c & d;
    assign out_sop = sop1 | sop2;
    
    // POS expressions
    assign pos0 = c & (~b | d);
    assign pos1 = c & (~a | b);
    
    assign pos1_eq_pos0 = (pos1 == pos0);
    assign out_pos = pos1_eq_pos0 ? pos0 : 1'bx;

endmodule
