module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	
    // SOP form
    wire sop1 = a & ~b & ~c & ~d;
    wire sop2 = ~a & b & ~c & ~d;
    wire sop3 = ~a & ~b & ~c & d;

    assign out_sop = sop1 | sop2 | sop3;

    // POS form
    wire pos1 = a | b | ~c | ~d;
    wire pos2 = ~a | ~b | ~c | ~d;
    wire pos3 = ~a | ~b | c | d;

    assign out_pos = pos1 & pos2 & pos3;

endmodule
