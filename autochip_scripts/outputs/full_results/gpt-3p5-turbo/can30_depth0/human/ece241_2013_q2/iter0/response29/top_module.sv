module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define the internal wires
wire w1, w2, w3, w4;

// Determine the output out_sop in minimum sum-of-products form
assign w1 = a & ~b & ~c & ~d;   // condition for 2
assign w2 = ~a & b & ~c & ~d;   // condition for 7
assign w3 = ~a & ~b & ~c & ~d;  // condition for 15

assign out_sop = w1 | w2 | w3;  // output is 1 if any of the conditions are satisfied

// Determine the output out_pos in minimum product-of-sums form
assign w4 = a | b | c | d;    // condition for any number other than 3, 8, 11, and 12

assign out_pos = ~w4;   // output is 0 if any of the conditions are satisfied

endmodule
