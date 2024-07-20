module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// state enumeration
	typedef enum logic [1:0] {
		S,
		S1,
		S10
	} state_t;
	
	reg state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S;
		end
		else begin
			state <= next_state;
		end
	end
	
	always_comb begin : logic_comb
		case (state)
			S: begin
				if (x == 0)
					next_state = S;
				else if (x == 1)
					next_state = S1;
			end
			
			S1: begin
				if (x == 0)
					next_state = S10;
				else if (x == 1)
					next_state = S1;
			end
			
			S10: begin
				if (x == 0)
					next_state = S;
				else if (x == 1)
					next_state = S1;
			end
		endcase
	end
	
	always_comb begin : output_comb
		case (state)
			S, S1: z = 0;
			S10: z = x;
		endcase
	end
	
endmodule
