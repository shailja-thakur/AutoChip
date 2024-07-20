module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
	// Define the states
	parameter S1 = 2'b00;
	parameter S2 = 2'b01;
	parameter S3 = 2'b10;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= S1;
		else
			state <= next_state;
	end
	
	always @(state or x) begin
		// Next state logic
		case(state)
			S1: if (x == 1'b1)
					next_state = S2;
				else
					next_state = S1;	
			
			S2: if (x == 1'b0)
					next_state = S3;
				else if (x == 1'b1)
					next_state = S2;
				else
					next_state = S1;
			
			S3: if (x == 1'b0)
					next_state = S1;
				else
					next_state = S3;
		endcase
		
		// Output logic
		if (state == S2 && next_state == S3)
			z = 1'b1;
		else
			z = 1'b0;
	end
	
endmodule
