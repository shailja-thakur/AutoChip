module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// definition of states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;

	// state register
	reg state_type current_state, next_state;

	always_ff @(posedge clk or posedge reset)
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;

	always_comb
		case (current_state)
			A:
				if (in)
					next_state = B;
				else
					next_state = A;
			B:
				if (in)
					next_state = B;
				else if (reset)
					next_state = A;
				else
					next_state = C;
			C:
				if (in)
					next_state = D;
				else if (reset)
					next_state = A;
				else
					next_state = C;
			D:
				if (in)
					next_state = B;
				else if (reset)
					next_state = A;
				else
					next_state = C;
		endcase

	assign out = (current_state == D) ? 1'b1 : 1'b0;

endmodule
