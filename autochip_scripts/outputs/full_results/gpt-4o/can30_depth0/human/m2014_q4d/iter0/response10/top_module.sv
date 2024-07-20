module top_module (
	input clk,
	input in,
	output logic out
);

	// Internal wire to connect XOR output to D input of flip-flop
	wire xor_out;

	// XOR gate: Takes 'in' and 'out' (which is also the Q output of flip-flop)
	assign xor_out = in ^ out;

	// D flip-flop: Positive edge triggered
	always_ff @(posedge clk) begin
		out <= xor_out;
	end

endmodule
