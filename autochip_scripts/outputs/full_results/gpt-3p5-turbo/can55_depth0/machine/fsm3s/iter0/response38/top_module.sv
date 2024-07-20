module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	// Define the 4 states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_type;
	
	// Define the state and next_state variables
	reg state_type state, next_state;
	
	// Define the output variable
	reg out;
	
	// Define the combinational logic for next_state and out
	always_comb begin
		case (state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
		endcase
		
		if (state == D)
			out = 1'b1;
		else
			out = 1'b0;
	end
	
	// Define the state transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
endmodule
