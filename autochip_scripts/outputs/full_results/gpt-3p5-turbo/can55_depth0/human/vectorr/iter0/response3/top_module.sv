module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Variable to store the reversed vector
	wire [7:0] reversed_vector;
	
	// Reverse the input vector
	assign reversed_vector = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};
	
	// Assign the reversed vector to the output
	assign out = reversed_vector;

endmodule
