module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// Define the states
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	// Define the next states and outputs for each state and input combination
	reg [1:0] state, next_state;
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	reg next_z;
	always @* begin
		next_state = state;
		case (state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
				next_z = 0;
			end
			S1: begin
				if (x)
					next_state = S2;
				else
					next_state = S0;
				next_z = 0;
			end
			S2: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
				next_z = 0;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (~aresetn)
			z <= 0;
		else
			z <= next_z;
	end
endmodule
