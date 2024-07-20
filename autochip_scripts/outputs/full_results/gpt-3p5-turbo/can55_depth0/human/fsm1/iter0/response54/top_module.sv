module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {B, A} State;

	// Declare state and next_state registers
	reg State state;
	reg State next_state;

	// Declare the output register
	reg out;

	// The Moore state machine logic
	always_ff @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// The combinatorial logic for next_state and out
	always_comb
	begin
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 0;
			end
		endcase
	end

endmodule
