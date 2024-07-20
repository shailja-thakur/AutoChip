module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State encoding
	parameter S0 = 1'b0, S1 = 1'b1;

	// State registers
	reg state, next_state;

	// Sequential block for state transitions
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			S0: if (x) next_state = S1; else next_state = S0;
			S1: next_state = S1;
			default: next_state = S0;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			S0: z = x;       // Output is the same as input initially
			S1: z = ~x;      // Complement the input after the first 1
			default: z = x;
		endcase
	end
	
endmodule
