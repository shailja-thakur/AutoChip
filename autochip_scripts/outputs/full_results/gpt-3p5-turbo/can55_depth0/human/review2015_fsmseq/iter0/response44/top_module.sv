module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting); // Added reg keyword for start_shifting
	
	// Define states
	typedef enum logic [1:0] {
		IDLE,
		S0,
		S1,
		S2,
		S3
	} state_t;
	
	// Define signals
	state_t current_state, next_state; // Added state_t for current_state and next_state
	
	// Define combinational logic
	always_comb begin
		case (current_state)
			IDLE: if (data) next_state = S0; // Go to S0 if data is high
			S0: if (data) next_state = S1; else next_state = S0; // Stay in S0 if data is high, else go back to S0
			S1: if (data) next_state = S2; else next_state = S0; // Go to S2 if data is high, else go back to S0
			S2: if (data) next_state = S3; else next_state = S0; // Go to S3 if data is high, else go back to S0
			S3: if (data) begin
					start_shifting = 1; // Set start_shifting to 1 if data is high in S3
					next_state = IDLE; // Go back to IDLE state
				end 
				else next_state = S0; // Go back to S0 if data is low in S3
			default: next_state = IDLE; // Default to IDLE state
		endcase
	end
	
	// Define sequential logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= IDLE; // Reset the FSM to IDLE state
			start_shifting <= 0; // Reset start_shifting to 0
		end
		else begin
			current_state <= next_state; // Update current_state with next_state
		end
	end
endmodule
