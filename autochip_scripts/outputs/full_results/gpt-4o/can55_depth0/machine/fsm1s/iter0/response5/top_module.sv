module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State encoding
	parameter A = 1'b0;
	parameter B = 1'b1;

	// State register
	reg state, next_state;

	// Combinational logic to determine next state
	always @(*) begin
		case (state)
			A: next_state = in ? A : B;
			B: next_state = in ? B : A;
			default: next_state = B; // Default state
		endcase
	end

	// Sequential logic to update the state register
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B; // Initial state is B
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B);

endmodule
