module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate SOP expression:
    wire temp1_sop, temp2_sop;
    assign temp1_sop = c & d;
    assign temp2_sop = (~a & ~b & c);
    assign out_sop = temp1_sop | temp2_sop;
    
    // Generate POS expression:
    wire pos0, pos1;
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
