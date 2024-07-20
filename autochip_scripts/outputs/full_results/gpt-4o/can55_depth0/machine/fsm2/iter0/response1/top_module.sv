module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define the states
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Combinational block to determine next state
	always @(*) begin
		case (state)
			A: if (j) next_state = B;
				else next_state = A;
			B: if (k) next_state = A;
				else next_state = B;
			default: next_state = A;
		endcase
	end

	// Sequential block to update state on clock or reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	assign out = (state == B);

endmodule
