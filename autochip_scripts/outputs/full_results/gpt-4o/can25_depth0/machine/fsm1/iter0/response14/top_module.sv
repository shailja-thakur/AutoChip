module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	// Define states
	typedef enum reg {STATE_A, STATE_B} state_t;
	
	// State registers
	reg state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: next_state = (in) ? STATE_A : STATE_B;
			STATE_B: next_state = (in) ? STATE_B : STATE_A;
			default: next_state = STATE_B;
		endcase
	end
	
	// State update logic with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		out = (state == STATE_B);
	end
	
endmodule
