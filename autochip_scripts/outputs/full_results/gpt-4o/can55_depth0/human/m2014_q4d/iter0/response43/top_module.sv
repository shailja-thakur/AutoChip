module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate wire to hold the XOR result
	wire xor_result;

	// XOR Gate: Takes 'in' and 'out' as inputs
	assign xor_result = in ^ out;

	// D Flip-Flop: Positive edge triggered
	always_ff @(posedge clk) begin
		out <= xor_result;
	end

endmodule
