module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic {OFF, ON} state_t;
	state_t state, next_state;

	// State transition logic (combinational)
	always_comb begin
		case (state)
			OFF: next_state = j ? ON : OFF;
			ON: next_state = k ? OFF : ON;
			default: next_state = OFF;  // default to OFF to handle invalid states
		endcase
	end

	// State flip-flops with asynchronous reset
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic (based on state)
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			out <= 0;
		else
			out <= (state == ON) ? 1 : 0;
		end
	end
endmodule
