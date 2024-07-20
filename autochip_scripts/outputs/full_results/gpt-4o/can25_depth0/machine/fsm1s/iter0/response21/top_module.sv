module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	// State definitions
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state;
	reg next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: begin
				if (in == 1'b1)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (in == 1'b1)
					next_state = B;
				else
					next_state = A;
			end
			default: next_state = A; // Default to A
		endcase
	end

	// Synchronous process to update state register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Reset state to B
		else
			state <= next_state;
	end

	// Output assignment
	always @(*) begin
		if (state == B)
			out = 1'b1;
		else
			out = 1'b0;
	end
endmodule
