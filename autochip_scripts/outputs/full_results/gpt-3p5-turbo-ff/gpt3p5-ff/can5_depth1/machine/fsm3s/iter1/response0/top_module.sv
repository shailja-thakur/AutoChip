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
	begin
		case (current_state)
			A:
				if (in)
					next_state = B;
				else
					next_state = A;
			B:
				if (in)
					next_state = B;
				else
					next_state = C;
			C:
				if (in)
					next_state = D;
				else
					next_state = A;
			D:
				if (in)
					next_state = B;
				else
					next_state = C;
		endcase
	end

	assign out = (current_state == D) ? 1'b1 : 1'b0;

endmodule
