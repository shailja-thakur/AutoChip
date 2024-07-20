module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	// Define states
	typedef enum logic [1:0] {
		OFF = 2'b00,
		ON  = 2'b01
	} state_t;
	
	state_t state, next_state;
	
	// Sequential logic for state transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) 
			state <= OFF;  // reset to OFF state
		else
			state <= next_state; // transition to next state
	end
	
	// Combinational logic for next state
	always_comb begin
		case (state)
			OFF: if (j) 
					next_state = ON;
				 else 
					next_state = OFF;
			ON: if (k) 
					next_state = OFF;
				else 
					next_state = ON;
			default: next_state = OFF;
		endcase
	end
	
	// Output logic based on current state
	always_ff @(posedge clk or posedge areset) begin
		if (areset) 
			out <= 1'b0;
		else
			out <= (state == ON) ? 1'b1 : 1'b0;
	end
endmodule
