module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	// State encoding
	parameter A = 1'b0, B = 1'b1;

	// State variable
	reg state;
	reg next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = (in) ? A : B;
			B: next_state = (in) ? B : A;
			default: next_state = B;  // Default to state B
		endcase
	end

	// Sequential logic to update state on rising clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;  // Reset state to B
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state) begin
		out = (state == B) ? 1'b1 : 1'b0;
		end

endmodule
