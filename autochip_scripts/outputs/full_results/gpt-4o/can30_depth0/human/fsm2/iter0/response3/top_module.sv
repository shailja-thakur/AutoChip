module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case(state)
			OFF: if (j) next_state = ON; else next_state = OFF;
			ON: if (k) next_state = OFF; else next_state = ON;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case(state)
			OFF: out = 0;
			ON: out = 1;
		endcase
	end

endmodule
