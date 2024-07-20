module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;

	reg [1:0] state;
	reg previous_x;

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= S0;
			previous_x <= 0;
		end else begin
			case(state)
				S0: begin
					if (x && !previous_x)
						state <= S1;
					else
						state <= S0;
				end
				S1: begin
					if (x)
						state <= S2;
					else
						state <= S0;
				end
				S2: begin
					if (!x && previous_x)
						state <= S1;
					else
						state <= S2;
				end
				default: state <= S0;
			endcase
			
			case(state)
				S2: z <= 1;
				default: z <= 0;
			endcase

			previous_x <= x;
		end
	end
endmodule
