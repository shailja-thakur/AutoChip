module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	typedef enum logic [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after seeing '1'
		S2 = 2'b10  // State after seeing '10'
	} state_t;

	state_t state, next_state;

	// State transition on negative edge of aresetn or positive edge of clk
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
		end

	// Next state logic
	always @(*) begin
		case (state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S1; else next_state = S2;
			S2: if (x) next_state = S1; else next_state = S0;
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			z <= 0;
		else if (state == S2 && x)
			z <= 1;
		else
			z <= 0;
	end
endmodule
