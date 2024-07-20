module top_module (
	input clk,
	input in,
	output logic out
);

	// XOR gate
	wire xor_out;
	assign xor_out = in ^ out;

	// D flip-flop
	always @(posedge clk) begin
		out <= xor_out;
	end

endmodule
