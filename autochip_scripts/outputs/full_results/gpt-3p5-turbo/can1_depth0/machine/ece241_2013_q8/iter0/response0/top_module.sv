module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define the states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	reg state, next_state;
	
	// Output assignment
	always @(state)
	begin
		case (state)
			S, S1: z = 1'b0;
			S10: z = x;
			default: z = 1'b0;
		endcase
	end
	
	// State transition logic
	always @(posedge clk or negedge aresetn)
	begin
		if (~aresetn)
			state <= S;
		else
			state <= next_state;
	end
	
	// Next state assignment
	always @(state, x)
	begin
		case (state)
			S:
				begin
					if (x)
						next_state = S1;
					else
						next_state = S;
				end
			S1:
				begin
					if (x)
						next_state = S1;
					else
						next_state = S10;
				end
			S10:
				begin
					if (x)
						next_state = S1;
					else
						next_state = S;
				end
			default: next_state = S;
		endcase
	end

endmodule
