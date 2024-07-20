module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg state, next_state;

	// Parameters to define states
	parameter A = 1'b0, B = 1'b1;

	// Sequential logic for state transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;  // Reset state to A
		else
			state <= next_state;
	end

	// Combinational logic for next state determination
	always @(*) begin
		case (state)
			A: 
				if (x)
					next_state = B;
				else
					next_state = A;
			B: 
				next_state = B;  // Remain in state B
			default: 
				next_state = A;  // Default to state A
		endcase
	end

	// Combinational logic for output z
	always @(*) begin
		case (state)
			A: z = x ? 1'b1 : 1'b0;  // z is 1 when in state A and x is 1
			B: z = x ? 1'b0 : 1'b1;  // z is 1 when in state B and x is 0
			default: z = 1'b0;       // Default output
		endcase
	end
endmodule
