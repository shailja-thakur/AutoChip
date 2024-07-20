module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Declare a wire to store the reversed vector
	wire [7:0] reversed_vector;
	
	// Reverse the bit ordering of the input vector
	assign reversed_vector = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
	
	// Assign the reversed vector to the output
	assign out = reversed_vector;

endmodule
