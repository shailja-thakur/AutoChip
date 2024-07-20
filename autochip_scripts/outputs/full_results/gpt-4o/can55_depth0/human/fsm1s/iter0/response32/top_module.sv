module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {B, A} state_t;
	state_t state, next_state;

	// State transition logic
	always @(posedge clk) begin
		if (reset)
			state <= B; // Synchronous reset to state B
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			B: 
				if (in) 
					next_state = B;
				else 
					next_state = A;
			A: 
				if (in) 
					next_state = A;
				else 
					next_state = B;
			default: 
					next_state = B; // Should not happen
		endcase
	end
	
	// Output logic
	always @(*) begin
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1; // Should not happen
		endcase
	end

endmodule
