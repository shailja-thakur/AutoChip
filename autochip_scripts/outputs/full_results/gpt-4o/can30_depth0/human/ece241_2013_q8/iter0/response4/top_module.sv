module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State definitions
	typedef enum logic [1:0] {
		S0, // Initial state
		S1, // State after seeing '1'
		S2  // State after seeing '10'
	} state_t;
	
	state_t state, next_state;
	
	// State transition logic (Mealy)
	always @(*) begin
		case (state)
			S0: begin
				if (x) next_state = S1;
				else next_state = S0;
			end
			S1: begin
				if (x) next_state = S1;
				else next_state = S2;
			end
			S2: begin
				if (x) next_state = S1;
				else next_state = S0;
			end
			default: next_state = S0;
		endcase
	end
	
	// State flip-flops with asynchronous reset
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn) state <= S0;
		else state <= next_state;
	end
	
	// Output logic (Mealy)
	always @(*) begin
		case (state)
			S0: z = 0;
			S1: z = 0;
			S2: z = x; // Output '1' if in S2 and see '1' (sequence "101")
			default: z = 0;
		endcase
	end

endmodule
