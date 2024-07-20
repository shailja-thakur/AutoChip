module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	// Define states
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;

	// Sequential logic for state transition
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= OFF; // Asynchronous reset
		else 
			state <= next_state;
	end

	// Combinational logic for state transition
	always @(*) begin
		case (state)
			OFF: begin
				if (j)
				    next_state = ON;
				else
				    next_state = OFF;
			end
			ON: begin
				if (k)
				    next_state = OFF;
				else
				    next_state = ON;
			end
			default: begin
				next_state = OFF; // Default to OFF state
			end
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
			default: out = 0;
		endcase
	end

endmodule
