module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    // Intermediate wires
    wire and_cd;
    wire and_nand_n_b_c;
    wire pos0, pos1;
    
    // SOP computation
    assign and_cd = c & d;
    assign and_nand_n_b_c = ~a & ~b & c;
    assign out_sop = and_cd | and_nand_n_b_c;
    
    // POS computation
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;
endmodule
