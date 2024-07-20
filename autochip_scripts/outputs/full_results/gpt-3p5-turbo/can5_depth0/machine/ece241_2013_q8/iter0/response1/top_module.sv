module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z,
	
	reg state,
	reg next_state
);

	// Define the states
	localparam S = 0;
	localparam S1 = 1;
	localparam S10 = 2;
	
	always @(posedge clk or negedge aresetn)
	begin
		if (~aresetn)
			state <= S;
		else
			state <= next_state;
	end
	
	always @(state, x)
	begin
		case (state)
			S:
				begin
					if (x == 1)
						next_state = S1;
					else
						next_state = S;
					z = 0;
				end
			S1:
				begin
					if (x == 1)
						next_state = S1;
					else
						next_state = S10;
					z = 0;
				end
			S10:
				begin
					if (x == 1)
						next_state = S1;
					else
						next_state = S;
					z = x;
				end
		endcase
	end

endmodule
