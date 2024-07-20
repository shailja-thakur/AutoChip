module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in == 1)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end
			STATE_B: begin
				if (in == 1)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			default: next_state = STATE_B; // Default to state B in case of invalid state
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_A: out = 0;
			STATE_B: out = 1;
			default: out = 1; // Default output
		endcase
	end

endmodule
