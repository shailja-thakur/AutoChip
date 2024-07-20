module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate signal for XOR result
	logic xor_result;

	// Two-input XOR
	assign xor_result = in ^ out;

	// D flip-flop
	always_ff @(posedge clk) begin
		out <= xor_result;
	end
endmodule
