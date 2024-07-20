module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	// Define state enumeration
	typedef enum logic [1:0] {
		B,
		A
	} state_t;
	
	reg state_t current_state, next_state;
	
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= B;
		else
			current_state <= next_state;
	end
	
	always_comb begin
		case (current_state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1'b1;
			end
			
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 1'b0;
			end
		endcase
	end
	
endmodule
