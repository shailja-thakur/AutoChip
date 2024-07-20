module top_module (
	input clk,
	input in,
	output logic out
);
	// Internal wire for XOR output
	wire xor_out;

	// XOR gate: takes 'in' and 'out' as inputs
	assign xor_out = in ^ out;

	// D flip-flop: captures 'xor_out' on the positive edge of the clock
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
