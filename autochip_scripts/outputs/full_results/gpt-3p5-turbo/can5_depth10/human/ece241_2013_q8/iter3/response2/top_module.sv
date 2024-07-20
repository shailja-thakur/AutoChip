module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	reg [1:0] state;
	reg prev_x;
	reg [1:0] next_state;
	
	// Define the next state logic
	always @ (posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Define the next state logic
	always @* begin
		case(state)
			S0: begin
				if(x && !prev_x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if(x && !prev_x)
					next_state = S2;
				else if(!x)
					next_state = S0;
				else
					next_state = S1;
			end
			S2: begin
				if(!x && prev_x)
					next_state = S0;
				else
					next_state = S2;
			end
		endcase
	end
	
	// Define the output logic
	always @* begin
		if(state == S2)
			z = 1'b1;
		else
			z = 1'b0;
	end
	
	// Assign the previous value of x
	assign prev_x = x;
	
endmodule
