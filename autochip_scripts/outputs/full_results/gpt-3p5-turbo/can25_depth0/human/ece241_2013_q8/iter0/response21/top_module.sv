module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	// State declaration
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	reg [1:0] state;
	reg z_delay;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S0;
			z_delay <= 0;
		end
		else begin
			case (state)
				S0: begin
					if (x == 1'b1)
						state <= S1;
				end
				
				S1: begin
					if (x == 1'b0)
						state <= S2;
				end
				
				S2: begin
					if (x == 1'b1) begin
						state <= S1;
						z_delay <= 1;
					end
					else
						state <= S0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (aresetn == 1'b0)
			z <= 0;
		else
			z <= z_delay;
	end
endmodule
