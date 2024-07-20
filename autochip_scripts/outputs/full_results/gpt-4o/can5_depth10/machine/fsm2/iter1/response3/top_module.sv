module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum reg { STATE_A, STATE_B } state_t;
	state_t state, next_state;
	
	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			STATE_A: next_state = (j) ? STATE_B : STATE_A;
			STATE_B: next_state = (k) ? STATE_A : STATE_B;
			default: next_state = STATE_A; // Default state
		endcase
	end
	
	// Clocked always block to update the state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_A; // Reset to state A
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		out = (state == STATE_B) ? 1 : 0;
		end

endmodule
