module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Declare intermediate wire vectors
	wire [7:0] reversed;
	
	// Reverse the bit ordering
	assign reversed = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
	
	// Assign the reversed vector to the output
	assign out = reversed;
	
endmodule
