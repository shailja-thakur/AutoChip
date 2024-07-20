module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after seeing '1'
		S2 = 2'b10  // State after seeing '10'
	} state_t;

	state_t state, next_state;

	// State transition
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
		next_state = state; // default state transition is to remain in the same state
		z = 0; // default output is 0
		case (state)
			S0: begin
				if (x) begin
					next_state = S1;
				end
			end
			S1: begin
				if (!x) begin
					next_state = S2;
				end
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1;
				end else begin
					next_state = S0;
				end
			end
		endcase
	end

endmodule
