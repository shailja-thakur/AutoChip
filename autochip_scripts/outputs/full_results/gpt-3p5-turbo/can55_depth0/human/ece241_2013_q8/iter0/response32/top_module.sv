module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state;
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn)
			state <= 0;
		else begin
			case (state)
				0: begin
					if (x == 1)
						state <= 1;
					else
						state <= 0;
				end
				1: begin
					if (x == 0)
						state <= 2;
					else if (x == 1)
						state <= 1;
					else
						state <= 0;
				end
				2: begin
					if (x == 1)
						state <= 3;
					else if (x == 0)
						state <= 0;
					else
						state <= 0;
				end
				default: state <= 0;
			endcase
		end
	end
	
	always @(state, x) begin
		if (state == 3)
			z <= 1;
		else
			z <= 0;
	end
	
endmodule
