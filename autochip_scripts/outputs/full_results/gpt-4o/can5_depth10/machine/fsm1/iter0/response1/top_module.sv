module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
	
	// State encoding
	localparam A = 0, B = 1;
	
	// State variables
	reg state, next_state;
	
	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;  // Reset state
		else
			state <= next_state;
	end
	
	// Next state logic
	always @(*) begin
		case(state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = A;  // Default state
		endcase
	end
	
	// Output logic
	always @(*) begin
		out = (state == B) ? 1'b1 : 1'b0;
	end
	
endmodule
