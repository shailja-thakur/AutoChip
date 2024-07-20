module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00,  // Initial state
		S1 = 2'b01,  // State after seeing '1'
		S2 = 2'b10   // State after seeing '10'
	} state_t;

	state_t state, next_state;

	// State transition logic
	always_comb begin
		case(state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S1; else next_state = S2;
			S2: if (x) next_state = S1; else next_state = S0;
			default: next_state = S0; // default state
		endcase
	end

	// State register with asynchronous reset(negative edge)
	always_ff @(negedge aresetn, posedge clk) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Output logic
	always_comb begin
		case (state)
			S0: z = 0;
			S1: z = 0;
			S2: z = x ? 1 : 0;
			default: z = 0;
		endcase
	end

endmodule
