module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

// State encoding
typedef enum reg {STATE_A, STATE_B} state_t;
state_t state, next_state;

// State Transition Logic
always @(*) begin
	case (state)
		STATE_A: next_state = (in) ? STATE_A : STATE_B;
		STATE_B: next_state = (in) ? STATE_B : STATE_A;
		default: next_state = STATE_B; // Default case
	endcase
end

// State Update Logic
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= STATE_B; // Reset to state B
	else
		state <= next_state;
end

// Output Logic
always @(*) begin
	out = (state == STATE_B);
end

endmodule
