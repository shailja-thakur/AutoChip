module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Create an enum for the states
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
	} state_type;
	
	// Declare state and next_state variables
	reg state_type state, next_state;
	
	// Assign initial state
	initial begin
		state = A;
	end
	
	// Combinational logic for next_state computation
	always_comb begin
		case(state)
			A: next_state = B;
			B: next_state = S0;
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
			P0, P1: next_state = state;
			default: next_state = A;
		endcase
	end
	
	// Synchronous logic for state update and output assignment
	always_ff @(posedge clk, negedge resetn) begin
		if (~resetn) begin
			state <= A;
			f <= 0;
			g <= 0;
		end
		else begin
			state <= next_state;
			f <= (state == B) ? 1 : 0;
			g <= (state == G1 || state == G2 || state == P1) ? 1 : 0;
		end
	end

endmodule
