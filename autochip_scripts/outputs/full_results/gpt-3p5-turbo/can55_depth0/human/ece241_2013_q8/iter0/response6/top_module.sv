module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
	
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	
	reg [1:0] state, next_state;
	
	always @ (posedge clk, negedge aresetn) begin
		if (~aresetn)
			state <= S0;
		else
			state <= next_state;
	end
	
	always @* begin
		case (state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S2;
			end
			
			S2: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
		endcase
	end
	
	always @(state) begin
		if (state == S2)
			z = 1'b1;
		else
			z = 1'b0;
	end
	
endmodule
