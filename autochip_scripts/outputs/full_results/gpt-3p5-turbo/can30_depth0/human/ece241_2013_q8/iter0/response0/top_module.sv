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
	reg z_next;
	
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S0;
			z_next <= 1'b0;
		end else begin
			case (state)
				S0: begin
					if (x == 1'b1)
						state <= S1;
					else
						state <= S0;
						
					z_next <= 1'b0;
				end
				
				S1: begin
					if (x == 1'b0)
						state <= S2;
					else
						state <= S1;
						
					z_next <= 1'b0;
				end
				
				S2: begin
					if (x == 1'b1) begin
						state <= S1;
						z_next <= 1'b1;
					end else begin
						state <= S0;
						z_next <= 1'b0;
					end
				end
					
				default: begin
					state <= S0;
					z_next <= 1'b0;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		z <= z_next;
	end
endmodule
