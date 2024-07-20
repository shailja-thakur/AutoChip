module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal wire to connect XOR output to D flip-flop input
	wire xor_out;

	// XOR gate
	assign xor_out = in ^ out;

	// D flip-flop
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
