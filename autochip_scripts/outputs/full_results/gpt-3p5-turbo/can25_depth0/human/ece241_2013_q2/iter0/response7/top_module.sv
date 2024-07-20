module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);
	// Define internal wires for intermediate calculations
	wire w1, w2, w3, w4, w5, w6, w7;

	// Calculate intermediate wires
	and w1 (w1, a, b, c, d);     // w1 = a & b & c & d
	and w2 (w2, a, ~b, c, d);    // w2 = a & ~b & c & d
	and w3 (w3, ~a, b, c, d);    // w3 = ~a & b & c & d
	and w4 (w4, ~a, ~b, c, d);   // w4 = ~a & ~b & c & d
	and w5 (w5, a, b, c, ~d);    // w5 = a & b & c & ~d
	and w6 (w6, a, ~b, c, ~d);   // w6 = a & ~b & c & ~d
	and w7 (w7, ~a, b, c, ~d);   // w7 = ~a & b & c & ~d

	// Calculate out_sop based on the given conditions
	assign out_sop = w1 | w2 | w3 | w4 | w5 | w6 | w7;    // out_sop = w1 OR w2 OR w3 OR w4 OR w5 OR w6 OR w7

	// Calculate out_pos based on the given conditions
	assign out_pos = w1 & w2 & w3 & w4 & w5 & w6 & w7;    // out_pos = w1 AND w2 AND w3 AND w4 AND w5 AND w6 AND w7

endmodule
