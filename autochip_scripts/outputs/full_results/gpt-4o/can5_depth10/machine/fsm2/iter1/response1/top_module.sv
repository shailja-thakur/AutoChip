module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum logic { A, B } state_t;
	state_t state, next_state;
	
	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
			default: next_state = A; // Default state
		endcase
	end
	
	// Clocked always block to update the state
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A; // Reset to state A
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		out = (state == B) ? 1 : 0;
	end

endmodule
