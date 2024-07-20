module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Combinational always block to determine next state
	always @(*) begin
		case (state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
			default: next_state = A; // Default state
		endcase
	end

	// Clocked always block to update the current state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset state to A
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
