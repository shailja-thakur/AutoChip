module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Declare the states
	typedef enum logic [3:0] {
		A,
		B,
		C,
		S10,
		S11,
		S20,
		S21,
		S22
	} state_t;

	// Declare the current and next states
	reg state_t current_state;
	reg state_t next_state;

	// Initialize the state
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Assign the next state based on the current state and input signals
	always_comb begin
		case (current_state)
			A:
				if (s)
					next_state = B;
			B, C:
				if (w)
					next_state = S11;
				else
					next_state = S10;
			S10:
				if (w)
					next_state = S21;
				else
					next_state = S20;
			S11:
				if (w)
					next_state = S22;
				else
					next_state = S21;
			S20:
				next_state = B;
			S21:
				if (w)
					next_state = C;
				else
					next_state = B;
			S22:
				if (w)
					next_state = B;
				else
					next_state = C;
			default:
				next_state = A;
		endcase
	end

	// Assign the output z based on the current state
	always_comb begin
		case (current_state)
			B, C, S10, S11, S21, S22:
				z = 1'b1;
			default:
				z = 1'b0;
		endcase
	end

endmodule
