module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Intermediate wires
wire w1, w2, w3, w4, w5, w6, w7;

// SOP expression
assign w1 = c & d;
assign w2 = ~a & ~b & c;
assign out_sop = w1 | w2;

// POS expression
assign w3 = c & (~b | d);
assign w4 = (~a | b) & (~a | ~d);
assign w5 = w3 & w4;

assign w6 = ~a & d;
assign w7 = w5 & w6;

assign out_pos = (w5 == w7) ? w5 : 1'bx;

endmodule
