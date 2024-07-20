module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	// Define flip-flop
	reg q_reg;

	always @(posedge clk) begin
		// Update flip-flop
		q_reg <= q_reg | (a & ~b);
	end

	// Assign outputs
	assign q = q_reg;
	assign state = q_reg;

endmodule
