module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // Calculate SOP output
    wire and_cd, and_notab_c, sop_res1, sop_res2;
    
    // Intermediate signals for SOP
    assign and_cd = c & d;
    assign and_notab_c = (~a & ~b & c);
    
    // ORing the intermediate results
    assign out_sop = and_cd | and_notab_c;

    // Calculate POS output
    wire or_notb_d, or_nota_b, or_nota_d, and_c_or_rb, and_c_or_rd, pos0, pos1;

    // Intermediate signals for POS
    assign or_notb_d = ~b | d;
    assign or_nota_b = ~a | b;
    assign or_nota_d = ~a | d;
    
    // ANDing the intermediate results
    assign pos0 = c & or_notb_d & or_nota_b;
    assign pos1 = c & or_notb_d & or_nota_d;
    
    // Final POS output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
