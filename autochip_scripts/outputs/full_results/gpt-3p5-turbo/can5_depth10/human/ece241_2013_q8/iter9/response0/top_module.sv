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
	reg [1:0] next_state;
	reg prev_x;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	always @* begin
		next_state = state;
		
		case (state)
			S0: begin
				if (x && !prev_x)
					next_state = S1;
			end
			
			S1: begin
				if (x && !prev_x)
					next_state = S2;
				else
					next_state = S0;
			end
			
			S2: begin
				if (!x && prev_x)
					next_state = S0;
			end
		endcase
	end
	
	always @(state or x) begin
		if (state == S2)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
	
	assign prev_x = x;
	
endmodule
