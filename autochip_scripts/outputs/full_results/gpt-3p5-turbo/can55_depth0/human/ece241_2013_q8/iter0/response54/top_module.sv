module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define states
	typedef enum logic [1:0] {S0, S1, S2} state_t;
	state_t current_state, next_state;

	// Define inputs and outputs
	reg x_reg;

	// Create the state transition and output logic
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			current_state <= S0;
		end else begin
			current_state <= next_state;
		end
	end

	// Create the next state and output logic
	always_comb begin
		case (current_state)
			S0: begin
				x_reg <= x;
				if (x_reg == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
				z <= 0;
			end
			S1: begin
				x_reg <= x;
				if (x_reg == 1'b0) begin
					next_state = S2;
				end else if (x_reg == 1'b1) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
				z <= 0;
			end
			S2: begin
				x_reg <= x;
				if (x_reg == 1'b1) begin
					next_state = S2;
				end else if (x_reg == 1'b0) begin
					next_state = S1;
					z <= 0;
				end else begin
					next_state = S0;
					z <= 0;
				end
				if (x_reg === 'b101) begin
					z <= 1;
				end
			end
			default: begin
				next_state = S0;
				z <= 0;
			end
		endcase
	end
endmodule
