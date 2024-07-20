module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State declaration
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			OFF: next_state = j ? ON : OFF;
			ON: next_state = k ? OFF : ON;
			default: next_state = OFF;
		endcase
	end

	// State registers with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic (Moore type)
	always @(*) begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
			default: out = 0;
		endcase
	end

endmodule
