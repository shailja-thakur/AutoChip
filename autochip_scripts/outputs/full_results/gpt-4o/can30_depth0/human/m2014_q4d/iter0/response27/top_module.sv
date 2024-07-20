module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate signal for XOR result
	logic xor_out;

	// XOR operation
	assign xor_out = in ^ out;

	// D flip-flop: positive edge triggered
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
