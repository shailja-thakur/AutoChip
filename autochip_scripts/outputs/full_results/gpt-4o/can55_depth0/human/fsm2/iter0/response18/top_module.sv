module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {
		OFF = 1'b0,
		ON = 1'b1
	} state_t;
	
	state_t state, next_state;
	
	// Asynchronous reset and state transition
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= OFF;
		else 
			state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case (state)
			OFF: next_state = (j == 1) ? ON : OFF;
			ON: next_state = (k == 1) ? OFF : ON;
			default: next_state = OFF; // Default state
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		if (areset)
			out <= 0;
		else
			out <= (state == ON) ? 1 : 0;
	end
	
endmodule
