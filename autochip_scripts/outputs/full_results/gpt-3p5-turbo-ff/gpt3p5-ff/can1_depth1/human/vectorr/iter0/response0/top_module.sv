module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Define an intermediate wire to hold the reversed bits
	wire [7:0] reversed;

	// Reverse the bit ordering using for loop
	// Iterate from 0 to 7
	// Assign the value of in[i] to reversed[7-i]
	generate
		for (integer i = 0; i < 8; i = i+1) begin : reverse_loop
			assign reversed[7-i] = in[i];
		end
	endgenerate

	// Assign the reversed vector to the output
	assign out = reversed;

endmodule
