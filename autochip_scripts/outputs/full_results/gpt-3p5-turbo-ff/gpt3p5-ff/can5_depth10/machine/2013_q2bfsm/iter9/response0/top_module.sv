module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output wire f,
	output wire g
);

	// Define states
	typedef enum logic [3:0] {
		A, B, S0, S1, S10, G1, G2, P0, P1
	} state_t;
	
	// Define current state and next state
	reg state_t current_state;
	wire state_update;
	
	// State update logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= state_update;
	end
	
	// Combinational logic for next state
	always @(current_state or x) begin
		case (current_state)
			A: if (x) state_update = B; else state_update = S0;
			B: state_update = S0;
			S0: if (x) state_update = S1; else state_update = S0;
			S1: if (x) state_update = S1; else state_update = S10;
			S10: if (x) state_update = G1; else state_update = S0;
			G1: if (y) state_update = P1; else state_update = G2;
			G2: if (y) state_update = P1; else state_update = P0;
			P0, P1: state_update = current_state;
		endcase
	end
	
	// Output assignment
	assign f = (current_state == B);
	assign g = (current_state == G1 || current_state == G2 || current_state == P1);
	
endmodule
