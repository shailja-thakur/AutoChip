module top_module (
	input [7:0] in,
	output parity
);

	// Internal signal for calculating parity
	reg parity_calculated;

	// XOR gate for calculating parity
	assign parity = parity_calculated;

	// Calculate parity
	always @(*) begin
		parity_calculated = in[7] ^ in[6] ^ in[5] ^ in[4] ^ in[3] ^ in[2] ^ in[1] ^ in[0];
	end

endmodule
