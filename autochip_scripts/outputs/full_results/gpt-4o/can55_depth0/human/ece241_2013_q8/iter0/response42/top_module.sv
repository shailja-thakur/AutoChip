module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// State encoding
	typedef enum reg [1:0] {
		S0, // Initial state
		S1, // State after seeing '1'
		S2  // State after seeing '10'
	} state_t;

	state_t current_state, next_state;

	// State transition
	always @(negedge aresetn, posedge clk) begin
		if (~aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S1; else next_state = S2;
			S2: if (x) next_state = S1; else next_state = S0;
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			z <= 0;
		else if (current_state == S2 && x == 1)
			z <= 1;
		else
			z <= 0;
	end

endmodule
