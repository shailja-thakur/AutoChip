module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Declare the 4 states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;
	
	// Declare variables for current and next state
	state_type current_state;
	state_type next_state;

	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	always_comb begin
		// Default next state to current state
		next_state = current_state;

		case(current_state)
			A:
				if (in == 1)
					next_state = B;
				else
					next_state = A;
			B:
				if (in == 1)
					next_state = B;
				else
					next_state = C;
			C:
				if (in == 1)
					next_state = D;
				else
					next_state = A;
			D:
				if (in == 1)
					next_state = B;
				else
					next_state = C;
		endcase

		// Set the output based on the current state
		if (current_state == D)
			out = 1;
		else
			out = 0;
	end
	
endmodule
