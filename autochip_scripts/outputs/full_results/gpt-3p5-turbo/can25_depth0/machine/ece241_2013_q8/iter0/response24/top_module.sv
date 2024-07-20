module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State parameter
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_t;

	// Registers for state and next_state
	reg state_t state_reg, next_state_reg;
	
	// Register for output z
	reg z_reg;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			// Asynchronous reset
			state_reg <= S;
			z_reg <= 0;
		end else begin
			// State transition logic
			state_reg <= next_state_reg;
			z_reg <= (state_reg == S10) ? x : 0;
		end
	end

	always @* begin
		// Next state logic
		case (state_reg)
			S: begin
				if (x == 1)
					next_state_reg = S1;
				else
					next_state_reg = S;
			end
			S1: begin
				if (x == 0)
					next_state_reg = S10;
				else
					next_state_reg = S1;
			end
			S10: begin
				if (x == 1)
					next_state_reg = S1;
				else
					next_state_reg = S;
			end
			default: next_state_reg = S;
		endcase
	end

	assign z = z_reg;

endmodule
