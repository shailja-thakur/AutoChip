module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {STATE_A, STATE_B} state_t;
	state_t state, next_state;

	// Next state logic
	always @(*) begin
		case (state)
			STATE_A: if (in) next_state = STATE_A; else next_state = STATE_B;
			STATE_B: if (in) next_state = STATE_B; else next_state = STATE_A;
		endcase
	end

	// State register and output logic
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
