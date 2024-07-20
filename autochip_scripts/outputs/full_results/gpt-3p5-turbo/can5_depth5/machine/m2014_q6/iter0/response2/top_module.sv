module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// Define the states
	parameter A = 0, B = 1, C = 2, D = 3, E = 4, F = 5;
	reg [2:0] state, next_state;

	// Assign initial state
	always @ (posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Determine next state based on current state and input w
	always @ (state, w) begin
		case (state)
			A: 
				if (w)
					next_state = A;
				else
					next_state = B;
			B: 
				if (w)
					next_state = D;
				else
					next_state = C;
			C: 
				if (w)
					next_state = D;
				else
					next_state = E;
			D: 
				if (w)
					next_state = A;
				else
					next_state = F;
			E: 
				if (w)
					next_state = D;
				else
					next_state = E;
			F: 
				if (w)
					next_state = D;
				else
					next_state = C;
			default: next_state = A;
		endcase
	end

	// Set output z based on current state
	always @ (state) begin
		if (state == E || state == F)
			z = 1;
		else
			z = 0;
	end

endmodule
