module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states
	typedef enum logic [3:0] {
		A,
		B,
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state_t;
	
	// Declare state and next_state signals
	reg state_t state, next_state;

	// Next state logic
	always_ff @(posedge clk, negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	// State transition logic
	always_comb begin
		case (state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = S0;
			end
			B: begin
				next_state = S0;
			end
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
			end
			S10: begin
				if (x)
					next_state = G1;
				else
					next_state = S0;
			end
			G1: begin
				if (y)
					next_state = P1;
				else
					next_state = G2;
			end
			G2: begin
				if (y)
					next_state = P1;
				else
					next_state = P0;
			end
			P0: begin
				next_state = P0;
			end
			P1: begin
				next_state = P1;
			end
			default: next_state = A;
		endcase
	end
	
	// Output assignments
	always_comb begin
		case (state)
			B: f = 1;
			G1, G2, P1: g = 1;
			default: f = 0; g = 0;
		endcase
	end
endmodule
