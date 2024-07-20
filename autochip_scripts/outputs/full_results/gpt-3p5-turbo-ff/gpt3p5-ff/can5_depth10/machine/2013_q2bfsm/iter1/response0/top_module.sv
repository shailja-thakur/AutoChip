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
		A, B, S0, S1, S10, G1, G2, P0, P1
	} state_t;
	
	// Define current state and next state
	reg state_t current_state, next_state;
	
	// Synchronous always block for state update
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Combinational always block for next state logic
	always @(*) begin
		case (current_state)
			A: if (x) next_state = B; else next_state = S0;
			B: next_state = S0;
			S0: if (x) next_state = S1; else next_state = S0;
			S1: if (x) next_state = S1; else next_state = S10;
			S10: if (x) next_state = G1; else next_state = S0;
			G1: if (y) next_state = P1; else next_state = G2;
			G2: if (y) next_state = P1; else next_state = P0;
			P0, P1: next_state = current_state;
		endcase
	end
	
	// Output assignment
	always @(posedge clk) begin
		f <= (current_state == B);
		g <= (current_state == G1 || current_state == G2 || current_state == P1);
	end
	
endmodule
