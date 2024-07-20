module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define intermediate signals
wire w1, w2, w3, w4, w5, w6, w7, w8, w9;

// Compute intermediate signals
assign w1 = (a & b & c & d);   // When 15 appears on the inputs
assign w2 = (a & b & ~c & ~d); // When 2 appears on the inputs
assign w3 = (a & ~b & ~c & ~d); // When 7 appears on the inputs

assign w4 = (a | b | c | d);   // When 0 appears on the inputs
assign w5 = (~a & b & c & ~d); // When 1 appears on the inputs
assign w6 = (~a & b & c & d);  // When 4 appears on the inputs
assign w7 = (~a & b & ~c & d); // When 5 appears on the inputs
assign w8 = (~a & b & ~c & ~d); // When 6 appears on the inputs
assign w9 = (~a & ~b & ~c & d); // When 9 appears on the inputs
assign out_sop = !w4 & !w5 & !w6 & !w7 & !w8 & !w9 & w1 & w2 & w3; // Output in minimum sum-of-products form
assign out_pos = w4 | w5 | w6 | w7 | w8 | w9 | !w1 | !w2 | !w3; // Output in minimum product-of-sums form

endmodule
