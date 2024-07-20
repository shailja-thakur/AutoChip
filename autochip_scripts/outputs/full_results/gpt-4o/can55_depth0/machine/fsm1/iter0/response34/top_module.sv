module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define the states
	typedef enum reg {STATE_A, STATE_B} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: if (in) next_state = STATE_A;
			         else next_state = STATE_B;
			STATE_B: if (in) next_state = STATE_B;
			         else next_state = STATE_A;
			default: next_state = STATE_B; // default state in case of unexpected state
		endcase
	end

	// State updating logic
	always @(posedge clk or posedge areset) begin
		if (areset) state <= STATE_B; // Reset state to B
		else state <= next_state;     // Update state to next state
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) out <= 1'b1;    // Output is high when reset state is B
		else if (state == STATE_B) out <= 1'b1;
		else out <= 1'b0;
	end

endmodule
