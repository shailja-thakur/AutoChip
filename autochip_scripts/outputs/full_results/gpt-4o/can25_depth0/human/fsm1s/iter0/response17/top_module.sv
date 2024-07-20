module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State declarations
	typedef enum logic [0:0] {STATE_A, STATE_B} state_t;
	
	// Register to hold the current and next state
	state_t current_state, next_state;

	// Sequential logic for state transition
	always @(posedge clk) begin
		if (reset) 
			current_state <= STATE_B;  // Assign the reset state B
		else 
			current_state <= next_state;
	end

	// Combinational logic for state machine
	always @* begin
		// Default next state is the current state
		next_state = current_state;

		case (current_state)
			STATE_B: begin
				out = 1;
				if (in == 0) 
					next_state = STATE_A;
			end
			STATE_A: begin
				out = 0;
				if (in == 0) 
					next_state = STATE_B;
			end
		endcase
	end
endmodule
