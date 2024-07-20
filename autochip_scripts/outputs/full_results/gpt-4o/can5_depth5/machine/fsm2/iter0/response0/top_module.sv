module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Next state logic
	always @(*) begin
		case (state)
			A: if (j) next_state = B;
			   else next_state = A;
			B: if (k) next_state = A;
			   else next_state = B;
			default: next_state = A; // Default state
		endcase
	end

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (state == B)
			out = 1;
		else
			out = 0;
	end

endmodule
