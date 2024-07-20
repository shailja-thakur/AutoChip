module top_module (
	input clk,
	input in,
	output logic out
);

	// XOR gate taking 'in' and 'out' as inputs
	logic xor_result;
	assign xor_result = in ^ out;

	// D flip-flop, positive edge triggered
	always_ff @(posedge clk) begin
		out <= xor_result;
	end

endmodule
