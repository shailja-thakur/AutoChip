module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Declare state encoding
	typedef enum reg {A = 1'b0, B = 1'b1} state_t;
	state_t state, next_state;

	// Asynchronous reset, transition logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B; // Reset to state B
		else
			state <= next_state;
	end

	// Next state logic
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
			default: next_state = B; // Default to state B
		endcase
	end

	// Output logic (Moore output)
	always @(*) begin
		case (state)
			A: out = 1'b0;
			B: out = 1'b1;
			default: out = 1'b1;
		endcase
	end

endmodule
