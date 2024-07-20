module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		STATE_A = 1'b0,
		STATE_B = 1'b1
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_comb begin
		case (state)
			STATE_A: next_state = (in) ? STATE_A : STATE_B;
			STATE_B: next_state = (in) ? STATE_B : STATE_A;
			default: next_state = STATE_B; // Default to state B to handle any unintended conditions (safety feature)
		endcase
	end

	// State flip-flops with asynchronous reset
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Output logic
	always_comb begin
		out = (state == STATE_B);
	end

endmodule
