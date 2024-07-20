module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// One-hot encoding states
	reg state_A, state_B;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Reset to state A
			state_A <= 1'b1;
			state_B <= 1'b0;
		end
		else begin
			// State transition logic
			if (state_A) begin
				if (x == 1'b0) begin
					state_A <= 1'b1;
					state_B <= 1'b0;
				end
				else begin
					state_A <= 1'b0;
					state_B <= 1'b1;
				end
			end
			else if (state_B) begin
				if (x == 1'b0) begin
					state_A <= 1'b0;
					state_B <= 1'b1;
				end
				else begin
					state_A <= 1'b0;
					state_B <= 1'b1;
				end
			end
		end
	end

	// Output logic
	always @(*) begin
		if (state_A && x == 1'b1) begin
			z = 1'b1;
		end else if (state_B && x == 1'b0) begin	
			z = 1'b1;
		end else begin
			z = 1'b0;
		end
	end
endmodule
