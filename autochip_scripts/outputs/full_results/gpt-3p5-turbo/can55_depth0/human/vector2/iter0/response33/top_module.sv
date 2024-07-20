module top_module (
	input [31:0] in,
	output [31:0] out
);

	// Variable declaration
	wire [31:0] reversed;

	// Reversal logic
	assign reversed[31:24] = in[7:0];
	assign reversed[23:16] = in[15:8];
	assign reversed[15:8] = in[23:16];
	assign reversed[7:0] = in[31:24];

	// Output assignment
	assign out = reversed;

endmodule
