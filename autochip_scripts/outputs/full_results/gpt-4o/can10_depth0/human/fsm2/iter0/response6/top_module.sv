module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// States
	typedef enum logic {OFF, ON} state_t;
	state_t state, next_state;

	// State transition
	always @(*) begin
		case (state)
			OFF: if (j) next_state = ON;
				else next_state = OFF;
			ON: if (k) next_state = OFF;
				else next_state = ON;
			default: next_state = OFF;
		endcase
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 0;
		else
			out <= (state == ON);
	end
	
endmodule
