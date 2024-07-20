module top_module (
	input [4:1] x,
	output logic f
);

// Implementing the boolean expression for the function f
assign f = (x[3] & x[4]) | (x[3] & x[1]) | (x[2] & x[3]) | (x[1] & ~x[2]);

endmodule
