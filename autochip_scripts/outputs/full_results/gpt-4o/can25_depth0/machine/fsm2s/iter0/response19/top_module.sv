module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Declare state type
	typedef enum logic [0:0] {A, B} state_t;
	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) 
			state <= A;   // Initialize to state A on reset
		else 
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
		endcase
	end

	// Output logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			out <= 1'b0;    // Output is low when state is A
		else
			out <= (state == B) ? 1'b1 : 1'b0;
	end

endmodule
