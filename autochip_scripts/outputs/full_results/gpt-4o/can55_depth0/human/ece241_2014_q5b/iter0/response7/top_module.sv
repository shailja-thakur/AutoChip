module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding using one-hot
	reg state_A, state_B;

	// State transition on clock edge or asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state_A <= 1'b1; // Reset to state A
			state_B <= 1'b0;
		end else begin
			if (state_A) begin
				if (x == 1'b1) begin
					state_A <= 1'b0;
					state_B <= 1'b1;
				end
				// state_A <= 1'b1; // Remain in state A if x == 0
			end else if (state_B) begin
				// state_B remains in state_B regardless of x
			end
		end
	end

	// Output logic
	always @(*) begin
		if (state_A) begin
			z = x;
		end else if (state_B) begin
			z = ~x;
		end
	end
	
endmodule
