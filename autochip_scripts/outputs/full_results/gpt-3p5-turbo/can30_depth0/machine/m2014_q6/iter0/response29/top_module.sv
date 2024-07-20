module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	// State enumeration
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_t;
	
	// State register
	reg state_t current_state, next_state;
	
	// Next state logic
	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// State transition and output logic
	always_comb begin
		case (current_state)
			A: begin
				if (w == 1'b0) next_state = B;
				else next_state = A;
			end
			B: begin
				if (w == 1'b1) next_state = D;
				else next_state = C;
			end
			C: begin
				if (w == 1'b1) next_state = D;
				else next_state = E;
			end
			D: begin
				if (w == 1'b1) next_state = A;
				else next_state = F;
			end
			E: begin
				if (w == 1'b1) next_state = D;
				else next_state = E;
			end
			F: begin
				if (w == 1'b1) next_state = D;
				else next_state = C;
			end
		endcase
		
		case (current_state)
			E, F: z = 1'b1;
			default: z = 1'b0;
		endcase
	end
endmodule
