module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    wire and_cd, and_notab_c, or1, pos0, pos1;

    // SOP expression
    assign and_cd = c & d;
    assign and_notab_c = (~a) & (~b) & c;
    assign out_sop = and_cd | and_notab_c;
    
    // POS expression
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~b) | d) & ((~a) | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
