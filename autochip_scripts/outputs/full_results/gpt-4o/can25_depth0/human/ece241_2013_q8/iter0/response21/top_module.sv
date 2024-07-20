module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State after seeing '1'
		S2 = 2'b10  // State after seeing '10'
	} state_t;
	
	state_t current_state, next_state;

	// State transition logic
	always @(*) begin
		case (current_state)
			S0: next_state = x ? S1 : S0;
			S1: next_state = x ? S1 : S2;
			S2: next_state = x ? S1 : S0;
			default: next_state = S0;
		endcase
	end

	// State flip-flops with asynchronous reset
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end

	// Output logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			z <= 1'b0;
		else
			z <= (current_state == S2) && x;
	end

endmodule
