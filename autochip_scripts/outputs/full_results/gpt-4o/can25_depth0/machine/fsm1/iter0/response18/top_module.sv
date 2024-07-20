module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum logic [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: if (in) 
				next_state = STATE_A;
				else 
				next_state = STATE_B;
			STATE_B: if (in) 
				next_state = STATE_B;
				else 
				next_state = STATE_A;
			default: next_state = STATE_B; // Default state should be B on reset
		endcase
	end

	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B; // Reset state to B
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b1;
			default: out = 1'b0; // Default output in case of undefined state
		endcase
	end
endmodule
