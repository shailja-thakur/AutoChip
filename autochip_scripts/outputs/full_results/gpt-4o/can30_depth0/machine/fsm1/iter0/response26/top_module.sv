module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
	state_t state, next_state;

	// Sequential logic for state transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Combinational logic for next state
	always @(*) begin
		case (state)
			STATE_A: next_state = in ? STATE_A : STATE_B;
			STATE_B: next_state = in ? STATE_B : STATE_A;
			default: next_state = STATE_B; // Default state if undefined
		endcase
	end
	
	// Output logic
	always @(*) begin
		out = (state == STATE_B) ? 1'b1 : 1'b0;
	 end

endmodule
