module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Define states
	typedef enum logic [2:0] {
		S0, S1, S10, G1, G2, P0, P1
	} state_t;
	
	// Define current state
	reg state_t current_state;
	
	// Synchronous always block for state update
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= S0;
		else begin
			case (current_state)
				S0: if (x) current_state <= S1; else current_state <= G1;
				S1: if (x) current_state <= S1; else current_state <= G2;
				S10: if (x) current_state <= G1; else current_state <= S0;
				G1: if (y) current_state <= P1; else current_state <= G2;
				G2: if (y) current_state <= P1; else current_state <= P0;
				P0, P1: current_state <= current_state;
				default: current_state <= S0;
			endcase
		end
	end
	
	// Output assignment
	always @* begin
		f = (current_state == S1);
		g = (current_state == G1 || current_state == G2 || current_state == P1);
	end
	
endmodule
