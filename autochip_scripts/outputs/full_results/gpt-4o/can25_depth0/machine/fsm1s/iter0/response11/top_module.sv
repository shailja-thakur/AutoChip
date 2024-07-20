module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State Encoding
	parameter A = 1'b0, B = 1'b1;
	
	// Register to hold the current state
	reg state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A; // Default to state A
		endcase
	end

	// Sequential logic to update the current state
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset to initial state B
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B);

endmodule
