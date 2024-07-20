module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum logic [1:0] {
		S0 = 2'b00, // Initial state
		S1 = 2'b01, // State once 1 is detected
		S2 = 2'b10  // State once 10 is detected
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S0: if (x) next_state = S1;   // 1 detected
			    else next_state = S0;      // Stay in initial state

			S1: if (x) next_state = S1;   // Stay in state S1 if 1 detected again
			    else next_state = S2;      // 10 detected

			S2: if (x) next_state = S1;   // Sequence 101 detected, move to S1
			    else next_state = S0;      // Reset to initial state
			
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*) begin
		z = (state == S2) && x; // Output is 1 when state is S2 and input is 1 (sequence 101 detected)
	end

	// State register with asynchronous reset
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0;           // Asynchronous reset
		else
			state <= next_state;  // Update state
		end
endmodule
