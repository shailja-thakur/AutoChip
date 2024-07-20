module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define state parameters
	parameter A = 1'b0, B = 1'b1;
	
	// Define state register
	reg state, next_state;

	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B; // default state
		endcase
	end

	// Sequential logic block to update state register on rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
