module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [1:0] state;
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0;
		else begin
			case (state)
				S0: begin
					if (x)
						state <= S1;
				end
				S1: begin
					if (x)
						state <= S2;
					else
						state <= S0;
				end
				S2: begin
					if (!x)
						state <= S0;
					else
						state <= S2;
				end
				default: state <= S0;
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			S0: z <= 0;
			S1: z <= 0;
			S2: z <= 1;
			default: z <= 0;
		endcase
	end
endmodule
