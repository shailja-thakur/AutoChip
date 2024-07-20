module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare intermediate signals
	reg [99:0] in_shifted_reg; // Changed wire to reg

	// Create the shifted input
	always @(*) begin // Added always block
		in_shifted_reg[0] = in[99];
		for (i = 1; i < 100; i = i + 1) begin
			in_shifted_reg[i] = in[i-1];
		end
	end

	wire [99:0] in_shifted; // Moved the declaration here

	assign in_shifted = in_shifted_reg; // Removed curly braces

	// Compute out_both
	assign out_both = in[98:0] & in_shifted[98:0];

	// Compute out_any
	assign out_any = in_shifted[99:0] | in[0];

	// Compute out_different
	assign out_different = in ^ in_shifted;

endmodule
