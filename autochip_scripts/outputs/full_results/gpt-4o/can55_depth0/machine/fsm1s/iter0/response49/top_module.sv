module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	parameter A = 1'b0, B = 1'b1;
	
	// State register
	reg state, next_state;
	
	// State transition logic (combinational)
	always @(*) begin
		case(state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B; // Default case to avoid inferred latches
		endcase
	end
	
	// State register update (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // reset state
		else
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		out = (state == B) ? 1'b1 : 1'b0;
	end

endmodule
