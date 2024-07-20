module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Parameter definitions
	parameter A = 1'b0, B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic block to determine the next state
	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = A; // Default state
		endcase
	end

	// Synchronous block to update the state register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state; // Update state to next_state
	end

	// Output logic
	always @(posedge clk) begin
		out <= (state == B) ? 1'b1 : 1'b0;
	end

endmodule
