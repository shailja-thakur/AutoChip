module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Parameter defining the states
	parameter A = 1'b0, B = 1'b1;
	
	// Register to hold the current state
	reg state, next_state;

	// Combinational logic block to determine next state
	always @(*) begin
		case(state)
			A: if (in) next_state = A;
			   else next_state = B;
			B: if (in) next_state = B;
			   else next_state = A;
			default: next_state = A; // Default to state A if undefined state
		endcase
	end

	// Sequential logic block to update the state register on the rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state; // Update state to next state
	end

	// Output logic
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
