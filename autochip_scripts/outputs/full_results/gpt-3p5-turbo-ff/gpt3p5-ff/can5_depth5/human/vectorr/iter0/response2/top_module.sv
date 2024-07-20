module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Declare an 8-bit wire to store the reversed value
	wire [7:0] reversed;

	// Assign the reversed value to the output wire
	assign out = reversed;

	// Reverse the input bit ordering
	assign reversed[0] = in[7];
	assign reversed[1] = in[6];
	assign reversed[2] = in[5];
	assign reversed[3] = in[4];
	assign reversed[4] = in[3];
	assign reversed[5] = in[2];
	assign reversed[6] = in[1];
	assign reversed[7] = in[0];

endmodule
