module top_module (
	input [4:1] x,
	output logic f
);

// Define logic equations for each output bit
assign f = (~x[3] & x[4]) | (~x[1] & ~x[2]) | (x[1] & ~x[3]) | (x[2] & ~x[4]);

endmodule
