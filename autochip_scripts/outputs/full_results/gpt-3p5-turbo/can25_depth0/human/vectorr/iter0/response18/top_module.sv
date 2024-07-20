module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Declare internal signal
	wire [7:0] reversed;

	// Reverse bit ordering
	assign reversed = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};

	// Assign reversed signal to output
	assign out = reversed;

endmodule
