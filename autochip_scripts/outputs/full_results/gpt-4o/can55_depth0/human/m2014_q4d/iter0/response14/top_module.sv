module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal signal for the XOR output
	logic xor_out;

	// XOR gate
	assign xor_out = in ^ out;

	// D flip-flop with positive edge-triggered clock input
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
