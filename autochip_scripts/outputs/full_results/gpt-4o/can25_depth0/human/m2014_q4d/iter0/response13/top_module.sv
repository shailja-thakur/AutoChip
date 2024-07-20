module top_module (
	input clk,
	input in,
	output logic out
);

	// Intermediate wire to hold the XOR output
	wire xor_out;

	// XOR gate: XOR the input 'in' with 'out' which is the output of the D flip-flop
	assign xor_out = in ^ out;

	// D flip-flop: Triggered on the positive edge of the clock
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
