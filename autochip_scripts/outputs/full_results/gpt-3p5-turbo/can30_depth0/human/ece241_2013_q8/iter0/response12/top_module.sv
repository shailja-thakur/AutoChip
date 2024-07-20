module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	reg [2:0] state;
	parameter S0 = 0, S1 = 1, S2 = 2;

	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S0;
			z <= 0;
		end else begin
			case (state)
				S0: begin
					if (x == 1'b1)
						state <= S1;
				end
				S1: begin
					if (x == 1'b0)
						state <= S0;
					else
						state <= S2;
				end
				S2: begin
					if (x == 1'b1) begin
						state <= S1;
						z <= 1;
					end else
						state <= S0;
				end
			endcase
		end
	end
endmodule
