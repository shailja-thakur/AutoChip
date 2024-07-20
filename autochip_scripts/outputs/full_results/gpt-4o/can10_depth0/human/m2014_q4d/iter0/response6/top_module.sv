module top_module (
	input clk,
	input in,
	output logic out
);

	// XOR gate
	logic xor_out;
	assign xor_out = in ^ out;

	// D Flip-Flop
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
