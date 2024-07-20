module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic to determine the next state
	always @(*) begin
		case (state)
			A: if (in)
					next_state = A;
				else
					next_state = B;
			B: if (in)
					next_state = B;
				else
					next_state = A;
			default: next_state = B; // Safe default state
		endcase
	end

	// State register update logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B);

endmodule
