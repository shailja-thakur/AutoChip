module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum reg {STATE_A, STATE_B} state_t;
	
	// State registers
	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end
			STATE_B: begin
				if (in)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			default: next_state = STATE_B;
		endcase
	end

	// State update logic - synchronous reset
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
