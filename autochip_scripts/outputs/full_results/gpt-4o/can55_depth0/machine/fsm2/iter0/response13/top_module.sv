module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);
	// Define state encoding
	typedef enum logic {A, B} state_t;
	state_t state, next_state;

	// Combinational block to determine the next state
	always_comb begin
		case (state)
			A: if (j)
				next_state = B;
			   else
				next_state = A;
			B: if (k)
				next_state = A;
			   else
				next_state = B;
			default: next_state = A;
		endcase
	end

	// Sequential block to update the current state
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			out <= 0;
		else
			out <= (state == B);
	end

endmodule
