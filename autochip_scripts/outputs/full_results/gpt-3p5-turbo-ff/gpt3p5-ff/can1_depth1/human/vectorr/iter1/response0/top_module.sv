module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Define an intermediate wire to hold the reversed bits
	wire [7:0] reversed;

	// Reverse the bit ordering using for loop
	// Iterate from 0 to 7
	// Assign the value of in[i] to reversed[7-i]
		
	// Assign the reversed vector to the output
	assign reversed = {in[7], in[6], in[5], in[4], in[3], in[2], in[1], in[0]};
	assign out = reversed;

endmodule
