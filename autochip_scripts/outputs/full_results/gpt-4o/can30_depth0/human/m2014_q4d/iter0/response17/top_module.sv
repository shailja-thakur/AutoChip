module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate signal for XOR output
	logic xor_out;

	// XOR input 'in' with the current output 'out' of the flip-flop
	assign xor_out = in ^ out;

	// D flip-flop positive edge triggered by clk
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
