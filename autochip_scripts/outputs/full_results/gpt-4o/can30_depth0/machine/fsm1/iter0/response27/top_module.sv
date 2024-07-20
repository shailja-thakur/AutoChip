module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	// Define states
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Synchronous state transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B; // reset state to B
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B;
		endcase
	end
	
	// Output logic
	always @(*) begin
		out = (state == B);
	end

endmodule
