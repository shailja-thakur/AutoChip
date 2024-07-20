module top_module (
	input [4:1] x,
	output logic f
);

// Define the truth table for the function f
logic [15:0] truth_table = 16'b1000100000110101;

// Use the truth table to implement the function f
assign f = truth_table[x];

endmodule
