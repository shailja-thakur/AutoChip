module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State declarations
	typedef enum logic {A, B} state_t;
	state_t state, next_state;

	// Combinational logic block for next state logic
	always_comb begin
		case (state)
			A: if (in) 
					next_state = A;
				else 
					next_state = B;
			B: if (in) 
					next_state = B;
				else 
					next_state = A;
			default: 
				next_state = B; // Default state should be B
		endcase
	end

	// Sequential logic block for state transitions
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset to state B
		else
			state <= next_state;
	end

	// Output logic
	always_comb begin
		out = (state == B); // Output is high when in state B
	end

endmodule
