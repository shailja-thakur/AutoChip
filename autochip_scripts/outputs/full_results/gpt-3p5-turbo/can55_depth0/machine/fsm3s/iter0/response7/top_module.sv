module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {A, B, C, D} state_t;
	
	reg state_t current_state, next_state;
	
	always_ff @(posedge clk or posedge reset)
	begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always_comb
	begin
		case (current_state)
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
	end
	
	assign out = (current_state == D) ? 1'b1 : 1'b0;

endmodule
