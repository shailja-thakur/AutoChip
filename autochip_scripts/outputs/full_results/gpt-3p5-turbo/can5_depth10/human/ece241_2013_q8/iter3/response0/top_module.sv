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
	reg [2:0] shift_reg;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x == 1'b0)
						state <= S0;
					else if (x == 1'b1)
						state <= S1;
				end
				
				S1: begin
					if (x == 1'b0)
						state <= S0;
					else if (x == 1'b1)
						state <= S1;
					else if (shift_reg == 3'b101)
						state <= S2;
				end
				
				S2: begin
					state <= S0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (aresetn == 1'b0)
			shift_reg <= 3'b0;
		else begin
			if (state == S2)
				shift_reg <= 3'b0;
			else begin
				shift_reg[2] <= shift_reg[1];
				shift_reg[1] <= shift_reg[0];
				shift_reg[0] <= x;
			end
		end
	end
	
	always @(posedge clk) begin
		if (state == S2)
			z <= 1'b1;
		else
			z <= 1'b0;
	end
	
endmodule
