module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // Generating out_sop
    wire and_cd;
    wire or_result;
    wire not_a;
    wire not_b;
    wire and_notab_c;
    
    assign and_cd = c & d;
    assign not_a = ~a;
    assign not_b = ~b;
    assign and_notab_c = not_a & not_b & c;
    assign or_result = and_cd | and_notab_c;
    assign out_sop = or_result;

    // Generating out_pos
    wire and_pos0;
    wire and_pos1;
    wire or_notb_d;
    wire or_nota_b;
    wire or_nota_d;
	
    assign or_notb_d = ~b | d;
    assign or_nota_b = ~a | b;
    assign or_nota_d = ~a | d;
    assign and_pos0 = c & or_notb_d & or_nota_b;
    assign and_pos1 = c & or_notb_d & or_nota_d;
    
    assign out_pos = (and_pos0 == and_pos1) ? and_pos0 : 1'bx;

endmodule
