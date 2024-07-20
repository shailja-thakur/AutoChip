module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'd0,  // Initial state
		S1 = 2'd1,  // State after seeing '1'
		S2 = 2'd2   // State after seeing '10'
	} state_t;
	
	state_t state, next_state;

	// State transition
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic and output logic
	always_comb begin
		z = 0;
		case (state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S2;
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1;  // Recognize "101" sequence
				end else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
	end
endmodule
