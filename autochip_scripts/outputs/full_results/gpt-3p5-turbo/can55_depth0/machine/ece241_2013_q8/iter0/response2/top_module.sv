module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	enum logic [1:0] state, state_next;
	
	always_ff @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S;
		else
			state <= state_next;
	end
	
	always_comb begin
		case (state)
			S: begin
				if (x == 0)
					state_next = S;
				else if (x == 1)
					state_next = S1;
			end
			
			S1: begin
				if (x == 0)
					state_next = S10;
				else if (x == 1)
					state_next = S1;
			end
			
			S10: begin
				if (x == 0)
					state_next = S;
				else if (x == 1)
					state_next = S1;
			end
		endcase
	end
	
	always_comb begin
		case (state)
			S, S1: z = 0;
			S10: z = x;
		endcase
	end

endmodule
