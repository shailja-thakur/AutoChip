module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {S0, S1, S2} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*)
	begin
		case (state)
			S0: next_state = x ? S1 : S0;
			S1: next_state = x ? S1 : S2;
			S2: next_state = x ? S1 : S0;
			default: next_state = S0;
		endcase
	end

	// State register with asynchronous reset
	always @(negedge aresetn, posedge clk)
	begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

	// Output logic
	always @(*)
	begin
		z = (state == S2) && x;
	end

endmodule
