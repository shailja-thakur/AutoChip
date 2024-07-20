module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {STATE_A, STATE_B} state_t;
	state_t state, next_state;

	// Combinational always block to determine next state
	always @(*) begin
		case (state)
			STATE_A: next_state = j ? STATE_B : STATE_A;
			STATE_B: next_state = k ? STATE_A : STATE_B;
			default: next_state = STATE_A;
		endcase
	end

	// Clocked always block to update current state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_A;  // Reset state to A
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1'b0;  // Default state A output
		else
			out <= (state == STATE_B) ? 1'b1 : 1'b0;  // High for state B, low for state A
	end

endmodule
