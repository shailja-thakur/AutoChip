module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
	
	// Define the two states
	parameter A = 1'b0;
	parameter B = 1'b1;

	// Define the current state and next state variables
	reg state, next_state;

	// Assign the initial state as A
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Determine the next state based on the current state and inputs
	always @(state, j, k) begin
		case(state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end

	// Assign the output based on the current state
	always @(state) begin
		if (state == B)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule
