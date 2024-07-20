module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define the states as parameters
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B; // Default state
		endcase
	end

	// Sequential logic to update state on rising edge of clk or on reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == B) ? 1'b1 : 1'b0;
		end
		
endmodule
