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
	wire prev_x;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x && !prev_x)
						state <= S1;
					else
						state <= S0;
				end
				
				S1: begin
					if (x && !prev_x)
						state <= S2;
					else if (x)
						state <= S1;
					else
						state <= S0;
				end
				
				S2: begin
					if (!x && prev_x)
						state <= S0;
					else
						state <= S2;
				end
			endcase
		end
	end
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			prev_x <= 1'b0;
		else
			prev_x <= x;
	end
	
	always @(state) begin
		if (state == S2)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
	
endmodule
