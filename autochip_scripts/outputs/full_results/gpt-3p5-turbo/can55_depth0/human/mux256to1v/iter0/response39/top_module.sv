module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

	// Create registers for each set of 4-bit inputs
	reg [3:0] in_reg [255:0];

	// Assign the appropriate bits from the input vector to each register
	always @(in or sel) begin
		in_reg[0] <= in[3:0];
		in_reg[1] <= in[7:4];
		// Continue this pattern for all 256 registers
		// ...
		in_reg[254] <= in[1019:1016];
		in_reg[255] <= in[1023:1020];
	end

	// Assign the output based on the selected input
	assign out = in_reg[sel];

endmodule
