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
	reg [2:0] count;
	reg prev_x;
	
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
					else
						state <= S1;
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
	
	always @(state) begin
		if (state == S2)
			count <= count + 1;
		else
			count <= 0;
	end
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			z <= 0;
		else begin
			if (count == 2)
				z <= 1;
			else
				z <= 0;
		end
	end
	
	assign prev_x = x;
	
endmodule
