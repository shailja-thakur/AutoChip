module top_module (
	input [4:1] x,
	output logic f
);

// Declare intermediate signals
logic d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15;

// Compute outputs based on input values
assign d0 = ~x[4] & ~x[3] & ~x[2] & ~x[1];
assign d1 = ~x[4] & ~x[3] & ~x[2] & x[1];
assign d2 = ~x[4] & ~x[3] & x[2] & ~x[1];
assign d3 = ~x[4] & ~x[3] & x[2] & x[1];
assign d4 = ~x[4] & x[3] & ~x[2] & ~x[1];
assign d5 = ~x[4] & x[3] & ~x[2] & x[1];
assign d6 = ~x[4] & x[3] & x[2] & ~x[1];
assign d7 = ~x[4] & x[3] & x[2] & x[1];
assign d8 = x[4] & ~x[3] & ~x[2] & ~x[1];
assign d9 = x[4] & ~x[3] & ~x[2] & x[1];
assign d10 = x[4] & ~x[3] & x[2] & ~x[1];
assign d11 = x[4] & ~x[3] & x[2] & x[1];
assign d12 = x[4] & x[3] & ~x[2] & ~x[1];
assign d13 = x[4] & x[3] & ~x[2] & x[1];
assign d14 = x[4] & x[3] & x[2] & ~x[1];
assign d15 = x[4] & x[3] & x[2] & x[1];

// Compute f based on the Karnaugh map
assign f = d0 | d3 | d4 | d5 | d7 | d8 | d9 | d10 | d11 | d14 | d15;

endmodule
