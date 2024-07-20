module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	// Define states
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_type;
	
	state_type current_state, next_state;
	
	// Register to hold the current state
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Determine next state based on current state and input w
	always_comb begin
		case (current_state)
			A: next_state = (w) ? A : B;
			B: next_state = (w) ? D : C;
			C: next_state = (w) ? D : E;
			D: next_state = (w) ? A : F;
			E: next_state = (w) ? D : E;
			F: next_state = (w) ? D : C;
		endcase
	end
	
	// Output z is high when current state is E or F, low otherwise
	assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;
	
endmodule
