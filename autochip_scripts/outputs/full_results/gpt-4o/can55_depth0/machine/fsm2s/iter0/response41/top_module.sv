module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	localparam A = 1'b0;
	localparam B = 1'b1;

	// State variable
	reg state, next_state;

	// State transition
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;  // Initialize to state A on reset
		else
			state <= next_state;  // Transition to the next state on clock edge
	end

	// Next state logic
	always @ (*) begin
		case (state)
			A: begin
				if (j)
					next_state = B;  // Move to state B if j is high
				else
					next_state = A;  // Stay in state A if j is low
			end
			B: begin
				if (k)
					next_state = A;  // Move to state A if k is high
				else
					next_state = B;  // Stay in state B if k is low
			end
			default: next_state = A;  // Default case to handle any unexpected state
		endcase
	end

	// Output logic
	always @ (*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b0;  // Default case to handle any unexpected state
		endcase
	end

endmodule
