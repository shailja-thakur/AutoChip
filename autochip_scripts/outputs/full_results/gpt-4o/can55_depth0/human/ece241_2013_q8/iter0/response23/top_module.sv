module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State Encoding
	typedef enum reg [1:0] {
		S0, // Initial/Reset State
		S1, // State after detecting '1'
		S2  // State after detecting '10'
	} state_t;
	
	state_t current_state, next_state;

	// Sequential logic for state transition
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end

	// Combinational logic for next state
	always @* begin
		case (current_state)
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
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @* begin
		case (current_state)
			S2: z = (x) ? 1'b1 : 1'b0; // Detect sequence "101"
			default: z = 1'b0;
		endcase
	end

endmodule
