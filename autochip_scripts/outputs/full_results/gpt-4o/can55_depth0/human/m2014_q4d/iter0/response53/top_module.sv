module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate wire for the XOR output
	wire xor_out;

	// XOR gate
	assign xor_out = in ^ out;

	// Positive edge-triggered D flip-flop
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
