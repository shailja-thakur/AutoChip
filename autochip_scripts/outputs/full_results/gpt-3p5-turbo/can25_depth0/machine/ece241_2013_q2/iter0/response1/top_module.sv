module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Declare intermediate wires for computation
wire w1, w2, w3, pos0, pos1;

// Define the SOP expression for out_sop
assign out_sop = (c & d) | ((!a & !b & c));

// Define the POS expression for out_pos
assign pos0 = c & (!b | d) | (!a & b);
assign pos1 = c & (!a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
