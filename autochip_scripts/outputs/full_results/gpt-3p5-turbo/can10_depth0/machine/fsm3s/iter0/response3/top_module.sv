module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;
	
	// Define the state variable and initialize it to A
	reg state_type current_state, next_state;
	initial current_state = A;
	
	// Assign next_state based on the current_state and input values
	always @ (posedge clk) begin
		if (reset)
			next_state = A;
		else begin
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
	end
	
	// Update the current_state with next_state
	always @ (posedge clk) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Assign the output value
	always @ (current_state) begin
		if (current_state == D)
			out = 1;
		else
			out = 0;
	end
	
endmodule
