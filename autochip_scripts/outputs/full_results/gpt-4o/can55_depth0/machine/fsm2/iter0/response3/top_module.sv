module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define state encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Combinational always block to determine next state
	always @(*) begin
		case (state)
			A: if (j) next_state = B;
			   else next_state = A;
			B: if (k) next_state = A;
			   else next_state = B;
			default: next_state = A;  // Default to state A
		endcase
	end

	// Clocked always block to update state
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= A;  // Reset state to A
		else 
			state <= next_state;
	end

	// Output logic based on current state
	assign out = (state == B);

endmodule
