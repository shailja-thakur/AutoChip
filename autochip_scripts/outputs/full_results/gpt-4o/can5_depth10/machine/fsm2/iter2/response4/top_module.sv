module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define state encoding
	localparam A = 1'b0, B = 1'b1;
	reg state, next_state;

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
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
