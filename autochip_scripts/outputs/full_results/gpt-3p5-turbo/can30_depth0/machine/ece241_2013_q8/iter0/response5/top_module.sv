module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z,
	
	reg state,
	reg next_state
);
	
	// State definitions
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// State register
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S; // Initial state
		else
			state <= next_state; // Next state
	end
	
	// Next state logic
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
			end
			
			S1: begin
				if (x == 0)
					next_state = S10;
				else
					next_state = S1;
			end
			
			S10: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
			end
		endcase
	end
	
	// Output logic
	always @(state or x) begin
		case (state)
			S, S1: z = 0;
			S10: z = x;
		endcase
	end
	
endmodule
