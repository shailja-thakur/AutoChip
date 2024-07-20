module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define states in one-hot encoding
	reg state_a, state_b;
	
	// Combinational logic to calculate next state and output
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset to state A
			state_a <= 1;
			state_b <= 0;
			z <= 0;
		end else begin
			// Update state and output based on current state and input x
			if (state_a) begin
				if (x) begin
					state_a <= 0;
					state_b <= 1;
					z <= 1;
				end else begin
					state_a <= 1;
					state_b <= 0;
					z <= 0;
				end
			end else if (state_b) begin
				if (x) begin
					state_a <= 0;
					state_b <= 1;
					z <= 0;
				end else begin
					state_a <= 0;
					state_b <= 1;
					z <= 1;
				end
			end
		end
	end

endmodule
