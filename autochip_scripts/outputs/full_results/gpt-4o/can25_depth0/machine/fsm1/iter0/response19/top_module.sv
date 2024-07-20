module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define states
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Sequential block to update state on clock edge
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;  // Reset to state B
		else
			state <= next_state;  // Transition to next state
	end

	// Combinational block to determine next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
		endcase
	end

	// Output logic
	always @(*) begin
		out = (state == B);
	end

endmodule
